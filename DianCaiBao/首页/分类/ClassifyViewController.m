//
//  ClassifyViewController.m
//  点菜宝
//
//  Created by 汤文洪 on 16/8/2.
//  Copyright © 2016年 Tang. All rights reserved.
//

#define SEGMENTFRAME (CGRect){0,0,self.view.frame.size.width*1.5,45}

#import "ClassifyViewController.h"
#import "chooseViewController.h"
#import "SearchViewController.h"
#import "ZLFCategroyCell.h"
#import "ZLFDetaiViewCell.h"
#import "segmentedcontrol.h"
#import "ZLFSegmentControll.h"
#import "ZLFBottomBuyView.h"
#import "LXGNetWorkQuery.h"
#import "ZLFCategroyMode.h"
#import "ZLFTopDataMode.h"
#import "ZLFCityMode.h"
#import "ZLFDetaiVegeTableMode.h"
#import "ZLFDetaiCateMode.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
@interface ClassifyViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    UISearchController *_searchController;
    UITextField *_searchTf;
    UIScrollView *_topScrollview;
    segmentedcontrol *_segmentView;
    UIButton *_ltBtn;
    NSMutableArray *_sub_cate;
//    ZLFBottomBuyView *_bottomView;
}
@property (nonatomic, strong)ZLFBottomBuyView *bottomView;

/**左边栏目*/
@property(nonatomic, strong)UITableView *categroyTableview;
/**左边栏数据*/
@property (nonatomic, strong)NSMutableArray *categroyData;
/**右边详细栏目*/
@property(nonatomic, strong)UITableView *detaiTableview;
/**右边栏详细数据*/
@property(nonatomic, strong)NSMutableArray *detaiVegeTableData;
/**顶部分栏*/
@property (nonatomic, strong)NSMutableArray  *topData;
/**城市数据*/
@property (nonatomic, strong)NSMutableArray *citysData;
@end

static NSString * const identfier = @"categroyCell";
@implementation ClassifyViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)cityRequest{
    NSMutableDictionary *parms = [NSMutableDictionary new];
    [[LXGNetWorkQuery shareManager] AFrequestData:@"10000" HttpMethod:@"POST" params:parms completionHandle:^(id result) {
//                HULog(@"%@",result[@"data"][@"city"]);
        self.citysData = [ZLFCityMode mj_objectArrayWithKeyValuesArray:result[@"data"][@"city"]];
        
    } errorHandle:^(NSError *result) {
        HULog(@"请求失败%@",result);
    }];

}
-(void)request{
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [[LXGNetWorkQuery shareManager] AFrequestData:@"30000" HttpMethod:@"POST" params:par completionHandle:^(id result) {
//                HULog(@"%@",result[@"data"][@"list"]);
        
        self.categroyData  = [ZLFCategroyMode mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
        [self.categroyTableview reloadData];
        
        [self.categroyTableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } errorHandle:^(NSError *result) {
        
        
    }];

}

-(void)requestVegetableWithCityId:(NSString *)cityID subList:(NSString *)subListId{
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    par[@"city_id"] =cityID;
    par[@"id"] = subListId;
    [[LXGNetWorkQuery shareManager] AFrequestData:@"30001" HttpMethod:@"POST" params:par completionHandle:^(id result) {
//            HULog(@"%@",result[@"data"][@"list"]);

        NSArray *arr =  result[@"data"][@"list"];
       self.detaiVegeTableData =  [ZLFDetaiVegeTableMode mj_objectArrayWithKeyValuesArray:arr];
        [self.detaiTableview reloadData];
        
        
    } errorHandle:^(NSError *result) {
        
        
    }];
    
}

#pragma mark-----通知监听
-(void)NotificationCenterShiping:(NSNotification *)info{
    HULog(@"%@",info.userInfo);
//    [_bottomView setPriceLabelText:info.userInfo[@"ALLPRICE"] Count:info.userInfo[@"COUNT"]];
//   _bottomView.ShipingCount.text = info.userInfo[@"COUNT"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NotificationCenter addObserver:self selector:@selector(NotificationCenterShiping:) name:@"NotificationCenterShipingInfo" object:nil];
    
    [self cityRequest];
    
    [self request];
    
    [self setNav];
    
    [self setupCategroyTableview];

    [self setupSegmentView];
    
    [self setupDetaiTableview];
    
    [self setupBottomView];
    
   
}
#pragma mark ————————————Tableview 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categroyTableview) {
        return self.categroyData.count;
    }else{
        return self.detaiVegeTableData.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categroyTableview) {
    ZLFCategroyCell *categroyCell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!categroyCell) {
        categroyCell = [[ZLFCategroyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
    }
    categroyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZLFCategroyMode *cateMode = self.categroyData[indexPath.row];
    categroyCell.textLabel.text = cateMode.name;
    return categroyCell;
    }else{
        NSString *identfiers = [NSString stringWithFormat:@"%ld%@",indexPath.row,identfier];
        ZLFDetaiViewCell *detaiViewCell = [tableView dequeueReusableCellWithIdentifier:identfiers];
        if (!detaiViewCell) {
            detaiViewCell = [[ZLFDetaiViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
        }
        detaiViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        detaiViewCell.vegeTableMode = self.detaiVegeTableData[indexPath.row];
        
        
        
        return detaiViewCell;

    }
    return nil;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categroyTableview) {

        ZLFCategroyMode *cateMode = self.categroyData[indexPath.row];
        _sub_cate = [ZLFTopDataMode mj_objectArrayWithKeyValuesArray:cateMode.sub_cate];
        [self.topData removeAllObjects];
        self.topData =nil;
        for (ZLFTopDataMode *topmode in _sub_cate) {
            [self.topData addObject: topmode.name];
        }
        [_segmentView removeFromSuperview];
        _segmentView = nil;
        [self addList:self.topData];
        
        NSString *title = [self.topData firstObject];
        NSString *cityId;
        for (ZLFCityMode *cityMode in self.citysData) {
            if ([cityMode.name isEqualToString:_ltBtn.titleLabel.text]) {
                cityId = cityMode.id;
            }
        }
        NSString *sublistid;
        for (ZLFTopDataMode *topmode in _sub_cate) {
            if ([title isEqualToString:topmode.name]) {
                sublistid = topmode.id;
            }
        }
        [self requestVegetableWithCityId:cityId subList:sublistid];
        
    }else{
        
        
    }
    
    
}
#pragma mark ————————————TextField 协议方法
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [_searchTf resignFirstResponder];
    SearchViewController *ssv = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:ssv animated:YES];
    return YES;
}

/**
 * 左上角地址选择按钮
 */
-(void)chooseBtnClicked{
    chooseViewController *cv = [[chooseViewController alloc]init];
    cv.CityModeData = self.citysData;
    [cv setCity:^(NSString *city) {
        [_ltBtn setTitle:city forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:cv animated:YES];
}


#pragma mark---顶部分栏
-(void)setupSegmentView{
    
    CGFloat x = self.categroyTableview.width;
    CGFloat y = self.navigationController.navigationBar.height;
    
    _topScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(x, y, self.view.width - x, 45)];
    _topScrollview.pagingEnabled = YES;
    _topScrollview.showsHorizontalScrollIndicator = YES;
    _topScrollview.showsVerticalScrollIndicator = NO;
    _topScrollview.bounces = YES;
    _topScrollview.backgroundColor = [UIColor whiteColor];
    _topScrollview.contentSize = CGSizeMake(580, 0);
    [self.view addSubview:_topScrollview];
    
   UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(x, _topScrollview.height + _topScrollview.y -2,_topScrollview.width, 2)];
    lineView.backgroundColor = MYCOLOR(0, 194, 16);
    [self.view addSubview:lineView];
  
    
    
    
#warning 子栏目数据默认第一行
    [self addList:@[@"全部"]];
}

-(void)addList:(NSArray *)topList{
    if (!_segmentView) {
        _segmentView = [[segmentedcontrol alloc]initWithFrame:SEGMENTFRAME title:topList blackBlock:^(NSInteger index) {
            
        } blackBlockTitle:^(NSString *title) {
            NSString *cityId;
            for (ZLFCityMode *cityMode in self.citysData) {
                if ([cityMode.name isEqualToString:_ltBtn.titleLabel.text]) {
                    cityId = cityMode.id;
                }
            }
            NSString *sublistid;
            for (ZLFTopDataMode *topmode in _sub_cate) {
                if ([title isEqualToString:topmode.name]) {
                    sublistid = topmode.id;
                }
            }
            [self requestVegetableWithCityId:cityId subList:sublistid];
            
        }];
        [_topScrollview addSubview:_segmentView];
    }
}

#pragma mark---底部栏目
-(void)setupBottomView{
    

    CGFloat y = self.categroyTableview.height + self.categroyTableview.y;
    CGFloat height = self.view.height/12;
    _bottomView = [[ZLFBottomBuyView alloc]initWithFrame:(CGRect){0,y,self.view.width,height}];
    [self.view addSubview:_bottomView];
    

}
#pragma mark---左边分类栏目
-(void)setupCategroyTableview{
  
    CGFloat height = self.navigationController.navigationBar.bounds.size.height;
    self.categroyTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, height,self.view.bounds.size.width/4*1.1 , self.view.height/1.4) style:UITableViewStylePlain];
    self.categroyTableview.showsVerticalScrollIndicator = NO;
    self.categroyTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.categroyTableview.rowHeight = 50;
    self.categroyTableview.dataSource = self;
    self.categroyTableview.delegate = self;
    self.categroyTableview.backgroundColor = MYCOLOR(246, 246, 246);
//    self.categroyTableview.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.categroyTableview];
    

    
    
}
#pragma mark---右边分类栏目
-(void)setupDetaiTableview{
    self.detaiTableview = [[UITableView alloc]initWithFrame:CGRectMake(self.categroyTableview.width, _topScrollview.height + _topScrollview.y,self.view.bounds.size.width - self.categroyTableview.width , self.view.height/1.4) style:UITableViewStylePlain];
    self.detaiTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.detaiTableview.showsVerticalScrollIndicator = YES;
    self.detaiTableview.rowHeight = self.view.height/7.5;
    self.detaiTableview.dataSource = self;
    self.detaiTableview.delegate = self;
    self.detaiTableview.backgroundColor = MYCOLOR(246, 246, 246);
//    self.detaiTableview.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.detaiTableview];

}
#pragma mark---界面搭建
-(void)setNav{
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
    [_ltBtn addTarget:self action:@selector(chooseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ltBarBtn=[[UIBarButtonItem alloc]initWithCustomView:_ltBtn];
    self.navigationItem.leftBarButtonItems=@[negativeSpacer,ltBarBtn];

    _searchTf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 130, 30)];
    //    searchTf.enabled = NO;
    _searchTf.delegate = self;
    _searchTf.layer.cornerRadius = 5.0;
    _searchTf.placeholder = @"         请输入你喜欢的商品        🔍 ";
    _searchTf.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView=_searchTf;
}

-(NSMutableArray *)categroyData{
    if (_categroyData == nil) {
        _categroyData = [NSMutableArray new];
    }
    return _categroyData;
}
-(NSMutableArray *)topData{
    if (_topData == nil) {
        _topData  =[NSMutableArray new];
    }
    return _topData;
}
-(NSMutableArray *)citysData{
    if (_citysData == nil) {
        _citysData = [NSMutableArray new];
    }
    return _citysData;
}
-(NSMutableArray *)detaiVegeTableData{
    if (!_detaiVegeTableData) {
        _detaiVegeTableData = [NSMutableArray new];
    }
    return _detaiVegeTableData;
}
@end
