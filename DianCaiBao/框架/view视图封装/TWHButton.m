//
//  TWHButton.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "TWHButton.h"

@implementation TWHButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/*
 UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 205, self.view.frame.size.width-30, 45)];
 loginButton.layer.cornerRadius = 3.0;
 loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
 loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
 [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 [loginButton setBackgroundColor:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0]];
 [loginButton setTitle:@"登录" forState:UIControlStateNormal];
 [loginButton addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:loginButton];
 */

/*注册按钮*/
-(instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius font:(UIFont*)font titleColor:(UIColor *)titleColor
backGroundColor:(UIColor *)backClor title:(NSString *)title
{
    if([super initWithFrame:frame]){
        self.layer.cornerRadius = cornerRadius;
        self.titleLabel.font = font;
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        [self setBackgroundColor:backClor];
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

@end
