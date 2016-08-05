//
//  ModifyViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/3.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ModifyViewController.h"
#import "TWHTextFiled.h"
#import "TWHButton.h"

@interface ModifyViewController ()<UITextFieldDelegate>
{
    TWHTextFiled *_PhoneNumTf;
    TWHTextFiled *_newPwTf;
    TWHTextFiled *_againPwTf;
}

@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUI];
}

-(void)setNav{
    self.title = @"密码修改";
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
    NSArray *labArr = @[@"原密码 :",@"新密码 :",@"确认密码 :"];
    for (int i=0; i<3; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, i*40+(i+1)*15, 65, 40)];
        lab.textAlignment = NSTextAlignmentRight;
        lab.textColor = [UIColor darkGrayColor];
        lab.text = labArr[i];
        lab.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:lab];
    }
    
    //手机号
    _PhoneNumTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(90, 15, self.view.frame.size.width-100, 40) placehold:@"请输入原密码"];
    [self.view addSubview:_PhoneNumTf];
    
    //新密码
    _newPwTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(90, _PhoneNumTf.frame.origin.y+_PhoneNumTf.frame.size.height+15, self.view.frame.size.width-100, 40) placehold:@"请输入新密码"];
    [self.view addSubview:_newPwTf];
    
   //再次输入密码
    _againPwTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(90, _newPwTf.frame.origin.y+_newPwTf.frame.size.height+15, self.view.frame.size.width-100, 40) placehold:@"请再次输入新密码"];
    [self.view addSubview:_againPwTf];
    
    TWHButton *confirmBtn = [[TWHButton alloc]initWithFrame:CGRectMake(30, _againPwTf.frame.origin.y+_againPwTf.frame.size.height+30, self.view.frame.size.width-60, 35) cornerRadius:3.0 font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor] backGroundColor:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] title:@"确定"];
    [self.view addSubview:confirmBtn];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_PhoneNumTf resignFirstResponder];
    [_newPwTf resignFirstResponder];
    [_againPwTf resignFirstResponder];
    return YES;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)returnBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
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
