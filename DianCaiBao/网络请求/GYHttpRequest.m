 //
//  GYHttpRequest.m
//  news
//
//  Created by inspration on 16/3/2.
//  Copyright © 2016年 inspration. All rights reserved.
//

#import "GYHttpRequest.h"

#import <AFNetworking/AFNetworking.h>
//#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
//MD5加密
#import <objc/runtime.h>
#import <CommonCrypto/CommonCrypto.h>

#define URL_announcement @"http://dcj.0791jr.com/app.php?m=App&c=api&a=processing"
#define Key @"n'NI&u#+lFA0y@;$6Wj=5(~9"

//@interface GYHttpRequest ()
//
//@property (nonatomic ,retain) NSString * type ;
//
//@end
@implementation GYHttpRequest

+ (instancetype)shareManager
{
    static GYHttpRequest *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[GYHttpRequest alloc]init];
        
    });
    
    return manager;
}

-(void)getNewsHttpData:(NSString *)type interfaceNumber:(NSString*)number dataDic:(NSDictionary*)dic success:(httpSuccess)success failure:(httpFailure)failure
{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    NSString * json = [self GetJsonWith:type interfaceNumber:number dataDic:(NSDictionary*)dic];
//    NSLog(@"%@",json);
    
    NSString * url = [NSString stringWithFormat:@"%@&requestData=%@",URL_announcement,json];
    
//    NSLog(@"当前网址 url = %@",url);
    
    NSString * URL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
      
    
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
    
        NSLog(@"获取数据成功");
    
        success(responseObject) ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//-(void)postNewsHttpData:(NSString *)type interfaceNumber:(NSString*)number dicImage:(NSDictionary *)imgCover dataDic:(NSDictionary*)dic success:(httpSuccess)success failure:(httpFailure)failure
//{
// 
//    
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString * json = [self GetJsonWith:type interfaceNumber:number dataDic:(NSDictionary*)dic];
//    
//    NSString * url = [NSString stringWithFormat:@"%@&requestData=%@",URL_announcement,json];
//    
//    NSString * URL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
////     [manager POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
////    
////         NSString*url = imgCover[@"pics"];
////         NSURL *u = [NSURL URLWithString:url];
//////         [formData appendPartWithFileURL:u name:@"pics" error:nil];
////         [formData appendPartWithFileURL:u name:@"pics" fileName:@"pics" mimeType:@"image/jpeg" error:nil];
////         
////    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        
////        success(responseObject);
////        NSLog(@"%@",responseObject);
////        
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        
////        NSLog(@"%@",error);
////    }];
//    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        success(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//        
//    }];
//}

-(void)notice:(id)sender{
    NSLog(@"\n %@",sender);
}

#pragma mark 获取json
-(NSString *)GetJsonWith:(NSString *)type interfaceNumber:(NSString*)number dataDic:(NSDictionary*)dic
{
    [self readNSUserDefaults];
    NSString * pack_no = number ;//参数
    
    if(_stR == nil){
        _stR = @"dafadsjkfjadklfjklafjlkdjfals";;
    }
    
    NSString *user_id  = [NSString stringWithFormat:@"%@",_stR];
    
    NSUserDefaults*user = [NSUserDefaults standardUserDefaults];
    NSString*str  = [user objectForKey:@"login_credentials"];
    if (str.length != 0)
    {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        user_id = [ user objectForKey:@"login_credentials"];
        NSLog(@"%@",user_id);
    }
//   NSString * user_id = [NSString stringWithFormat:@""];
//    NSLog(@"user_id = %@",user_id);
    NSString * roles = [NSString stringWithFormat:@""];
//    NSLog(@"roles = %@",roles);
    //获取当前时间
    NSString * date = [self GetCurrentTime];
    //    NSLog(@"sec = %@",date);
    //获取唯一序列号
    NSString * deviceId = [[UIDevice currentDevice].identifierForVendor UUIDString];
//    NSLog(@"唯一序列号 = %@",deviceId);

    //    NSLog(@"key = %@",Key);
    user_id = @"18667107015";
//    NSLog(@"%@",pack_no);
    NSString *tokenString = [NSString stringWithFormat:@"%@%@%@%@",pack_no,user_id,date,Key];
//    NSString *tokenString = [NSString stringWithFormat:@"%@%@%@%@",pack_no,_stR,date,Key];

    //MD5加密
//    NSLog(@"tokenStr = %@",pack_no);
    
    NSString * token = [self md5String:tokenString];
    
//    NSLog(@"token = %@",token);
    
//    NSDictionary * dataDic = @{@"date_flag":type};
//    
//    NSLog(@"dataDic = %@",dataDic);
    
    NSDictionary * requestDic = @{@"pack_no":pack_no,
                                  @"date":date,
                                  @"user_id":_stR,
                                  @"deviceId":deviceId,
                                  @"token":token,
                                  @"roles":roles,
                                  @"data":dic};
    
    NSString * json = [self dictionaryToJson:requestDic];
    
    return json;
}
//从NSUserDefaults中读取数据
-(void)readNSUserDefaults
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    //读取NSString类型的数据

       NSString *youString = [userDefaultes stringForKey:@"userid"];
    if (youString.length ==0) {

    }
    _stR = youString;

    _stR = youString;

        //读取NSString类型的数据
    NSString *zhString = [userDefaultes stringForKey:@"zhanghao"];
    _zh = zhString;
        
    NSString *mmString = [userDefaultes stringForKey:@"mima"];
    _mm = mmString;

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
@end
