//
//  segmentedcontrol.h
//  自定义Segmentedcontroll
//
//  Created by zluof on 16/3/24.
//  Copyright © 2016年 zluof. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^number)(NSInteger blocking);
typedef void(^city)(NSString *cityString);
@interface segmentedcontrol : UIView
@property (nonatomic, copy)number block;
@property (nonatomic, copy)city blockcity;
@property (nonatomic, retain)UIColor *titleColo1r;
@property (nonatomic, retain)UIColor *backgroundColor1;

-(instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titlesArray blackBlock:(void (^)(NSInteger ))blocking blackBlockTitle:(void (^)(NSString *title))blockCity;
@end
