//
//  MyJFViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "MyJFViewController.h"
#import "JFPrizeViewController.h"
#import "JFyhqViewController.h"
#import "JFRecorderViewController.h"

@interface MyJFViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *JFTableView;
    NSArray *imgArr;
    NSArray *titleArr;
}

@end

@implementation MyJFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.f green:242.0/255.f blue:242.0/255.f alpha:1.0];
    [self setNav];
    [self setData];
    [self setUI];
}

-(void)setNav{
    self.title = @"我的积分";
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-10;
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 13, 23)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lt = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lt];
}

-(void)setData
{
    imgArr = [NSArray new];
    titleArr = [NSArray new];
    imgArr = @[@"icon-prize",@"icon-coupon",@"icon-Service"];
    titleArr = @[@"积分兑换礼品",@"积分兑换优惠券",@"积分消费记录"];
}

-(void)setUI
{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 65, 20)];
    lab.textColor = [UIColor blackColor];
    lab.text = @"当前积分:";
    lab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:lab];
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(lab.frame.origin.x + lab.frame.size.width, lab.frame.origin.y, 70, 20)];
    detailLab.textColor = [UIColor orangeColor];
    detailLab.text = @"0";
    detailLab.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:detailLab];
    
    JFTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 132) style:UITableViewStylePlain];
    JFTableView.dataSource = self;
    JFTableView.delegate = self;
    JFTableView.bounces = NO;
    [self.view addSubview:JFTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!myCell) {
        myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(myCell.frame.origin.x, myCell.frame.size.height-15, self.view.frame.size.width-120, 2)];
    [myCell.contentView addSubview:lineView];
    
    myCell.imageView.image = [UIImage imageNamed:imgArr[indexPath.row]];
    myCell.textLabel.text = titleArr[indexPath.row];
    return myCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
       
    }
    else if (indexPath.row == 1)
    {
        JFyhqViewController *jfv = [[JFyhqViewController alloc]init];
        [self.navigationController pushViewController:jfv animated:YES];
    }else {
        JFRecorderViewController *jrv = [[JFRecorderViewController alloc]init];
        [self.navigationController pushViewController:jrv animated:YES];
    }
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
