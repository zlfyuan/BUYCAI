//
//  JFPrizeViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/5.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "JFPrizeViewController.h"
#import "JFRecorderTableViewCell.h"

@interface JFPrizeViewController ()<UITableViewDataSource,UITableViewDelegate>
/**优惠券列表*/
@property(nonatomic,strong)UITableView *yhqTableView;
/**列表数据*/
@property(nonatomic,strong)NSArray *TbvArr;

@end

@implementation JFPrizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    _TbvArr = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    [self setUI];
}

-(void)setNav{
    self.title = @"兑换奖品";
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-10;
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 13, 23)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lt = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lt];
}

-(void)setNoneUIByView:(UIView *)byView
{
    UIImageView *noneImgView = [[UIImageView alloc]initWithFrame:CGRectMake(byView.center.x-60, byView.center.y-60, 120, 120)];
    noneImgView.image = [UIImage imageNamed:@"noneData"];
    [byView addSubview:noneImgView];
    
    UILabel *noneLab = [[UILabel alloc]initWithFrame:CGRectMake(noneImgView.frame.origin.x+10, noneImgView.frame.origin.y+noneImgView.frame.size.height+5, 100, 20)];
    noneLab.font = [UIFont systemFontOfSize:16];
    noneLab.textColor = [UIColor orangeColor];
    noneLab.text = @"暂无数据";
    noneLab.textAlignment = NSTextAlignmentCenter;
    [byView addSubview:noneLab];
}

-(void)setUI
{
    _yhqTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,20, self.view.frame.size.width, self.view.frame.size.height-44-64) style:UITableViewStylePlain];
    //    _yhqTableView.backgroundColor = [UIColor cyanColor];
    _yhqTableView.delegate = self;
    _yhqTableView.dataSource = self;
    _yhqTableView.bounces = NO;
    [self.view addSubview:_yhqTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_TbvArr.count == 0) {
        return 1;
    }
    return _TbvArr.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_TbvArr.count == 0) {
        return self.view.frame.size.height-140;
    }
    else
    {
      
        if (indexPath.row==_TbvArr.count) {
            return 20;
        }
         return 121;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (_TbvArr.count == 0) {
//        return 0;
//    }
//    return 20;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"mycell";
    UITableViewCell *MyCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!MyCell) {
        MyCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        MyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_TbvArr.count == 0) {
        MyCell.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-140);
        [self setNoneUIByView:MyCell];
    }
    else
    {
        if (indexPath.row==_TbvArr.count) {
            MyCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UIView *lastView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,20)];
            [MyCell addSubview:lastView];
            UILabel *loadAllLab = [[UILabel alloc]initWithFrame:CGRectMake(lastView.center.x-50, 0, 100, 20)];
            loadAllLab.textAlignment = NSTextAlignmentCenter;
            loadAllLab.text = @"已加载全部";
            loadAllLab.font = [UIFont systemFontOfSize:14];
            loadAllLab.textColor = [UIColor darkGrayColor];
            [lastView addSubview:loadAllLab];
            return MyCell;
        }
        else
        {
            JFRecorderTableViewCell *JFCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            JFCell = [[[NSBundle mainBundle]loadNibNamed:@"JFRecorderTableViewCell" owner:nil options:nil]lastObject];
            JFCell.selectionStyle = UITableViewCellSelectionStyleNone;
            JFCell.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-203);
        JFCell.addBtn.layer.borderWidth = 0.5;
        JFCell.addBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        JFCell.reduceBtn.layer.borderWidth = 0.5;
        JFCell.reduceBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        JFCell.exchangeNumLab.layer.borderWidth = 0.5;
        JFCell.exchangeNumLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
      
            return JFCell;
        }

    }
    return MyCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    detailView.backgroundColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0];
    [_yhqTableView addSubview:detailView];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width, 20)];
    lab.textColor = [UIColor darkGrayColor];
    lab.font = [UIFont systemFontOfSize:17];
    lab.text = @"奖品列表";
    [detailView addSubview:lab];
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(detailView.frame.size.width-95, 10, 65, 20)];
    detailLab.font = [UIFont systemFontOfSize:15];
    detailLab.textColor = [UIColor redColor];
    detailLab.text = @"当前积分:";
    [detailView addSubview:detailLab];
    UILabel *currentNumLab = [[UILabel alloc]initWithFrame:CGRectMake(detailView.frame.size.width-30, 10, 20, 20)];
    currentNumLab.font = [UIFont systemFontOfSize:15];
    currentNumLab.textColor = [UIColor redColor];
    currentNumLab.text = @"0";
    [detailView addSubview:currentNumLab];

    return detailView;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *lastView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,20)];
//    UILabel *loadAllLab = [[UILabel alloc]initWithFrame:CGRectMake(lastView.center.x-50, 0, 100, 20)];
//    loadAllLab.textAlignment = NSTextAlignmentCenter;
//    loadAllLab.text = @"已加载全部";
//    loadAllLab.font = [UIFont systemFontOfSize:14];
//    loadAllLab.textColor = [UIColor darkGrayColor];
//    [lastView addSubview:loadAllLab];
//    return lastView;
//}

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
