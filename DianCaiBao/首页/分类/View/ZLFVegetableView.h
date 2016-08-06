//
//  ZLFVegetableView.h
//  DianCaiBao
//
//  Created by zluof on 16/8/6.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLFDetaiVegeTableMode;
@interface ZLFVegetableView : UIView

@property (nonatomic, strong)ZLFDetaiVegeTableMode *detaiMode;
+(instancetype)showManger;
-(void)showInfo:(CGRect)frame supView:(UIView *)view vegeTableInfo:(ZLFDetaiVegeTableMode *)mode;
@end
