//
//  FindPwViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/2.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "FindPwViewController.h"
#import "TWHTextFiled.h"
#import "TWHButton.h"

@interface FindPwViewController ()
{
    TWHTextFiled *_PhoneNumTf;
    TWHTextFiled *_YZMTf;
    TWHTextFiled *_newPwTf;
    TWHTextFiled *_confirmPwTf;
}
@end

@implementation FindPwViewController
-(void)viewDidAppear:(BOOL)animated{
    [super  viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUI];
    
}

-(void)setNav{
    self.title = @"密码找回";
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 13, 25)];
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-10;
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lt = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lt];
}

-(void)setUI
{
    //手机号
    _PhoneNumTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(15, 15, self.view.frame.size.width-30, 40) placehold: @"已绑定手机号(以13/15/18开头,长度为11位的数字)"];
    [self.view addSubview:_PhoneNumTf];
    
    //验证码
    _YZMTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(15, _PhoneNumTf.frame.origin.y+_PhoneNumTf.frame.size.height+15, self.view.frame.size.width-30-80-15, 40) placehold:@"请输入验证码"];
    [self.view addSubview:_YZMTf];

    TWHButton *getYZMBtn = [[TWHButton alloc]initWithFrame:CGRectMake(_YZMTf.frame.origin.x+_YZMTf.frame.size.width+15, _PhoneNumTf.frame.origin.y+_PhoneNumTf.frame.size.height+20, 80, 40) cornerRadius:4.0 font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor] backGroundColor:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] title:@"获取验证码"];
    [getYZMBtn addTarget:self action:@selector(getYZMBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getYZMBtn];
    
    
//    //新密码
    _newPwTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(15, _YZMTf.frame.origin.y+_YZMTf.frame.size.height+15, self.view.frame.size.width-30, 40) placehold:@"请输入新密码"];
     _newPwTf.secureTextEntry = YES;
    [self.view addSubview:_newPwTf];
    
    //再次输入密码
//    againPwTf = [[UITextField alloc]initWithFrame:CGRectMake(15, newPwTf.frame.origin.y+newPwTf.frame.size.height+15, self.view.frame.size.width-30, 40)];
//    againPwTf.placeholder = @"请再次输入密码";
//    againPwTf.layer.borderColor = [UIColor lightGrayColor].CGColor ;
//    againPwTf.layer.borderWidth = 1.0f;
//    [againPwTf setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _confirmPwTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(15, _newPwTf.frame.origin.y+_newPwTf.frame.size.height+15, self.view.frame.size.width-30, 40) placehold:@"请再次输入密码"];
    [self.view addSubview:_confirmPwTf];
    
    TWHButton *confirmBtn = [[TWHButton alloc]initWithFrame:CGRectMake(30, _confirmPwTf.frame.origin.y+_confirmPwTf.frame.size.height+30, self.view.frame.size.width-60, 45) cornerRadius:3.0 font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor] backGroundColor:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] title:@"确定"];
    [confirmBtn addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

-(void)returnBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark---获取验证码
-(void)getYZMBtnClicked{
    NSMutableDictionary *parms = [NSMutableDictionary new];
    parms[@"mobile"] = _PhoneNumTf.text;
    [[LXGNetWorkQuery shareManager]AFrequestData:@"10003" HttpMethod:@"POST" params:parms completionHandle:^(id result) {
        HULog(@"成功");
    } errorHandle:^(NSError *result) {
         HULog(@"失败");
    }];
}

#pragma mark---确定找回密码
-(void)confirmButtonClicked{
    if (_PhoneNumTf.text.length <1) {
        [ShowMessage showMessage:@"手机号码格式错误" duration:2.0];
        return;
    }
    if ([_YZMTf.text isEqualToString:@"1966"]) {
        
    }else{
        [ShowMessage showMessage:@"验证码有误" duration:2.0];
    }
    if (_confirmPwTf.text.length<1) {
        [ShowMessage showMessage:@"旧密码不能为空" duration:2.0];
    }else{
        //判断是否是旧密码
        HULog(@"ew");
        
        NSMutableDictionary *parms = [NSMutableDictionary new];
        parms[@"mobile"] = _PhoneNumTf.text;
        parms[@"code"] = @"1966";
        parms[@"password"] = _newPwTf.text;
        parms[@"confirm_password"] = _confirmPwTf.text;
        [[LXGNetWorkQuery shareManager]AFrequestData:@"10004" HttpMethod:@"POST" params:parms completionHandle:^(id result) {
            HULog(@"%@成功",result);
        } errorHandle:^(NSError *result) {
            HULog(@"失败");
        }];
   

    }
    
}
@end
