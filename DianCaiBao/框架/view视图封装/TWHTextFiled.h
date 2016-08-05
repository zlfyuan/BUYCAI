//
//  TWHTextFiled.h
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWHTextFiled : UITextField

-(instancetype)initWithFrame:(CGRect)frame placehold:(NSString *)placehold;
-(instancetype)initWithFrame:(CGRect)frame placehold:(NSString *)placehold labtext:(NSString *)labText tfTextColor:(UIColor *)tc tfText:(NSString *)tfText;

@end
