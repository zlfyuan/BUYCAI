//
//  MyAccountViewController.m
//  点菜宝
//
//  Created by 汤文洪 on 16/8/2.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "MyAccountViewController.h"
#import "LoginViewController.h"
#import "ModifyViewController.h"
#import "ManagerAddressViewController.h"
#import "MyJFViewController.h"
#import "MyYHQViewController.h"
#import "PersonInformationViewController.h"

@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"个人中心";
    [self setUI];
}

-(void)setUI
{
    UIScrollView *bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-44)];
    bottomScrollView.backgroundColor = [UIColor lightGrayColor];
    bottomScrollView.bounces = NO;
    [self.view addSubview:bottomScrollView];
    
    UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    userView.userInteractionEnabled = YES;
    UITapGestureRecognizer *userViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userViewTap)];
    userView.backgroundColor = [UIColor whiteColor];
    [userView addGestureRecognizer:userViewTap];
    [self.view addSubview:userView];
    UIImageView *UserimgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, userView.center.y-25, 50, 50)];
    UserimgView.layer.masksToBounds = YES;
    UserimgView.layer.cornerRadius = UserimgView.frame.size.width/2;
    UserimgView.image = [UIImage imageNamed:@"defalut_icon"];
    [userView addSubview:UserimgView];
    UILabel *userLab = [[UILabel alloc]initWithFrame:CGRectMake(UserimgView.frame.origin.x+UserimgView.frame.size.width+10, UserimgView.frame.origin.y+10, 40, 20)];
    userLab.text = @"游客";
    userLab.font = [UIFont systemFontOfSize:15];
    [userView addSubview:userLab];
    UILabel *userDetailLab = [[UILabel alloc]initWithFrame:CGRectMake(userLab.frame.origin.x, userLab.frame.origin.y+userLab.frame.size.height, 150, 18)];
    userDetailLab.font = [UIFont systemFontOfSize:13];
    userDetailLab.textColor = [UIColor lightGrayColor];
    userDetailLab.text = @"顾客电话:15070154362";
    [userView addSubview:userDetailLab];
    
    UIImageView *JTImgView = [[UIImageView alloc]initWithFrame:CGRectMake(userView.frame.size.width-30, userView.center.y-8, 8, 17)];
    JTImgView.image = [UIImage imageNamed:@"team_Rac-1"];
    [userView addSubview:JTImgView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, userView.frame.origin.y+userView.frame.size.height, self.view.frame.size.width, 1.5)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [bottomScrollView addSubview:lineView1];
    
    NSArray *bottomLabArr = @[@"我的余额",@"积分",@"优惠券",@"我的数据"];
    NSArray *upLabArr = @[@"0.00",@"0",@"0",@"0"];
    CGFloat Width = (self.view.frame.size.width-3)/4;
    for (int i = 0 ; i<4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*Width+i*1, lineView1.frame.origin.y+lineView1.frame.size.height, Width, 70)];
        btn.backgroundColor = [UIColor whiteColor];
//        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [bottomScrollView addSubview:btn];
        
        UILabel *upLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, btn.frame.size.width, 30)];
        upLab.textColor = [UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0];
        upLab.text = upLabArr[i];
        upLab.font = [UIFont systemFontOfSize:15];
        upLab.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:upLab];
        
        UILabel *bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(0, btn.frame.size.height-30, btn.frame.size.width, 30)];
        bottomLab.textColor = [UIColor blackColor];
        bottomLab.text = bottomLabArr[i];
        bottomLab.font = [UIFont systemFontOfSize:15];
        bottomLab.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:bottomLab];
    }
    for (int i =0; i<3; i++) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((i+1)*Width+i*1, lineView1.frame.origin.y+lineView1.frame.size.height, 1, 60)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [bottomScrollView addSubview:lineView];
    }
    
    UIView *gonggeView = [[UIView alloc]initWithFrame:CGRectMake(0, lineView1.frame.origin.y+lineView1.frame.size.height+70+8, self.view.frame.size.width, self.view.frame.size.height-64-44-70-lineView1.frame.size.height-userView.frame.size.height)];
    gonggeView.backgroundColor = [UIColor whiteColor];
    [bottomScrollView addSubview:gonggeView];
    
    NSArray *Arr = @[@"我的订单",@"我的地址",@"我的余额",@"我的积分",@"优惠券",@"我的数据",@"修改密码",@"退出登录"];
    NSArray *imgArr = @[@"iconfont-dingdan-0",@"iconfont-dizhi",@"iconfont-chongzhi",@"iconfont-jifen",@"iconfont-quan",@"iconfont-shuju",@"iconfont-mima",@"iconfont-out"];
    CGFloat BW = 60;
    CGFloat BH = 80;
    CGFloat marginX = (self.view.frame.size.width-180)/4;
    CGFloat marginY = 10;
    for (int i=0; i<8; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((i%3)*BW+((i%3)+1)*marginX,30+(i/3)*BH+((i/3)+1)*marginY, BW, BH)];
        btn.tag = i;
        [btn addTarget:self action:@selector(bntClicked:) forControlEvents:UIControlEventTouchUpInside];
        [gonggeView addSubview:btn];
//        btn.backgroundColor = [UIColor redColor];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        imgView.image = [UIImage imageNamed:imgArr[i]];
        [btn addSubview:imgView];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 60, 15)];
        lab.textColor = [UIColor darkGrayColor];
        lab.font = [UIFont systemFontOfSize:12];
        lab.text = Arr[i];
        lab.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:lab];
    }
}

-(void)userViewTap
{
    PersonInformationViewController *piv = [[PersonInformationViewController alloc]init];
    [self.navigationController pushViewController:piv animated:YES];
}

-(void)bntClicked:(id)sender
{
    UIButton *btn = sender;
    switch (btn.tag) {
        case 1:
        {
            ManagerAddressViewController *mav =[[ManagerAddressViewController alloc]init];
            [self.navigationController pushViewController:mav animated:YES];
        }
            break;
        case 3:
        {
            MyJFViewController *mjv =[[MyJFViewController alloc]init];
            [self.navigationController pushViewController:mjv animated:YES];
        }
            break;
        case 4:
        {
            MyYHQViewController *myv =[[MyYHQViewController alloc]init];
            [self.navigationController pushViewController:myv animated:YES];
        }
            break;
        case 6:
        {
            ModifyViewController *mv = [[ModifyViewController alloc]init];
            [self.navigationController pushViewController:mv animated:YES];
        }
            break;
        case 7:
        {
            [self quit];
        }
            break;
        default:
            break;
    }
}

-(void)quit
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"" message:@"你确定退出点菜君" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *conFirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        LoginViewController *lV = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lV animated:YES];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        
    [ac addAction:conFirmAction];
    [ac addAction:cancleAction];
    [self presentViewController:ac animated:YES completion:nil];
    
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
