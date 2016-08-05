//
//  RegisterViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/2.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "RegisterViewController.h"
#import "Call.h"
#import "ShowMessage.h"
#import "JudgePhoneNumer.h"
#import "TWHButton.h"
#import "TWHLabel.h"
#import "TWHTextFiled.h"
#import "ZLFCityMode.h"
#import "ZLFUserMode.h"

#import <MJExtension.h>
@interface RegisterViewController ()<UITextFieldDelegate>
{
    TWHTextFiled *_PhoneNumTf;
    TWHTextFiled *_newPwTf;
    TWHTextFiled *_againPwTf;
    TWHTextFiled *_buyCityTf;
    TWHTextFiled *_userTypeTf;
    TWHButton *_agreeBtn;
    CGFloat _AllHeight;
    UILabel *_lab;
    UIScrollView *_bottomScroll;
    NSInteger _agree;
}
/**注册数据*/
@property (nonatomic, strong)NSMutableArray *registerCity;
/**用户类型*/
@property (nonatomic, strong)NSMutableArray *user_Types;
@end

@implementation RegisterViewController
-(NSMutableArray *)RegisterCity{
    if(_registerCity == nil){
        _registerCity = [NSMutableArray new];
    }
    return _registerCity;
}
-(NSMutableArray *)user_Types{
    if (!_user_Types) {
        _user_Types= [NSMutableArray new];
    }
    return _user_Types;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *parms = [NSMutableDictionary new];
    [[LXGNetWorkQuery shareManager] AFrequestData:@"10000" HttpMethod:@"POST" params:parms completionHandle:^(id result) {
//                HULog(@"%@",result[@"data"]);
        self.registerCity = [ZLFCityMode mj_objectArrayWithKeyValuesArray:result[@"data"][@"city"]];
        self.user_Types = [ZLFUserMode mj_objectArrayWithKeyValuesArray:result[@"data"][@"type"]];
    } errorHandle:^(NSError *result) {
        HULog(@"请求失败%@",result);
    }];

    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUI];
}

-(void)setNav{
    self.title = @"注册";
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
    CGRect myScreen = [UIScreen mainScreen].bounds;
    _bottomScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,myScreen.size.width, myScreen.size.height-44-64)];
    _bottomScroll.bounces = NO;
    [self.view addSubview:_bottomScroll];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, self.view.frame.size.width-40, 18)];
    _lab.font = [UIFont systemFontOfSize:14];
    _lab.text = @"如有疑问,请拨打客服电话:400-0791-490";
    _lab.textColor = [UIColor brownColor];
    _lab.userInteractionEnabled = YES;
    UITapGestureRecognizer *callGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(call)];
    [_lab addGestureRecognizer:callGes];
    [_bottomScroll addSubview:_lab];
    _AllHeight += _lab.frame.size.height+10;
    
    //手机号
    _PhoneNumTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(15, _lab.frame.origin.y+_lab.frame.size.height+30, self.view.frame.size.width-30, 40) placehold:@"手机号(以13/15/18开头,长度为11位的数字)"];
    _PhoneNumTf.delegate = self;
    _PhoneNumTf.keyboardType = UIKeyboardTypeNumberPad;
    [_bottomScroll addSubview:_PhoneNumTf];
    _AllHeight += _PhoneNumTf.frame.size.height+15;
    
    //新密码
    _newPwTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(15, _PhoneNumTf.frame.origin.y+_PhoneNumTf.frame.size.height+15, self.view.frame.size.width-30, 40) placehold:@"请输入新密码(可为字母和数字或下划线组成,长6-16)"];
    _newPwTf.delegate = self;
    _newPwTf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_bottomScroll addSubview:_newPwTf];
    _AllHeight += _newPwTf.frame.size.height+15;
    
    //再次输入密码
    _againPwTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(15, _newPwTf.frame.origin.y+_newPwTf.frame.size.height+15, self.view.frame.size.width-30, 40) placehold:@"请再次输入登录密码"];
    _againPwTf.delegate = self;
    _againPwTf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_bottomScroll addSubview:_againPwTf];
    _AllHeight += _againPwTf.frame.size.height+15;
    
    //买菜城市
    _buyCityTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(15, _againPwTf.frame.origin.y+_againPwTf.frame.size.height+15, self.view.frame.size.width-30, 40) placehold:@"选择买菜城市"];
    _buyCityTf.delegate = self;
    _buyCityTf.text = @"16";
    [_bottomScroll addSubview:_buyCityTf];
    _AllHeight += _buyCityTf.frame.size.height+15;
    
    //用户类型
    _userTypeTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(15, _buyCityTf.frame.origin.y+_buyCityTf.frame.size.height+15, self.view.frame.size.width-30, 40) placehold:@"用户类型"];
    _userTypeTf.delegate = self;
    _userTypeTf.text = @"2";
    [_bottomScroll addSubview:_userTypeTf];
    

    _AllHeight += _userTypeTf.frame.size.height+15;
    
    TWHButton *agreeBtn = [[TWHButton alloc]initWithFrame:CGRectMake(_userTypeTf.frame.origin.x+25, _userTypeTf.frame.origin.y+_userTypeTf.frame.size.height+30, 20, 20) cornerRadius:0 font:[UIFont systemFontOfSize:14] titleColor:[UIColor orangeColor] backGroundColor:[UIColor clearColor] title:@""];
    [agreeBtn setImage:[UIImage imageNamed:@"check_nomer"] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"check_selector"] forState:UIControlStateSelected];
    [agreeBtn addTarget:self action:@selector(agreeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomScroll addSubview:agreeBtn];
    

    TWHLabel *agreeProtolLab = [[TWHLabel alloc]initWithFrame:CGRectMake(_userTypeTf.frame.origin.x+50,_userTypeTf.frame.origin.y+_userTypeTf.frame.size.height+30, 200, 18) title:@"同意配菜宝  《用户服务协议》" font:[UIFont systemFontOfSize:14] rangeString:@"《用户服务协议》"];
    [_bottomScroll addSubview:agreeProtolLab];
    _AllHeight += agreeProtolLab.frame.size.height+30;
    
    //注册按钮
    TWHButton *registerButton = [[TWHButton alloc]initWithFrame:CGRectMake(15, agreeProtolLab.frame.origin.y+agreeProtolLab.frame.size.height+30, self.view.frame.size.width-30, 45) cornerRadius:3.0 font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor] backGroundColor:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] title:@"注册"];
    [registerButton addTarget:self action:@selector(registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_bottomScroll addSubview:registerButton];
    _AllHeight += registerButton.frame.size.height+30;
    
    //
    UILabel *nonelab = [[UILabel alloc]initWithFrame:CGRectMake(registerButton.frame.origin.x+40, registerButton.frame.origin.y+registerButton.frame.size.height+20, 85, 18)];
    nonelab.font = [UIFont systemFontOfSize:13];
    nonelab.text = @"已有账号,点此";
    [_bottomScroll addSubview:nonelab];
//    
    TWHButton *zcBtn = [[TWHButton alloc]initWithFrame:CGRectMake(nonelab.frame.origin.x+nonelab.frame.size.width,registerButton.frame.origin.y+registerButton.frame.size.height+20, 30, 18) cornerRadius:0 font:[UIFont systemFontOfSize:13] titleColor:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] backGroundColor:[UIColor clearColor] title:@"登录"];
    [zcBtn addTarget:self action:@selector(zcBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_bottomScroll addSubview:zcBtn];
    _AllHeight += zcBtn.frame.size.height+30;
    NSLog(@"%f",_AllHeight);
    
    _bottomScroll.contentSize = CGSizeMake(self.view.frame.size.width, _AllHeight);
    
    _agree = 0;
}

#pragma mark - 注册按钮点击事件判断
-(void)registerBtnClicked
{
    if (_PhoneNumTf.text.length<1||_PhoneNumTf.text.length<1||_againPwTf.text.length<1) {
        [ShowMessage showMessage:@"请完善注册信息(除推荐人允许为空其它不允许为空)" duration:2.0];
    }
    else if(_agree == 1)
    {
        [ShowMessage showMessage:@"为了更好地为您服务,请同意点菜君用户协议" duration:2.0];
    }
    else if (_PhoneNumTf.text.length>0)
    {
        if (_PhoneNumTf.text.length<11||_PhoneNumTf.text.length>11) {
            [ShowMessage showMessage:@"手机号码格式错误" duration:2.0];
        }
        else
        {
            BOOL q = [JudgePhoneNumer checkTelNumber:_PhoneNumTf.text];
            if (q) {
                
            }
            else
            {
            [ShowMessage showMessage:@"手机号码格式错误" duration:2.0];
            }
        }
    }
    else if (_newPwTf.text.length>0){
        if (_newPwTf.text.length<6||_newPwTf.text.length>18) {
            [ShowMessage showMessage:@"密码输入格式错误" duration:2.0];
        }
        else
        {
            BOOL q = [JudgePhoneNumer checkPassword:_newPwTf.text];
            if (q) {
                
            }
            else
            {
            [ShowMessage showMessage:@"密码输入格式错误" duration:2.0];
            }
        }
    }
    else if (_againPwTf.text.length>0)
    {
        if (![_againPwTf.text isEqualToString:_newPwTf.text]) {
            [ShowMessage showMessage:@"两次密码不一致" duration:2.0];
        }
    }
    
    
    NSMutableDictionary *parms = [NSMutableDictionary new];
    parms[@"mobile"] = _PhoneNumTf.text;
//    parms[@"code"] =
    parms[@"password"] = _newPwTf.text;
    parms[@"confirm_password"] = _againPwTf.text;
    parms[@"city_id"] = _buyCityTf.text;
    parms[@"cate_id"] = _userTypeTf.text;
    parms[@"checkbox"] =[NSString stringWithFormat:@"%d",1];
//    parms[@"referees"] =
    [[LXGNetWorkQuery shareManager]AFrequestData:@"10001" HttpMethod:@"POST" params:parms completionHandle:^(id result) {
        HULog(@"%@",result);
    } errorHandle:^(NSError *result) {
        
    }];
    
}


#pragma mark - 收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_PhoneNumTf resignFirstResponder];
    [_newPwTf resignFirstResponder];
    [_againPwTf resignFirstResponder];
    [_buyCityTf resignFirstResponder];
    [_userTypeTf resignFirstResponder];
    return YES;
}


#pragma mark - 监听输入框的实时输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _PhoneNumTf) {
        if (_PhoneNumTf.text.length>10) {
            return NO;
        }
    }
    
    if (textField == _newPwTf) {

            BOOL q = [JudgePhoneNumer checkPassword:_newPwTf.text];
            if (q) {
                return NO;
            }
            else
            {
                return YES;
            }
        }

    
        return YES;
}

-(void)agreeBtnClicked:(id)sender
{
    UIButton *btn = sender;
    if (btn.selected){
        _agree = 1;
        [btn setImage:[UIImage imageNamed:@"check_selector"] forState:UIControlStateSelected];
    }else{
        [btn setImage:[UIImage imageNamed:@"check_nomer"] forState:UIControlStateNormal];
        _agree = 0;
    }
    btn.selected = !btn.selected;
}

-(void)zcBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)returnBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)call
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"" message:@"是否拨打咨询电话?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *str = [_lab.text substringFromIndex:13];
        [Call LeftcallPhone:str];
        
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [ac addAction:confirmAction];
    [ac addAction:cancleAction];
    [self presentViewController:ac animated:YES completion:^{}];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_bottomScroll endEditing:YES];
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
