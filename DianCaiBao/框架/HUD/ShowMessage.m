//
//  ShowMessage.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/3.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ShowMessage.h"

@implementation ShowMessage

#pragma mark  提示弹框
+(void)showMessage:(NSString *)message duration:(NSTimeInterval)time 
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *showView=[[UIView alloc]init];
    showView.backgroundColor=[UIColor grayColor];
    showView.frame=CGRectZero;
    showView.alpha=1.0f;
    showView.layer.cornerRadius=5.0f;
    showView.layer.masksToBounds=YES;
    [window addSubview:showView];
    
    UILabel *label=[[UILabel alloc]init];
    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary *attributes=@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize=[message boundingRectWithSize:CGSizeMake(207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
   
    label.frame=CGRectMake(10,5,labelSize.width+20, labelSize.height);
    label.text=message;
    NSLog(@"%@",label.text);
    label.textColor=[UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:15];
    [showView addSubview:label];
//    HULog(@"%@",label);
    
    showView.frame=CGRectMake((screenSize.width-labelSize.width-20)/2, screenSize.height-(screenSize.height/6), labelSize.width+80, labelSize.height+10);
    showView.frame=CGRectMake((screenSize.width-labelSize.width-20)/2, screenSize.height-130, labelSize.width+40, labelSize.height+10);
//    label.backgroundColor = [UIColor greenColor];
//    showView.backgroundColor = [UIColor blueColor];
//    showView.frame = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration:time animations:^{
        showView.alpha=0;
    } completion:^(BOOL finished) {
        [showView removeFromSuperview];
    }];
}


@end
