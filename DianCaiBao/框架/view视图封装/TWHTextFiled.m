//
//  TWHTextFiled.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "TWHTextFiled.h"

@implementation TWHTextFiled

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/*
 _accountTf = [[UITextField alloc]initWithFrame:CGRectMake(15, 50, self.view.frame.size.width-30, 40)];
 
 
 _accountTf.delegate = self;
 _accountTf.keyboardType = UIKeyboardTypeNumberPad;
 
 [self.view addSubview:_accountTf];
 */

-(instancetype)initWithFrame:(CGRect)frame placehold:(NSString *)placehold
{
    if([super initWithFrame:frame]){
    self.placeholder = placehold;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor ;
    self.layer.borderWidth = 1.0f;
    [self setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    self.tintColor=[UIColor orangeColor];
    UIView *lv=[[UIView alloc]init];
    lv.frame=CGRectMake(0, 0, 7, 40);
    lv.backgroundColor=[UIColor clearColor];
    self.leftView=lv;
    self.leftViewMode=UITextFieldViewModeAlways;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame placehold:(NSString *)placehold labtext:(NSString *)labText tfTextColor:(UIColor *)tc tfText:(NSString *)tfText
{
    if([super initWithFrame:frame]){
        self.text = tfText;
        self.textColor = tc;
        self.font = [UIFont systemFontOfSize:16];
        self.backgroundColor = [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:1.0];
        self.placeholder = placehold;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor ;
        self.layer.borderWidth = 1.0f;
        [self setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        self.tintColor=[UIColor orangeColor];
        UILabel *lv=[[UILabel alloc]init];
        lv.frame=CGRectMake(7,0,75, 40);
        lv.text = labText;
        lv.font = [UIFont systemFontOfSize:14];
        lv.textColor = [UIColor blackColor];
        lv.backgroundColor=[UIColor clearColor];
        self.leftView=lv;
        self.leftViewMode=UITextFieldViewModeAlways;
    }
    return self;
}

@end
