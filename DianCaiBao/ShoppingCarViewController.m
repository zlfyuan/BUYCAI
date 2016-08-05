 //
//  ShoppingCarViewController.m
//  点菜宝
//
//  Created by 汤文洪 on 16/8/2.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "LoginViewController.h"

@interface ShoppingCarViewController ()

@end

@implementation ShoppingCarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 30)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
}
-(void)btnClicked
{
    LoginViewController *lv = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:lv animated:YES];
}


@end
