//
//  SearchViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/2.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
{
    UISearchBar *searchBar;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self setUI];
    
}

-(void)setUI
{
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(15, 10, self.view.frame.size.width-60, 25)];
    searchBar.placeholder = @"请输入你喜欢的商品";
    searchBar.layer.cornerRadius = 5.0f;
    searchBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    searchBar.layer.borderWidth = 1.0f;
    [self.view addSubview:searchBar];
    
    UIButton *CancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(searchBar.frame.origin.x+searchBar.frame.size.width+5, 15, 35, 18)];
    CancleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [CancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [CancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [CancleBtn addTarget:self action:@selector(cancleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CancleBtn];
    
}

-(void)cancleBtnClicked
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
