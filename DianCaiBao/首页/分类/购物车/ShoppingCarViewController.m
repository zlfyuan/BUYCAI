//
//  ShoppingCarViewController.m
//  点菜宝
//
//  Created by 汤文洪 on 16/8/2.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "LoginViewController.h"
#import "noneShoppingCar.h"

@interface ShoppingCarViewController ()

@end

@implementation ShoppingCarViewController

-(void)viewDidAppear:(BOOL)animated
{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 30)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self setUI];
    
}

-(void)setUI
{
    noneShoppingCar *nv = [[noneShoppingCar alloc]initWithFrame:self.view.frame];
    [self.view addSubview:nv];
}

-(void)btnClicked
{
    LoginViewController *lv = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:lv animated:YES];
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
