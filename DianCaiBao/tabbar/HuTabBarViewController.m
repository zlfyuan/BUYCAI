//
//  HuTabBarViewController.m
//  自定义taberbar
//
//  Created by 汤文洪 on 16/6/6.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "HuTabBarViewController.h"
#import "FirstPageViewController.h"
#import "ClassifyViewController.h"
#import "ShoppingCarViewController.h"
#import "MyAccountViewController.h"
@interface HuTabBarViewController ()

@end

@implementation HuTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //2后面带有这个UI_APPEARANCE_SELECTOR都可以统一设置文字不能
    NSMutableDictionary *attr=[NSMutableDictionary dictionary];
    attr[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    attr[NSForegroundColorAttributeName]=[UIColor grayColor];
    
    NSMutableDictionary *selectattr=[NSMutableDictionary dictionary];
    selectattr[NSFontAttributeName]=attr[NSFontAttributeName];
    selectattr[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    
    UITabBarItem *itm=[UITabBarItem appearance];
    [itm setTitleTextAttributes:attr forState:UIControlStateNormal];
    [itm setTitleTextAttributes:selectattr  forState: UIControlStateSelected];
    
//    UIViewController *v1=[[UIViewController alloc]init];
//    v1.view.backgroundColor=[UIColor redColor];
//    v1.tabBarItem.title=@"精华";
//    v1.tabBarItem.image=[UIImage imageNamed:@"tabBar_essence_icon"];
//调用自定义方法
    [self setupChild:[[FirstPageViewController alloc]init] title:@"首页" image:@"home-1" selectedImage:@"home-2"];
    [self setupChild:[[ClassifyViewController alloc]init] title:@"分类" image:@"classify--1" selectedImage:@"classify-2"];
    [self setupChild:[[ShoppingCarViewController alloc]init] title:@"购物车" image:@"gouwuche-1" selectedImage:@"gouwuche--2"];
    [self setupChild:[[MyAccountViewController alloc]init] title:@"我的账户" image:@"mine-1" selectedImage:@"mine-2"];
    
    
    
}
//获得tabbar里的button 的frame值
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //NSLog(@"%@",self.tabBar.subviews);
}
//初始化子控制器
-(void)setupChild:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //添加图片和文字
    vc.navigationItem.title=title;
    
    vc.tabBarItem.title=title;
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0]} forState:UIControlStateSelected];
     vc.tabBarItem.image=[UIImage imageNamed:image];
    vc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImage];
 vc.tabBarItem.selectedImage=[vc.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc.view.backgroundColor=[UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    vc.view.backgroundColor=[UIColor whiteColor];
//    [self addChildViewController:vc];
    
    //包装一个导航控制器，添加导航栏为tabbarcontroller的子控制器
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    
    nav.navigationBar.translucent=NO;
    nav.navigationBar.barTintColor=[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0];
    nav.navigationBar.tintColor=[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:23]}];
    [self addChildViewController:nav];
}

@end
