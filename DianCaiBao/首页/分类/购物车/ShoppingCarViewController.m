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
#import "ClassifyViewController.h"
@interface ShoppingCarViewController ()

@end

@implementation ShoppingCarViewController

-(void)viewDidAppear:(BOOL)animated
{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.view.backgroundColor = [UIColor yellowColor];
    [self setUI];
    
}

-(void)setUI
{
    noneShoppingCar *nv = [[noneShoppingCar alloc]initWithFrame:self.view.frame];
    [nv addButtonAction:^(id sender) {
        
      //  [self.navigationController pushViewController:[[ClassifyViewController alloc]init] animated:YES];
        
    }];
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
