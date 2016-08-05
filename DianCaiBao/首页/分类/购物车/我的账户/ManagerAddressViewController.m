//
//  ManagerAddressViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/3.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ManagerAddressViewController.h"

@interface ManagerAddressViewController ()

@end

@implementation ManagerAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUI];
}

-(void)setNav{
    self.title = @"管理收货地址";
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-10;
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 13, 25)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lt = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lt];
}

-(void)setUI
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x-75, 20, 150, 120)];
    imgView.image = [UIImage imageNamed:@"Address"];
    [self.view addSubview:imgView];
    UILabel *textLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-130, imgView.frame.origin.y+imgView.frame.size.height+10, 260, 18)];
    textLab.text = @"平台目前不支持个人用户配货上门服务";
    textLab.font = [UIFont systemFontOfSize:13];
    textLab.textColor = [UIColor darkGrayColor];
    textLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textLab];
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
