//
//  noneShoppingCar.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/3.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "noneShoppingCar.h"

@implementation noneShoppingCar
{
    UIImageView *shoppingCar;
    UILabel *detailLab;
    UIButton *goBuyButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.frame = frame;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    shoppingCar = [[UIImageView alloc]init];
    shoppingCar.image = [UIImage imageNamed:@"gouwuche-1"];
    [self addSubview:shoppingCar];
    
    detailLab = [[UILabel alloc]init];
    detailLab.font = [UIFont systemFontOfSize:13];
    detailLab.textColor = [UIColor lightGrayColor];
    detailLab.text = @"亲, 您的购物车还是空空的哦,快去装满它!";
    detailLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detailLab];
    
    goBuyButton = [[UIButton alloc]init];
    [goBuyButton setBackgroundColor:[UIColor whiteColor]];
    goBuyButton.layer.cornerRadius = 4.0;
    goBuyButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    goBuyButton.layer.borderWidth = 1.0;
    [goBuyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [goBuyButton setTitle:@"前去逛逛" forState:UIControlStateNormal];
    goBuyButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:goBuyButton];
}

-(void)layoutSubviews
{
    shoppingCar.frame = CGRectMake(self.center.x-55, 30, 110, 110);
    detailLab.frame = CGRectMake(self.center.x-120, shoppingCar.frame.origin.y+shoppingCar.frame.size.height+20, 240, 18) ;
    goBuyButton.frame = CGRectMake(self.center.x-45, detailLab.frame.origin.y+detailLab.frame.size.height+20, 90, 35);
}

@end
