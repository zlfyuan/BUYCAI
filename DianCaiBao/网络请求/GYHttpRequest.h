//
//  GYHttpRequest.h
//  news
//
//  Created by inspration on 16/3/2.
//  Copyright © 2016年 inspration. All rights reserved.
//

#import <Foundation/Foundation.h>
//请求成功的回调
typedef void(^httpSuccess)(id responseObject);

//请求失败的回调
typedef void(^httpFailure)(NSError *error);

@interface GYHttpRequest : NSObject
{
    NSString *_stR;
    NSString *_zh;
    NSString *_mm;
}
+ (instancetype)shareManager;

-(void)getNewsHttpData:(NSString *)tye interfaceNumber:(NSString*)number dataDic:(NSDictionary*)dic success:(httpSuccess)success failure:(httpFailure)failure;
//-(void)postNewsHttpData:(NSString *)type interfaceNumber:(NSString*)number dicImage:(NSDictionary *)imgCover dataDic:(NSDictionary*)dic success:(httpSuccess)success failure:(httpFailure)failure;



@end
