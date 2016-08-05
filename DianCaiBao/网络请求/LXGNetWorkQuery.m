//
//  LXGNetWorkQuery.m
//  DCJ-LXG
//
//  Created by mac on 16/6/3.
//  Copyright © 2016年 JR-LXG. All rights reserved.
//

#import "LXGNetWorkQuery.h"
#import "AFNetworking.h"
#define Key @"n'NI&u#+lFA0y@;$6Wj=5(~9"
//MD5加密
#import <objc/runtime.h>
#import <CommonCrypto/CommonCrypto.h>

#define BaseURL @"http://dcj.0791jr.com/app.php?m=App&c=api&a=processing"

@implementation LXGNetWorkQuery
+ (instancetype)shareManager
{
    static LXGNetWorkQuery *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[LXGNetWorkQuery alloc]init];
        
    });
    
    return manager;
}

//--普通请求，不上传文件
- (void)AFrequestData:(NSString*)urlString HttpMethod:(NSString*)method params:(NSMutableDictionary*)parms
     completionHandle:(void(^)(id result))completionBlock errorHandle:(void(^)(NSError* result))errorBlock
{
    AFHTTPSessionManager*manger = [AFHTTPSessionManager manager];
    NSString*json = [self GetJsonWith:urlString dataDic:parms];
    
    
    if ([method isEqualToString:@"GET"]) {
        NSString * url = [NSString stringWithFormat:@"%@&requestData=%@",BaseURL,json];
       // NSString * URL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * URL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [manger GET:URL parameters:parms progress:^(NSProgress * _Nonnull downloadProgress) {
            //进度
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //成功
            //回调block，传递得到的参数
            completionBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //失败
            completionBlock(error);
        }];
    }else if ([method isEqualToString:@"POST"])
    {
        NSDictionary*dicParams = @{
                                @"requestData":json
                                };
        __weak LXGNetWorkQuery*weakSelf = self;
        [manger POST:BaseURL parameters:dicParams progress:^(NSProgress * _Nonnull uploadProgress) {
           
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *errStr = responseObject[@"data"][@"ERROR_Param_Empty"];
            if ([errStr isEqualToString:@"pwd"]) {
                [weakSelf.delegate changePassWord];
            }else
            {
                completionBlock(responseObject);
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
            errorBlock(error);
        }];
    }
}


//－－－POST下载
//使用multipart-formdata协议上传文件的方法：
//multipart是HTTP协议为web表单新增的上传文件的协议，数据也是放在请求体中，和普通POST的区别是参数不再是key＝value格式，因此特定的数据格式。
- (void)AFPostData:(NSString*)urlString HttpMethod:(NSString*)method params:(NSMutableDictionary*)parms
              data:(NSMutableDictionary*)datas completionHandle:(void(^)(id result))completionBlock errorHandle:(void(^)(NSError* result))errorBlock
{
    AFHTTPSessionManager*manger = [AFHTTPSessionManager manager];
    NSString*json = [self GetJsonWith:urlString dataDic:parms];
    NSDictionary*dic123 = @{
                            @"requestData":json
                            };
    
    [manger POST:BaseURL parameters:dic123 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //在此处上传文件
        for (NSString *keyName in datas) {
            
            UIImage*image = datas[keyName];
            NSData *data = UIImageJPEGRepresentation(image,.3);
            
            //获取文件的二进制数据
            
            //需要上传的数据添加到formData中
            [formData appendPartWithFileData:data name:keyName fileName:@"test.jpg" mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败
        errorBlock(error);
    }];
}

- (NSString*)GetJsonWith:(NSString*)urlString dataDic:(NSDictionary*)dic
{
    
    //首先判断NSUserDefaults中是否已经存储了帐号的相关信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString*login_credentials = [user objectForKey:@"login_credentials"];
    NSString*user_id = @"";//首先创建一个空的
    if (login_credentials.length !=0) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        user_id = [ user objectForKey:@"login_credentials"];
    }
    NSString*passWord = @"";
    NSString *pwd = [user valueForKey:@"pwd"];
    if (pwd.length != 0) {
        passWord = pwd;
    }

    //获取当前时间
    NSString*time = [self GetCurrentTime];
    //获取唯一序列号
    NSString * deviceId = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *tokenString = [NSString stringWithFormat:@"%@%@%@%@",urlString,user_id,time,Key];
    //MD5加密
    NSString * token = [self md5String:tokenString];

    NSDictionary*requestDic = @{
                        @"pack_no":urlString,
                        @"date":time,
                        @"user_id":user_id,
                        @"deviceId":deviceId,
                        @"token":token,
                        @"data":dic,
                        @"pwd":passWord

                         };
    NSString * json = [self dictionaryToJson:requestDic];
    
    return json;
}
#pragma mark 获取当前时间戳
-(NSString *)GetCurrentTime
{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    
    //    NSLog(@"timeString:%@",timeString); //时间戳的值
    
    return timeString ;
}

#pragma mark 获取token MD5 加密
-(NSString *)md5String:(NSString *)str
{
    //转换成UTF8
    const char * Cstr = [str UTF8String];
    //开辟一个16字节的空间
    unsigned char buff[16];
    
    CC_MD5(Cstr, (CC_LONG)strlen(Cstr), buff);
    
    //把Cstr字符串转化成32位16进制数列，（这个过程不可逆）把他存储到result这个空间里
    NSMutableString * result = [[NSMutableString alloc] init];
    
    for (int i = 0; i<16 ; i++)
    {
        [result appendFormat:@"%02x",buff[i]];
    }
    return result ;
}
#pragma mark 字典转换成json
-(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark 返回登入状态


@end
