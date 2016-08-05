//
//  UIView+Huframe.h
//  自定义taberbar
//
//  Created by 汤文洪 on 16/6/6.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Huframe)
/*在分类中声明@property，只会生成方法的声明，不会生成方法的实现和带有下划线的成员变量*/
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGSize size;
@end
