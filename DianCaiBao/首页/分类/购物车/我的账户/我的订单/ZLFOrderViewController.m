//
//  ZLFOrderViewController.m
//  DianCaiBao
//
//  Created by zluof on 16/8/6.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ZLFOrderViewController.h"
#import "ZLFSegmentControll.h"
@interface ZLFOrderViewController ()

@end

@implementation ZLFOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.view.backgroundColor  = [UIColor whiteColor];
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-5;
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 13, 25)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lt = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lt];
    ZLFSegmentControll *segment = [[ZLFSegmentControll alloc]initWithFrame:(CGRect){0,0, self.view.width,SWIDTH/9.4 } Titles:@[@"全部",@"未支付",@"已支付",@"已成功",@"失败"] ClickBlock:^(NSInteger index) {
    }];
    segment.butTitleNormalColor = [UIColor blackColor];
    segment.butTitleSelectedColor = [UIColor orangeColor];
    [self.view addSubview:segment];
    
}


-(void)returnBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
