//
//  NewsViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsView.h"
#import "NewsTableViewCell.h"
#import "NewsDetailViewController.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_newsTableView;
    NSArray *_tbvArr;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUI];
}

-(void)setNav{
    self.title = @"新闻中心";
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 13, 25)];
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-10;
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lt = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lt];
}

-(void)setUI
{
    _newsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height-44) style:UITableViewStyleGrouped];
    _newsTableView.dataSource = self;
    _newsTableView.delegate = self;
    _newsTableView.bounces = NO;
    [self.view addSubview:_newsTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 275;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"myCell";
    NewsTableViewCell *MyCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!MyCell) {
        MyCell = [[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:nil options:nil]lastObject];
        MyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MyCell.HeadImgView.image = [UIImage imageNamed:@"Address"];
    MyCell.NewsTitle.text = @"红壳鸡蛋PK白壳鸡蛋,谁能胜出?";
    MyCell.newsText.text = @"你去市场上购买鸡蛋的时候是否会纠结于购买哪种鸡蛋......好?";
    return MyCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NewsView *nv = [[NewsView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 275) imgArr:@[@"Three",@"Two"] btnTitleArr:@[@"行业新闻",@"农业百科",@"最新广告"]backblock:^(NSInteger index) {
        NSLog(@"%ld",index);
        
        //切换网络数据.
        switch (index) {
            case 0:
                //请求行业新闻数据
               
                break;
                
            case 1:
                //请求农业百科数据
               
                break;
                
            case 2:
                //请求最新广告数据
                
                break;
                
            default:
                break;
        }
        
    }];
    return nv;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailViewController *ndv = [[NewsDetailViewController alloc]init];
    [self.navigationController pushViewController:ndv animated:YES];
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
