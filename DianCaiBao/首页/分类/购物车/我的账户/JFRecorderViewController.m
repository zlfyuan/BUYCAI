//
//  JFRecorderViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/5.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "JFRecorderViewController.h"

@interface JFRecorderViewController ()<UITableViewDataSource,UITableViewDelegate>
/**优惠券列表*/
@property(nonatomic,strong)UITableView *yhqTableView;
/**列表数据*/
@property(nonatomic,strong)NSArray *TbvArr;
@end

@implementation JFRecorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUI];
}

-(void)setNav{
    self.title = @"兑换优惠券";
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
    UIImageView *noneImgView = [[UIImageView alloc]initWithFrame:CGRectMake(byView.center.x-40, byView.center.y-40, 80, 80)];
    noneImgView.image = [UIImage imageNamed:@"noneData"];
    [byView addSubview:noneImgView];
    
    UILabel *noneLab = [[UILabel alloc]initWithFrame:CGRectMake(noneImgView.frame.origin.x, noneImgView.frame.origin.y+noneImgView.frame.size.height+5, 70, 20)];
    noneLab.font = [UIFont systemFontOfSize:16];
    noneLab.textColor = [UIColor orangeColor];
    noneLab.text = @"暂无数据";
    noneLab.textAlignment = NSTextAlignmentCenter;
    [byView addSubview:noneLab];
}

-(void)setUI
{
    _yhqTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,20, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
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
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_TbvArr.count == 0) {
        return self.view.frame.size.height-203;
    }
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 103;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"mycell";
    UITableViewCell *MyCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!MyCell) {
        MyCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        MyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_TbvArr.count == 0) {
        MyCell.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-203);
        [self setNoneUIByView:MyCell];
    }
    else
    {
        MyCell.textLabel.text = @"6666";
    }}
    return MyCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 103)];
    topView.backgroundColor = [UIColor whiteColor];
    
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    topLineView.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:topLineView];
    
    NSArray *bottomLabArr = @[@"总积分",@"已用积分",@"总条数"];
    NSArray *upLabArr = @[@"0",@"0",@"0"];
    CGFloat Width = (self.view.frame.size.width-2)/3;
    for (int i = 0 ; i<bottomLabArr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*Width+i*1, 1, Width, 70)];
        btn.backgroundColor = [UIColor whiteColor];
        //        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [topView addSubview:btn];
        
        UILabel *upLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, btn.frame.size.width, 30)];
        upLab.textColor = [UIColor blackColor];
        upLab.text = bottomLabArr[i];
        upLab.font = [UIFont systemFontOfSize:15];
        upLab.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:upLab];
        
        UILabel *bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(0, btn.frame.size.height-30, btn.frame.size.width, 30)];
        bottomLab.textColor = [UIColor redColor];
        bottomLab.text = upLabArr[i];
        bottomLab.font = [UIFont systemFontOfSize:15];
        bottomLab.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:bottomLab];
    }
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:lineView1];
    
    for (int i =0; i<2; i++) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((i+1)*Width+i*1, 0, 1, 71)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [topView addSubview:lineView];
    }
    
    CGFloat margin = (self.view.frame.size.width-300)/5;
    NSArray *textArr = @[@"时间",@"收入/支出",@"类别",@"详细说明"];
    for (int i=0; i<4; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((i+1)*margin+i*75, 75, 75, 35)];
        lab.text = textArr[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:16];
        [topView addSubview:lab];
    }
    
    UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0,110, self.view.frame.size.width, 1)];
    bottomLineView.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:bottomLineView];
    
    //    [BillTableView addSubview:topView];
    return  topView;
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
