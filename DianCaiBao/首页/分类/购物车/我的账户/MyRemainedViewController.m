//
//  MyRemainedViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/5.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "MyRemainedViewController.h"
#import "RechargeViewController.h"
#import "ConsumeRecorderViewController.h"

@interface MyRemainedViewController ()<UIScrollViewDelegate>

/** 充值按钮 */
@property(nonatomic,strong)UIButton *RechargeBtn;
/** 消费记录按钮 */
@property(nonatomic,strong)UIButton *RecorderBtn;
/** 滚动视图 */
@property(nonatomic,strong)UIScrollView *bottomScroll;
/**滑动线条*/
@property(nonatomic,strong) UIView *slideLineView;

@end

@implementation MyRemainedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUI];

}

-(void)setNav{
    self.title = @"我的余额";
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-10;
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 13, 23)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lt = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lt];
}

-(void)setUI
{
    _RechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 35)];
    [_RechargeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_RechargeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    _RechargeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_RechargeBtn setTitle:@"我要充值" forState:UIControlStateNormal];
    [_RechargeBtn addTarget:self action:@selector(RechargeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_RechargeBtn];
    
    _RecorderBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 35)];
    [_RecorderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_RecorderBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    _RecorderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_RecorderBtn setTitle:@"消费记录" forState:UIControlStateNormal];
    [_RecorderBtn addTarget:self action:@selector(RecorderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_RecorderBtn];
    
    _slideLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 35, self.view.frame.size.width/2, 2)];
    _slideLineView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_slideLineView];
    
    _bottomScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 37, self.view.frame.size.width, self.view.frame.size.height-64-44-37)];
    _bottomScroll.pagingEnabled = YES;
    _bottomScroll.delegate = self;
    [self.view addSubview:_bottomScroll];
    
    RechargeViewController *rv = [[RechargeViewController alloc]init];
    ConsumeRecorderViewController *cnv = [[ConsumeRecorderViewController alloc]init];
    [self addChildViewController:cnv];
    [self addChildViewController:rv];
    
    rv.view.frame = CGRectMake(0, 0, self.view.frame.size.width, _bottomScroll.frame.size.height);
    cnv.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, _bottomScroll.frame.size.height);
   [_bottomScroll addSubview:rv.view];
    [_bottomScroll addSubview:cnv.view];
    
    _bottomScroll.contentSize = CGSizeMake(self.view.frame.size.width*2, _bottomScroll.frame.size.height);
}

#pragma mark - 按钮点击事件
-(void)RechargeBtnClicked:(id)sender
{
    UIButton *btn=sender;
    if (!btn.selected) {
        [_RecorderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btn.selected = NO;
    }
    else
    {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.5 animations:^{
        _slideLineView.frame=CGRectMake(0, 35,self.view.frame.size.width/2, 2);
        CGPoint offset = self.bottomScroll.contentOffset;
        offset.x = 0 * self.bottomScroll.frame.size.width;
        [self.bottomScroll setContentOffset:offset animated:YES];
    }];
}

-(void)RecorderBtnClicked:(id)sender
{
    UIButton *btn=sender;
    if (!btn.selected) {
        [_RechargeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.selected = NO;
    }
    else
    {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        _slideLineView.frame=CGRectMake(self.view.frame.size.width/2, 35, self.view.frame.size.width/2, 2);
        CGPoint offset = self.bottomScroll.contentOffset;
        offset.x = 1 * self.bottomScroll.frame.size.width;
        [self.bottomScroll setContentOffset:offset animated:YES];
    }];
}

#pragma mark - UIScrollViewDelegate代理
//1.scrollView结束了滚动动画以后(点击顶部的label)会调用这个方法，
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX / width;
    _slideLineView.frame=CGRectMake(index*self.view.frame.size.width/2, 35, self.view.frame.size.width/2, 2);
    if (index==0) {
        [_RechargeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_RecorderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (index==1)
    {
        [_RechargeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_RecorderBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
}

//2.手指松开scrollView时，它停止滚动后就会调用该方法(针对于用户的手势)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 3.时时监控的代理方法   滑动视图或点击label就是label的字体和颜色变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat Scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (Scale < 0 || Scale > 2) return;
    CGFloat bottomViewScale=scrollView.contentOffset.x/4;
    _slideLineView.frame=CGRectMake(bottomViewScale,35, self.view.frame.size.width/2, 2);
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
