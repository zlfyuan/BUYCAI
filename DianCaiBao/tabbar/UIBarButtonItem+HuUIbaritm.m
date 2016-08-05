//
//  UIBarButtonItem+HuUIbaritm.m
//  自定义taberbar
//
//  Created by 汤文洪 on 16/6/6.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "UIBarButtonItem+HuUIbaritm.h"
#import "UIView+Huframe.h"
@implementation UIBarButtonItem (HuUIbaritm)
+(instancetype)itemwithimage:(NSString *)image highimage:(NSString *)highimage target:(id)target action:(SEL)action
{
    UIButton *button=[UIButton buttonWithType: UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highimage] forState:UIControlStateHighlighted];
    button.size=button.currentImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc]initWithCustomView:button];
}
@end

