//
//  MyYHQViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "MyYHQViewController.h"
#import "yhqDetailViewController.h"

@interface MyYHQViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *yhqTableView;
    NSArray *titleArr;
}
@end

@implementation MyYHQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.f green:242.0/255.f blue:242.0/255.f alpha:1.0];
    [self setNav];
    [self setData];
    [self setUI];
}

-(void)setNav{
    self.title = @"优惠券";
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
    titleArr = [NSArray new];
    titleArr = @[@"未使用优惠券",@"已使用优惠券",@"已过期优惠券"];
}

-(void)setUI
{
    yhqTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 330) style:UITableViewStyleGrouped];
    yhqTableView.dataSource = self;
    yhqTableView.delegate = self;
    yhqTableView.sectionFooterHeight = 0;
    yhqTableView.bounces = NO;
    [self.view addSubview:yhqTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0||section == 1) {
        return 10;
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!myCell) {
        myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0) {
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, myCell.frame.origin.y+10, 100, 30)];
        titleLab.font = [UIFont systemFontOfSize:18];
        titleLab.textColor = [UIColor blackColor];
        titleLab.text = @"优惠券说明";
        [myCell addSubview:titleLab];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(titleLab.frame.origin.x, titleLab.frame.origin.y+titleLab.frame.size.height+2, yhqTableView.frame.size.width-30, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [myCell addSubview:lineView];
        
        UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLab.frame.origin.y+titleLab.frame.size.height+5, yhqTableView.frame.size.width-30, 60)];
        detailLab.font = [UIFont systemFontOfSize:15];
        detailLab.textColor = [UIColor darkGrayColor];
        detailLab.text = @"优惠券用于在提交订单的时候使用获取优惠券,每次交易最多使用一张优惠券.";
        detailLab.numberOfLines = 0;
        [myCell addSubview:detailLab];
        
    }
    else
    {
        myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel *textLab = [[UILabel alloc]initWithFrame:CGRectMake(15, myCell.center.y-10, 100, 20)];
        textLab.text = titleArr[indexPath.section-1];
        textLab.font = [UIFont systemFontOfSize:16];
        [myCell addSubview:textLab];
        UILabel *numberLab = [[UILabel alloc]initWithFrame:CGRectMake(yhqTableView.frame.size.width-50, myCell.center.y-9, 30, 18)];
        numberLab.textColor = [UIColor orangeColor];
        numberLab.font = [UIFont systemFontOfSize:13];
        numberLab.text = @"0";
        [myCell addSubview:numberLab];
    }
    return myCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }
    else
    {
    yhqDetailViewController *ydv = [[yhqDetailViewController alloc]init];
    [self.navigationController pushViewController:ydv animated:YES];
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
