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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame imgArr:(NSArray *)imgArr btnTitleArr:(NSArray *)titleArr
{
    if ([super initWithFrame:frame]) {
        
       [self setUIWithFrame:frame imgArr:imgArr btnTitleArr:titleArr];
    }
    return self;
}

-(void)setUIWithFrame:(CGRect)frame imgArr:(NSArray *)imgArr btnTitleArr:(NSArray *)titleArr
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
    NSMutableArray *btnArr = [NSMutableArray new];
    for (int i=0; i<3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((i+1)*margin+i*w, pageView.frame.origin.y+15, w, h)];
        [btnArr addObject:btn];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setBackgroundColor:[UIColor grayColor]];
        [self addSubview:btn];
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, pageView.frame.origin.y+pageView.frame.size.height+30+h, 10)];
    lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:lineView];
    UIView *lastView = [[UIView alloc]initWithFrame:CGRectMake(0, lineView.frame.origin.y+lineView.frame.size.height, frame.size.width, 40)];
    [self addSubview:lastView];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 35)];
    leftView.backgroundColor = [UIColor orangeColor];
    [lastView addSubview:leftView];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(leftView.frame.origin.x+leftView.frame.size.width, 0, 120, 30)];
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:18];
    [btnArr addObject:lab];
    [lastView addSubview:lab];
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 35, frame.size.width, 1)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [lastView addSubview:lineView2];
    
//    return btnArr;
}

@end
