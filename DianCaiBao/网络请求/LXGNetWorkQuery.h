//
//  LXGNetWorkQuery.h
//  DCJ-LXG
//
//  Created by mac on 16/6/3.
//  Copyright © 2016年 JR-LXG. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LxgDelegate <NSObject>

@optional

- (void)changePassWord;

@end

@interface LXGNetWorkQuery : NSObject

@property (nonatomic,weak)id<LxgDelegate>delegate;

@property (nonatomic, assign)BOOL isLogin;

+ (instancetype)shareManager;

- (void)AFrequestData:(NSString*)urlString HttpMethod:(NSString*)method params:(NSMutableDictionary*)parms
     completionHandle:(void(^)(id result))completionBlock errorHandle:(void(^)(NSError* result))errorBlock;

- (void)AFPostData:(NSString*)urlString HttpMethod:(NSString*)method params:(NSMutableDictionary*)parms
              data:(NSMutableDictionary*)datas completionHandle:(void(^)(id result))completionBlock errorHandle:(void(^)(NSError* result))errorBlock;


@end
