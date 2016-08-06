//
//  FirstPageViewController.m
//  点菜宝
//
//  Created by 汤文洪 on 16/8/2.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "FirstPageViewController.h"
#import "LunbopageView.h"
#import "chooseViewController.h"
#import "SearchViewController.h"
#import "ClassifyViewController.h"
#import "ZLFCityMode.h"
#import "ShowMessage.h"
#import "NewsViewController.h"
#import <MJExtension.h>
@interface FirstPageViewController ()<UITextFieldDelegate>{
    LunbopageView *pageView;
    CGFloat h;
    CGFloat dpxxY;
    UITextField *searchTf;
    CGFloat AllHeight;
    ZLFCityMode *_cityMode;
    UIButton *_ltBtn;
    
}
/**城市数据*/
@property (nonatomic, strong)NSMutableArray *citysData;
@end

@implementation FirstPageViewController
-(NSMutableArray *)citysData{
    if (_citysData == nil) {
        _citysData = [NSMutableArray new];
    }
    return _citysData;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *parms = [NSMutableDictionary new];
    [[LXGNetWorkQuery shareManager] AFrequestData:@"10000" HttpMethod:@"POST" params:parms completionHandle:^(id result) {
//        HULog(@"%@",result[@"data"][@"city"]);
        self.citysData = [ZLFCityMode mj_objectArrayWithKeyValuesArray:result[@"data"][@"city"]];
        
    } errorHandle:^(NSError *result) {
        HULog(@"请求失败%@",result);
    }];
    
    [self setNav];
    [self setLB];
    [self setUI];
    
    
}

-(void)setNav
{
    // iconfont-weizhi  iconfont-xiaoxi
    
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-5; //改barbuttonitem 用于设置下面的barbutton距离边框的距离.
    //导航左按钮
    _ltBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    [_ltBtn setImage:[UIImage imageNamed:@"iconfont-weizhi"] forState:UIControlStateNormal];
    [_ltBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ltBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [_ltBtn setTitle:@"南昌" forState:UIControlStateNormal];
    _ltBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_ltBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 18, 0)];
    [_ltBtn setTitleEdgeInsets:UIEdgeInsetsMake(18, -20, 0, 0)];
    [_ltBtn addTarget:self action:@selector(choose_BtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ltBarBtn=[[UIBarButtonItem alloc]initWithCustomView:_ltBtn];
    self.navigationItem.leftBarButtonItems=@[negativeSpacer,ltBarBtn];
    
    UIButton *rtBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 35)];
    [rtBtn addTarget:self action:@selector(rtBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0 , 20, 20)];
    imgV2.image = [UIImage imageNamed:@"iconfont-xiaoxi"];
    [rtBtn addSubview:imgV2];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 25, 15)];
    lab2.text = @"消息";
    lab2.textColor = [UIColor whiteColor];
    lab2.font = [UIFont systemFontOfSize:10];
    [rtBtn addSubview:lab2];
    UIBarButtonItem *rtBarBtn=[[UIBarButtonItem alloc]initWithCustomView:rtBtn];
    self.navigationItem.rightBarButtonItems=@[negativeSpacer,rtBarBtn];
    
    searchTf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 130, 30)];
//    searchTf.enabled = NO;
    searchTf.delegate = self;
    searchTf.layer.cornerRadius = 5.0;
    searchTf.placeholder = @"         请输入你喜欢的商品        🔍 ";
    searchTf.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView=searchTf;
}


-(void)setLB
{
    
}


-(void)setUI
{
    UIScrollView *bottoomScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.view.frame.size.height-self.tabBarController.view.frame.size.height)];
    bottoomScroll.bounces = NO;
    [self.view addSubview:bottoomScroll];
    
    pageView = [LunbopageView pageView];
    pageView.frame = CGRectMake(0,0, self.view.frame.size.width, 160);
    pageView.imageNames = @[@"Three",@"Two"];
    pageView.otherColor = [UIColor whiteColor];
    pageView.currenColor = [UIColor orangeColor];
    [bottoomScroll addSubview:pageView];
    
    AllHeight += pageView.frame.size.height;
    
    NSArray *bntArr = @[@"惊爆促销",@"上市新品",@"绿色有机",@"一键购买"];
    NSArray *colorArr = @[
        [UIColor colorWithRed:124/255.f green:209.0/255.f blue:45.0/255.f alpha:1.0],
        [UIColor colorWithRed:98/255.f green:171.0/255.f blue:30.0/255.f alpha:1.0],
        [UIColor colorWithRed:78/255.f green:141.0/255.f blue:21.0/255.f alpha:1.0],
        [UIColor colorWithRed:233/255.f green:101.0/255.f blue:26.0/255.f alpha:1.0]];
    CGFloat W = self.view.frame.size.width/4;
    for (int i=0; i<4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0+i*W, pageView.frame.origin.y+pageView.frame.size.height/*h-65*/, W, 40)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font =[UIFont systemFontOfSize:15];
        btn.backgroundColor =colorArr[i];
        [btn setTitle:bntArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(otherService) forControlEvents:UIControlEventTouchUpInside ];
        [bottoomScroll addSubview:btn];
        AllHeight += 40;
        h = btn.frame.origin.y + btn.frame.size.height+20;
    }
    
    NSArray *textArr = @[@"本地/特菜",@"蔬菜",@"禽蛋/肉类",@"冻品",@"米面粮油",@"豆制类品",@"水发类",@"更多",];
    NSArray *imgArr = @[@"icon-1",@"icon-2",@"icon-3",@"icon-4",@"icon-5",@"icon-6",@"icon-7",@"icon-8",];
    for (int i=0; i<8; i++)
    {
        CGFloat megin=(self.view.frame.size.width-200)/5;
        UIButton *but = [[UIButton alloc]initWithFrame:(CGRect){((i%4)+1)*megin+(i%4)*50,h+(i/4)*70+(i/4)*30, 60, 80}];
        but.tag = i + 1000;
        [but addTarget:self action:@selector(buttonCategroy:) forControlEvents:UIControlEventTouchUpInside];
        [bottoomScroll addSubview:but];
        UIImageView *userImgView=[[UIImageView alloc]initWithFrame:CGRectMake(5,5, 50, 50)];
        userImgView.image  = [UIImage imageNamed:imgArr[i]];
        [but addSubview:userImgView];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(userImgView.x,userImgView.height + userImgView.y, 60, 30)];
        lab.text = textArr[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        [but addSubview:lab];
        dpxxY = but.frame.origin.y-90;
        AllHeight += 200;
        
    }
    
    UILabel *dpxx = [[UILabel alloc]initWithFrame:CGRectMake(0,dpxxY + 180, self.view.frame.size.width, 40)];
    dpxx.backgroundColor = [UIColor greenColor];
    dpxx.text = @"        店铺信息";
    dpxx.textColor  = [UIColor whiteColor];
    [bottoomScroll addSubview:dpxx];
    AllHeight += 40;
    
    UIView *detailView = [[[NSBundle mainBundle]loadNibNamed:@"ZPXXView" owner:nil options:nil]lastObject];
    detailView.frame = CGRectMake(0, dpxx.frame.origin.y+dpxx.frame.size.height, self.view.frame.size.width, 523);
    [bottoomScroll addSubview:detailView];
    AllHeight += 526;
    
    UIView *lastView = [[UIView alloc]initWithFrame:CGRectMake(0,detailView.frame.origin.y+detailView.frame.size.height, self.view.frame.size.width, 50)];
    lastView.backgroundColor = [UIColor colorWithRed:234/255.f green:234.0/255.f blue:234.0/255.f alpha:1.0];
    [bottoomScroll addSubview:lastView];
    UILabel *provideDetailLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-100, 10, 200, 30)];
    provideDetailLab.textAlignment = NSTextAlignmentCenter;
    provideDetailLab.textColor = [UIColor lightGrayColor];
    provideDetailLab.font = [UIFont systemFontOfSize:15];
    provideDetailLab.text = @"由 嘉瑞科技 提供技术支持";
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:provideDetailLab.text];
    NSRange noteRnage = NSMakeRange([[noteStr string]rangeOfString:@"嘉瑞科技"].location, [[noteStr string]rangeOfString:@"嘉瑞科技"].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] range:noteRnage];
    [provideDetailLab setAttributedText:noteStr];
    [lastView addSubview:provideDetailLab];
    
    
    
    bottoomScroll.contentSize = CGSizeMake(self.view.frame.size.width, AllHeight-1400);
    
}
#pragma mark------------------分类按钮监听
-(void)buttonCategroy:(UIButton *)btn{
//    ClassifyViewController *cateVC = [[ClassifyViewController alloc]init];
//    [self.navigationController pushViewController:cateVC animated:YES];
}

#pragma mark  -searchController协议方法.
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [searchTf resignFirstResponder];
    SearchViewController *ssv = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:ssv animated:YES];
    return YES;
}


-(void)choose_BtnClicked
{
    chooseViewController *cv = [[chooseViewController alloc]init];
    cv.CityModeData = self.citysData;
    [cv setCity:^(NSString *city) {
         [_ltBtn setTitle:city forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:cv animated:YES];
}

-(void)rtBtnClicked{
    NewsViewController *nv = [[NewsViewController alloc]init];
    [self.navigationController pushViewController:nv animated:YES];
}


-(void)otherService
{
    [ShowMessage showMessage:@"敬请期待" duration:2];
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
