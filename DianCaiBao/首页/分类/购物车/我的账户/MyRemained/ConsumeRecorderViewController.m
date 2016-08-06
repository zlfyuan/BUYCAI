//
//  ConsumeRecorderViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/5.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ConsumeRecorderViewController.h"
#import "ConsumeRecoderTableViewCell.h"

@interface ConsumeRecorderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *currentNumlab;
    UITableView *BillTableView;
}
@end

@implementation ConsumeRecorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

-(void)setUI
{
    currentNumlab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-80, 25, 160, 25)];
    currentNumlab.text = @"当前余额: 27.27 元";
    currentNumlab.font = [UIFont systemFontOfSize:18];
    currentNumlab.textColor = [UIColor blackColor];
    [self.view addSubview:currentNumlab];
    
    BillTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, currentNumlab.frame.origin.y+currentNumlab.frame.size.height+15, self.view.frame.size.width,400) style:UITableViewStylePlain];
    BillTableView.dataSource = self;
    BillTableView.delegate = self;
    BillTableView.bounces = NO;
    [self.view addSubview:BillTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Mycell";
    ConsumeRecoderTableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!myCell) {
        myCell = [[[NSBundle mainBundle]loadNibNamed:@"ConsumeRecoderTableViewCell" owner:nil options:nil]firstObject];
        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
        myCell.frame = CGRectMake(0, 0, self.view.frame.size.height, 55);
    }
    myCell.timeLab.text = @"2016-06-25";
    myCell.accountLab.text = @"+10";
    myCell.typeLab.text = @"余额充值";
    myCell.detailLab.text = @"充值了10元";
    return myCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    CGFloat margin = (self.view.frame.size.width-300)/5;
    NSArray *textArr = @[@"消费时间",@"收入/支出",@"消费类别",@"消费说明"];
    for (int i=0; i<4; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((i+1)*margin+i*75, 10, 75, 30)];
        lab.text = textArr[i];
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:16];
        [topView addSubview:lab];
    }
//    [BillTableView addSubview:topView];
    return  topView;
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
