//
//  Call.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "Call.h"

@implementation Call

+(UIView *)UnLeftcallPhone:(NSString *)phoneNumber
{
    //phoneNumber = "18369......"
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    return callWebview;
}

+(void)LeftcallPhone:(NSString *)phoneNumber{
    //phoneNumber = "18369......"
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
