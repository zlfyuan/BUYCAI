//
//  Call.h
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Call : NSObject

/** 返回应用界面 */
+(UIView *)UnLeftcallPhone:(NSString *)phoneNumber;

/** 不返回应用界面,保留在拨打电话界面 */
+(void)LeftcallPhone:(NSString *)phoneNumber;

@end
