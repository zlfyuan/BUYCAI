//
//  LoginViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/2.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FindPwViewController.h"
#import "FirstPageViewController.h"
#import "ShowMessage.h"
#import "JudgePhoneNumer.h"
#import "TWHTextFiled.h"
#import "TWHButton.h"


@interface LoginViewController ()<UITextFieldDelegate>

/**账号输入框*/
@property(nonatomic,strong)TWHTextFiled *accountTf;
/**密码输入框*/
@property(nonatomic,strong)TWHTextFiled *passwordTf;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUI];
}

-(void)setNav{
    self.title = @"登录";
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
    //账号输入框
    _accountTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(15, 50, self.view.frame.size.width-30, 40) placehold:@"请输入手机号"];
    _accountTf.delegate = self;
    _accountTf.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_accountTf];
    
    //密码输入框
    _passwordTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(15, 105, self.view.frame.size.width-30, 40) placehold:@"请输入密码"];
    _passwordTf.delegate = self;
    [self.view addSubview:_passwordTf];
    
    
    //登录按钮
    TWHButton *loginButton = [[TWHButton alloc]initWithFrame:CGRectMake(15, 205, self.view.frame.size.width-30, 45) cornerRadius:3.0 font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor] backGroundColor:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] title:@"登录"];
    [loginButton addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];

    //忘记密码按钮.
    UIButton *forgetPw = [[TWHButton alloc]initWithFrame:CGRectMake(15, 280, 60, 20) cornerRadius:0 font:[UIFont systemFontOfSize:13] titleColor:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] backGroundColor:[UIColor clearColor] title:@"忘记密码"];
    [forgetPw addTarget:self action:@selector(forgetPwClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPw];
    
    
    //去注册
    UILabel *nonelab = [[UILabel alloc]initWithFrame:CGRectMake(loginButton.center.x+((loginButton.frame.size.width/2)-30-83), 280, 83, 20)];
    nonelab.font = [UIFont systemFontOfSize:13];
    nonelab.text = @"还没有账号,去";
    [self.view addSubview:nonelab];
    
    //注册按钮
    TWHButton *zcBtn = [[TWHButton alloc]initWithFrame:CGRectMake(nonelab.frame.origin.x+nonelab.frame.size.width, 280, 30, 18) cornerRadius:0 font:[UIFont systemFontOfSize:13] titleColor:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] backGroundColor:[UIColor clearColor] title:@"注册"];
    [zcBtn addTarget:self action:@selector(zcBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zcBtn];
    
    //注册按钮下划线.
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(zcBtn.frame.origin.x, zcBtn.frame.origin.y+zcBtn.frame.size.height, 30, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0];
    [self.view addSubview:lineView];
}

#pragma mark - textfiled收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_accountTf resignFirstResponder];
    [_passwordTf resignFirstResponder];
    return YES;
}

#pragma mark - 注册按钮点击事件
-(void)zcBtnClicked
{
    RegisterViewController *rv = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rv animated:YES];
}

#pragma mark - 登录按钮点击事件
-(void)loginBtnClicked
{
    if (_accountTf.text.length==0) {
        [ShowMessage showMessage:@"请输入手机号" duration:2.0];
    }
    else if(_accountTf.text.length>0)
    {
        
        if (_accountTf.text.length<12&&_accountTf.text.length==11) {
            BOOL isPhnum = [JudgePhoneNumer checkTelNumber:_accountTf.text];
            if (isPhnum) {
                //手机号码正确,提交输入的手机号码进行审核.
            }
            else
            {
                [ShowMessage showMessage:@"手机号码输入错误" duration:2.0];
            }
           
        }else {
            [ShowMessage showMessage:@"请输入正确手机号" duration:2.0];
        }
        
    }
    
    if(_passwordTf.text.length<1){
         [ShowMessage showMessage:@"请输入密码" duration:2.0];
    }else{
        
        NSMutableDictionary *parms = [NSMutableDictionary new];
        parms[@"account"] = _accountTf.text;
        
        parms[@"password"] = _passwordTf.text;
        [[LXGNetWorkQuery shareManager]AFrequestData:@"10002" HttpMethod:@"POST" params:parms completionHandle:^(id result) {
            HULog(@"%@",result);
            [ShowMessage showMessage:@"登入成功" duration:2.0];
            [LXGNetWorkQuery shareManager].isLogin = YES;
#warning 保存登入信息
            NSMutableArray *userInfo = [NSMutableArray new];
            [userInfo addObject:result[@"data"]];
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"users"]) {
                [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"users"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        } errorHandle:^(NSError *result) {
            [ShowMessage showMessage:@"登入失败" duration:2.5];
        }];
    }
    
    
    
}

#pragma mark - 忘记密码按钮点击事件
-(void)forgetPwClicked
{
    FindPwViewController *fv = [[FindPwViewController alloc]init];
    [self.navigationController pushViewController:fv animated:YES];
}

#pragma mark - 导航栏返回按钮点击事件
-(void)returnBtnClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 点击空白处收键盘.
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
