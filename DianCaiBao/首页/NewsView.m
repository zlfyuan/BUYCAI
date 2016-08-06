//
//  NewsView.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "NewsView.h"
#import "LunbopageView.h"

@implementation NewsView
{
    UILabel *lab;
    NSMutableArray *btnArr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame imgArr:(NSArray *)imgArr btnTitleArr:(NSArray *)titleArr backblock:(void(^)(NSInteger index))block
{
    if ([super initWithFrame:frame]) {
        
       [self setUIWithFrame:frame imgArr:imgArr btnTitleArr:titleArr block:block];
    }
    return self;
}

-(void)setUIWithFrame:(CGRect)frame imgArr:(NSArray *)imgArr btnTitleArr:(NSArray *)titleArr block:(void(^)(NSInteger))block
{
   LunbopageView *pageView = [LunbopageView pageView];
    pageView.frame = CGRectMake(0,0, frame.size.width, 160);
    pageView.imageNames = imgArr;
    pageView.otherColor = [UIColor whiteColor];
    pageView.currenColor = [UIColor orangeColor];
    [self addSubview:pageView];
    
    CGFloat margin = (frame.size.width-3*90)/4;
    CGFloat w = 90;
    CGFloat h = 30;
    btnArr = [NSMutableArray new];
    for (int i=0; i<3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((i+1)*margin+i*w,pageView.frame.origin.y+pageView.frame.size.height+15, w, h)];
        [btnArr addObject:btn];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setBackgroundColor:[UIColor grayColor]];
        btn.layer.cornerRadius = 11;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=100+i;
        [self addSubview:btn];
        self.block=block;
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,pageView.frame.origin.y+pageView.frame.size.height+30+h,self.frame.size.width, 10)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    UIView *lastView = [[UIView alloc]initWithFrame:CGRectMake(0, lineView.frame.origin.y+lineView.frame.size.height, frame.size.width,self.frame.size.width)];
    [self addSubview:lastView];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 35)];
    leftView.backgroundColor = [UIColor orangeColor];
    [lastView addSubview:leftView];
    lab = [[UILabel alloc]initWithFrame:CGRectMake(leftView.frame.origin.x+leftView.frame.size.width+10, 0, 120, 30)];
    lab.text = @"全部";
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:18];
    [lastView addSubview:lab];
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 35, frame.size.width, 1)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [lastView addSubview:lineView2];
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, lineView2.frame.origin.y+lineView2.frame.size.height+10, frame.size.width, 1)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    [lastView addSubview:lineView3];
}

#pragma mark 点击事件的方法.
-(void)btnClicked:(id)sender
{
    UIButton *btn=sender;
    for (UIButton *button in btnArr) {
        if (btn==button) {
            button.backgroundColor=[UIColor orangeColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            button.backgroundColor=[UIColor grayColor];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    switch (btn.tag-100) {
        case 0:
            lab.text = @"行业新闻";
            break;
        case 1:
            lab.text = @"农业百科";
            break;
        case 2:
            lab.text = @"最新广告";
            break;
        default:
            break;
    }
    if (self.block) {
        self.block(btn.tag-100);
    }
}
@end
