//
//  segmentedcontrol.m
//  自定义Segmentedcontroll
//
//  Created by zluof on 16/3/24.
//  Copyright © 2016年 zluof. All rights reserved.
//

#import "segmentedcontrol.h"

#define MYWIDTH self.frame.size.width/4

#define MYHEIGHT self.frame.size.height-2

@implementation segmentedcontrol
{
    CGFloat M;
    UIButton *butn;
    UIView *lineView;
    NSMutableArray *arr;
}
-(instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titlesArray blackBlock:(void (^)(NSInteger))blocking blackBlockTitle:(void (^)(NSString *))blockCity
{
    if (self  = [super initWithFrame:frame]) {
        
        [self  setUI:titlesArray myblock:blocking Title:blockCity];
        
        self.block (0);
        [self addSubview:lineView];

    }
    return self;
}

-(void)setUI:(NSArray *)array myblock:(void (^)(NSInteger ))blocking Title:(void (^)(NSString *))blockCity
{
    arr = [NSMutableArray new];

    for (int i =0; i<array.count; i++) {
        butn = [[UIButton alloc]initWithFrame:CGRectMake(i*self.frame.size.width/array.count, 0, self.frame.size.width/array.count, MYHEIGHT)];
        [butn setTitle:array[i] forState:UIControlStateNormal];
        butn.titleLabel.font = [UIFont systemFontOfSize:15];
        [butn addTarget:self action:@selector(butnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            butn.selected = YES;
            [butn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
          

        }else{
          

        }
        [butn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [butn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        butn.tag = 100 + i;
        [self addSubview:butn];
        self.block = blocking;
        self.blockcity = blockCity;
        [arr addObject:butn];

    }
    
    
}

-(void)butnClicked:(id)sender
{
    UIButton *but = sender;
    

    for (UIButton *button in arr) {
              if (but == button) {
                  button.selected = YES;

        }else{
            button.selected = NO;


        }
    }
    
    if (self.block) {
        self.block (but.tag - 100);
        self.blockcity(but.titleLabel.text);
    }
}

@end
