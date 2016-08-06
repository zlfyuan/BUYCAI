//
//  PersonInformationViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "PersonInformationViewController.h"
#import "ShowMessage.h"
#import "TWHTextFiled.h"
#import "TWHButton.h"

@interface PersonInformationViewController ()<UITextFieldDelegate>
{
    TWHTextFiled *nameLab;
    TWHTextFiled *detailAddressTf;
}
@end

@implementation PersonInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUI];
}

-(void)setNav{
    self.title = @"个人资料";
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-10;
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 13, 23)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lt = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lt];
}

-(void)setUI
{
    TWHTextFiled *idTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(0, 15, self.view.frame.size.width, 40) placehold:@"" labtext:@"  顾客ID  :" tfTextColor:[UIColor orangeColor] tfText:@"3752850"];
    idTf.enabled = NO;
    [self.view addSubview:idTf];
    
    nameLab = [[TWHTextFiled alloc]initWithFrame:CGRectMake(0, idTf.frame.origin.y+idTf.frame.size.height-1, self.view.frame.size.width, 40) placehold:@"" labtext:@"  姓    名:" tfTextColor:[UIColor blackColor] tfText:@"  游客"];
    nameLab.delegate = self;
    [self.view addSubview:nameLab];
    TWHTextFiled *phoneNum = [[TWHTextFiled alloc]initWithFrame:CGRectMake(0, nameLab.frame.origin.y+nameLab.frame.size.height-1, self.view.frame.size.width, 40) placehold:@"" labtext:@"  电    话:" tfTextColor:[UIColor orangeColor] tfText:@"15070154362"];
    phoneNum.enabled = NO;
    [self.view addSubview:phoneNum];
    TWHTextFiled *buyerCityTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(0, phoneNum.frame.origin.y+phoneNum.frame.size.height+10, self.view.frame.size.width, 40) placehold:@"" labtext:@"  买家城市:" tfTextColor:[UIColor blackColor] tfText:@"南昌"];
    [self.view addSubview:buyerCityTf];
    detailAddressTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(0, buyerCityTf.frame.origin.y+buyerCityTf.frame.size.height-1, self.view.frame.size.width, 40) placehold:@"未填写详细地址(如xx区xx路)" labtext:@"  详细地址:" tfTextColor:[UIColor blackColor] tfText:@""];
    detailAddressTf.delegate = self;
    [self.view addSubview:detailAddressTf];
    
    TWHButton *loginButton = [[TWHButton alloc]initWithFrame:CGRectMake(15, detailAddressTf.frame.origin.y+detailAddressTf.frame.size.height+10, self.view.frame.size.width-30, 45) cornerRadius:3.0 font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor] backGroundColor:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] title:@"保存信息"];
    [loginButton addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [nameLab resignFirstResponder];
    [detailAddressTf resignFirstResponder];
    return YES;
}

-(void)returnBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loginBtnClicked
{
    if (nameLab.text.length<1) {
        [ShowMessage showMessage:@"姓名不能为空" duration:2];
    }
    else if (detailAddressTf.text.length<1){
        [ShowMessage showMessage:@"详细地址不能为空" duration:2];
    }
    else{
    [self.navigationController popViewControllerAnimated:YES];
    [ShowMessage showMessage:@"保存修改成功" duration:2];
    }
}

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
