//
//  JJYpageView.h
//  UI--21--分页功能的封装
//
//  Created by 揭建有 on 16/3/14.
//  Copyright © 2016年 揭建有. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LunbopageView : UIView

/** 图片名字*/
@property (nonatomic, strong)NSArray *imageNames;

/** 其他圆点的颜色*/
@property (nonatomic, strong)UIColor *otherColor;

/** 当前圆点颜色*/
@property (nonatomic, strong)UIColor *currenColor;

+ (instancetype)pageView;
@end
