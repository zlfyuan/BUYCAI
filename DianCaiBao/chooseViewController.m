//
//  chooseViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/2.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "chooseViewController.h"
#import "chooseCityTableViewCell.h"
#import "ZLFCityMode.h"
@interface chooseViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tbv;
    NSArray *syArr;
    NSMutableArray *cityArr;
}
@end

@implementation chooseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    cityArr = [NSMutableArray new];
    if (self.CityModeData.count == 0) {
        return;
    }
    for (ZLFCityMode *cityMode in self.CityModeData) {
        [cityArr addObject:cityMode.name];
    }
    [tbv reloadData];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setNav];
    
    [self setData];
    
    [self setUI];
}

-(void)setNav{
    self.title = @"选择城市";
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-10; //改barbuttonitem 用于设置下面的barbutton距离边框的距离.
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 13, 25)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lt = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItems=@[negativeSpacer,lt];;
}

-(void)setUI
{
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [self.view addSubview:search];
    
    tbv = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 330) style:UITableViewStylePlain];
    tbv.dataSource = self;
    tbv.delegate = self;
    tbv.bounces = NO;
    [self.view addSubview:tbv];
}

-(void)setData
{
    syArr = [NSArray new];
    syArr = @[@"H",@"N",@"P",@"X"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"mycell";
//    UITableViewCell *MyCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    chooseCityTableViewCell *MyCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    MyCell.frame = CGRectMake(0, 0,self.view.frame.size.width, 78);
    if (!MyCell) {
        MyCell =[[[NSBundle mainBundle]loadNibNamed:@"chooseCityCell" owner:nil options:nil]objectAtIndex:0];
        MyCell.selectionStyle = UITableViewCellSelectionStyleNone;
        MyCell.frame = CGRectMake(0, 0,self.view.frame.size.width, 78);
    }
    MyCell.suoyinLab.text = syArr[indexPath.row];
    if (cityArr.count == 0) {
          MyCell.cityLab.text =@"  ";
    }else{
          MyCell.cityLab.text = cityArr[indexPath.row];
    }
  
    MyCell.textView.backgroundColor = [UIColor colorWithRed:234/255.f green:234.0/255.f blue:234.0/255.f alpha:1.0];
    return MyCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     self.city(cityArr[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)returnBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
