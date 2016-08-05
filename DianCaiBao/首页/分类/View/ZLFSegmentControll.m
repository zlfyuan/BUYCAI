//
//  ZLFSegmentControll.m
//  DianCaiBao
//
//  Created by zluof on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ZLFSegmentControll.h"

@implementation ZLFSegmentControll
{
    NSMutableArray* _buts;
}

typedef void(^clickBlock)(NSInteger index);


-(instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles ClickBlock:(void (^)(NSInteger))block
{
    if (self = [super initWithFrame:frame])
    {
        _titles = titles;
        _buts = [NSMutableArray array];
        self.clickBlock = ^(NSInteger index, UIButton* button){
            block(index);
        };
        if (titles.count > 5) {
            self.contentSize = (CGSize){self.bounds.size.width / 5 * titles.count, self.bounds.size.height};
        }else{
            self.contentSize = self.bounds.size;
        }
        self.showsHorizontalScrollIndicator = NO;
        self.duration = 0.7;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    //初始化按钮
    for (NSInteger i = 0; i < _titles.count; i++)
    {
        UIButton* but = [[UIButton alloc] initWithFrame:CGRectMake(self.contentSize.width / _titles.count * i, 0, self.contentSize.width / _titles.count, self.contentSize.height - 2)];
        but.tag = 100 + i;
        [but setTitle:_titles[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        [_buts addObject:but];
        [self addSubview:but];
    }
    
    //初始化指示器
    if (_titles.count > 5) {
        _pointerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 2, self.bounds.size.width / 5, 2)];
    }else{
        _pointerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 2, self.bounds.size.width / _titles.count, 2)];
    }
    _pointerView.backgroundColor = [UIColor redColor];
    [self addSubview:_pointerView];
}

-(void)butClick:(UIButton*)sender
{
    for (UIButton* button in _buts)
    {
        if (sender == button)
            button.selected = YES;
        else
            button.selected = NO;
    }
    
    [UIView animateWithDuration:self.duration animations:^{
        _pointerView.center = (CGPoint){sender.center.x, _pointerView.center.y};
    } completion:^(BOOL finished) {
    }];
    
    [UIView animateWithDuration:self.duration animations:^{
        if (_buts.count > 5 && sender.tag - 100 > 1 && _buts.count - (sender.tag - 100) > 2) {
            self.contentOffset = (CGPoint){self.bounds.size.width / 5 * (sender.tag - 100 - 2), self.contentOffset.y};
        }else if (sender.tag - 100 < 2){
            self.contentOffset = (CGPoint){0, self.contentOffset.y};
        }else if(sender.tag - 100 == _buts.count - 2){
            self.contentOffset = (CGPoint){self.bounds.size.width / 5 * (sender.tag - 100 - 3), self.contentOffset.y};
        }
    } completion:^(BOOL finished) {
    }];
    
    self.clickBlock(sender.tag - 100, sender);
    
    if ([self.YLdelegate respondsToSelector:@selector(buttonClick:)])
    {
        [self.YLdelegate buttonClick:sender];
    }
}

-(void)setButTitleNormalColor:(UIColor *)butTitleNormalColor
{
    for (UIButton* button in _buts)
    {
        [button setTitleColor:butTitleNormalColor forState:UIControlStateNormal];
    }
}

-(void)setButTitleSelectedColor:(UIColor *)butTitleSelectedColor
{
    for (UIButton* button in _buts)
    {
        [button setTitleColor:butTitleSelectedColor forState:UIControlStateSelected];
    }
}

-(void)setBgColor:(UIColor *)bgColor
{
    self.backgroundColor = bgColor;
}

-(void)setPointerColor:(UIColor *)pointerColor
{
    _pointerView.backgroundColor = pointerColor;
}

-(void)setSelected:(NSInteger)selected
{
    if (selected >= _buts.count)
    {
        selected = 0;
    }
    [self butClick:_buts[selected]];
}

@end
