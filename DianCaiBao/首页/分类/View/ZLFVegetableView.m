//
//  ZLFVegetableView.m
//  DianCaiBao
//
//  Created by zluof on 16/8/6.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ZLFVegetableView.h"
#import "ZLFDetaiVegeTableMode.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TWHLabel.h"
@implementation ZLFVegetableView
{
    ///菜品标题
    UILabel *_title;
    ///关闭按钮
    UIButton *_closeButton;
    ///菜品图
    UIImageView *_vegetableImg;
    ///价格
    TWHLabel *_priceLabel;
    ///积分
    UILabel *_integralLabel;
    ///库存
    UILabel *_inventoryLabel;
    ///描述
    UILabel *_descriptionLabel;
    
}
static ZLFVegetableView *manager = nil;
+(instancetype)showManger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZLFVegetableView alloc]init];
        
    });
    
    return manager;
}

-(void)showInfo:(CGRect)frame supView:(UIView *)view vegeTableInfo:(ZLFDetaiVegeTableMode *)mode{
    ZLFVegetableView *vege = [[ZLFVegetableView alloc]initWithFrame:frame vegeTableInfo:(ZLFDetaiVegeTableMode *)mode ];
    [view addSubview:vege];
    vege.hidden = YES;
    vege.alpha = 0;
    [UIView animateKeyframesWithDuration:0.8 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
        vege.alpha = 1;
        vege.hidden = NO;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}



-(instancetype)initWithFrame:(CGRect)frame vegeTableInfo:(ZLFDetaiVegeTableMode *)mode{
    if ( self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
        [self setUIvegeTableInfo:mode];
    }
    return self;
}
-(void)setUIvegeTableInfo:(ZLFDetaiVegeTableMode *)mode{
    
    CGFloat ShowX = self.width / 12.5;
    CGFloat ShowY = self.height / 22;
    UIView *showView = [[UIView alloc]initWithFrame:(CGRect){ShowX,ShowY, self.width - 2 *ShowX ,  self.height - 2 * ShowY}];
    showView.backgroundColor = [UIColor whiteColor];
    showView.layer.cornerRadius = 20;
    showView.layer.masksToBounds = YES;
    [self addSubview:showView];
    CGFloat X = 20;
    CGFloat Y = 10;
    _title = [[UILabel alloc]initWithFrame:(CGRect){X, Y , showView.width - 2*X,X}];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.text = mode.title;
//    _title.backgroundColor = [UIColor redColor];
    _title.textColor = [UIColor lightGrayColor];
    [showView addSubview:_title];
    
    _closeButton = [[UIButton alloc]initWithFrame:(CGRect){showView.width - _title.height - X  , _title.y, _title.height, _title.height}];
//    _closeButton.backgroundColor = [UIColor greenColor];
    [_closeButton setTitle:@"X" forState:UIControlStateNormal];
    [_closeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeClicked) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:_closeButton];
    
    
    _vegetableImg = [[UIImageView alloc]initWithFrame:(CGRect){_title.x, _title.y + _title.height+ 20, showView.width - 2 * _title.x,300}];
    NSString *imgurl = [NSString stringWithFormat:@"http://dcj.0791jr.com/data/attachment/item/%@",mode.img];
    [_vegetableImg sd_setImageWithURL:[NSURL URLWithString:imgurl]];
    [showView addSubview:_vegetableImg];
    
    NSString *price = [NSString stringWithFormat:@"价格：¥:%@ %@",mode.price,mode.unit];
    _priceLabel = [[TWHLabel alloc]initWithFrame:(CGRect){_title.x, _vegetableImg.y + _vegetableImg.height + 20, showView.width - 2*X,X} title:price font:nil rangeString:mode.price];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
//    _priceLabel.backgroundColor = [UIColor redColor];
//    _priceLabel.textColor = [UIColor lightGrayColor];
    [showView addSubview:_priceLabel];
    
    _integralLabel = [[UILabel alloc]initWithFrame:(CGRect){_title.x, _priceLabel.y + _priceLabel.height + 20 , showView.width - 2*X,X}];
    _integralLabel.textAlignment = NSTextAlignmentLeft;
    _integralLabel.text = [NSString stringWithFormat:@"积分:%@",mode.integral];
//    _integralLabel.backgroundColor = [UIColor redColor];
    _integralLabel.textColor = [UIColor lightGrayColor];
    [showView addSubview:_integralLabel];
    
    _inventoryLabel = [[UILabel alloc]initWithFrame:(CGRect){_title.x, _integralLabel.y + _integralLabel.height + 20 , showView.width - 2*X,X}];
    _inventoryLabel.textAlignment = NSTextAlignmentLeft;
    _inventoryLabel.text = [NSString stringWithFormat:@"库存:%@",mode.inventory];
//    _inventoryLabel.backgroundColor = [UIColor redColor];
    _inventoryLabel.textColor = [UIColor lightGrayColor];
    [showView addSubview:_inventoryLabel];
    
    _descriptionLabel = [[UILabel alloc]initWithFrame:(CGRect){_title.x, _inventoryLabel.y + _inventoryLabel.height + 20, showView.width - 2*X,2*X}];
    _descriptionLabel.textAlignment = NSTextAlignmentLeft;
    _descriptionLabel.numberOfLines = 0;
    [_descriptionLabel sizeToFit];
    _descriptionLabel.text = [NSString stringWithFormat:@"描述:%@",mode.intro];
    //    _descriptionLabel.backgroundColor = [UIColor redColor];
    _descriptionLabel.textColor = [UIColor lightGrayColor];
    [showView addSubview:_descriptionLabel];

    
}

-(void)closeClicked{
    [UIView animateKeyframesWithDuration:0.8 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateKeyframesWithDuration:0.8 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}



-(void)setDetaiMode:(ZLFDetaiVegeTableMode *)detaiMode{
    _detaiMode = detaiMode;
    _title.text = _detaiMode.title;
    
    
}


@end
