//
//  JudgePhoneNumer.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "JudgePhoneNumer.h"

@implementation JudgePhoneNumer

+(BOOL)checkTelNumber:(NSString*)mobileNum
{
   NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
   NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(BOOL)checkPassword:(NSString*)password
{
    NSString* number=@"^[a-zA-Z0-9]{6,16}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:password];
}

+ (BOOL)checkUserName:(NSString*)userName

{
    
    NSString*pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:userName];
    
    return isMatch;
    
}

+(BOOL)checkUserIdCard:(NSString*)idCard

{
    
    NSString *pattern =@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:idCard];
    
    return isMatch;
    
}

+(BOOL)checkEmployeeNumber:(NSString*)number

{
    
    NSString*pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:number];
    
    return isMatch;
    
}


+(BOOL)checkURL:(NSString*)url
{
    NSString*pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}


@end
