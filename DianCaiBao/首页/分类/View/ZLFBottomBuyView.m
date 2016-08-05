//
//  ZLFBottomBuyView.m
//  DianCaiBao
//
//  Created by zluof on 16/8/3.
//  Copyright © 2016年 Tang. All rights reserved.
//

#define ORANGECOLOR MYCOLOR(255, 150, 0)
#import "ZLFBottomBuyView.h"

@implementation ZLFBottomBuyView{
//    UIImageView *_shipImage;
//    UILabel *_priceLabel;
//    UILabel *_alertLabel;
//    UILabel *_ShipingCount;
//    UIButton *_onceShipBut;
//    UIButton *_addShipCar;
}
-(void)NotificationCenterShinged:(NSNotification *)info{
    self.ShipingCount.text = info.userInfo[@"COUNT"];
    self.priceLabel.text = info.userInfo[@"ALLPRICE"];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1;
        [NotificationCenter addObserver:self selector:@selector(NotificationCenterShinged:) name:@"NSNotificationship" object:nil];
        [self setUI];
    }
    return self;
}
-(void)setUI{
   
    _shipImage = [[UIImageView alloc]initWithFrame:(CGRect){self.center.x/16,-10,self.center.x/4,self.center.x/4}];
    _shipImage.image = [UIImage imageNamed:@"gouwuche"];
    _shipImage.layer.cornerRadius = _shipImage.width/2;
    _shipImage.layer.masksToBounds =YES;
    _shipImage.backgroundColor = ORANGECOLOR;
    [self addSubview:_shipImage];
    
    self.ShipingCount = [[UILabel alloc]initWithFrame:(CGRect){_shipImage.width + _shipImage.x,_shipImage.y,20,20}];
    self.ShipingCount.backgroundColor = ORANGECOLOR;
    self.ShipingCount.layer.cornerRadius = self.ShipingCount.width/2;
    self.ShipingCount.layer.masksToBounds = YES;
    self.ShipingCount.textColor = [UIColor whiteColor];
    self.ShipingCount.textAlignment = NSTextAlignmentCenter;
    self.ShipingCount.text = @"0";
    [self addSubview:self.ShipingCount];
    
    self.priceLabel = [[UILabel alloc]initWithFrame:(CGRect){self.ShipingCount.x + self.ShipingCount.width, _shipImage.center.y - 10,60,20}];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.text = @"¥21.36";
    [self addSubview:self.priceLabel];
    
    _alertLabel = [[UILabel alloc]initWithFrame:(CGRect){self.ShipingCount.x + self.ShipingCount.width, self.priceLabel.y + self.priceLabel.height,100,20}];
    _alertLabel.textColor = [UIColor grayColor];
    _alertLabel.font = [UIFont systemFontOfSize:13];
    _alertLabel.text = @"满100元免邮费";
    [self addSubview:_alertLabel];
    

    CGFloat allW = self.width - ( _alertLabel.width + _alertLabel.x);
    _onceShipBut = [[UIButton alloc]initWithFrame:(CGRect){_alertLabel.width + _alertLabel.x - 10,5, allW/2,self.height - 2*5}];
    _onceShipBut.layer.cornerRadius = 6;
    _onceShipBut.layer.masksToBounds = YES;
    _onceShipBut.backgroundColor = [UIColor orangeColor];
    [_onceShipBut setTitle:@"一键快购" forState:UIControlStateNormal];
    _onceShipBut.titleLabel.font = [UIFont systemFontOfSize:15];
    _onceShipBut.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_onceShipBut];
    
    _addShipCar = [[UIButton alloc]initWithFrame:(CGRect){_onceShipBut.width + _onceShipBut.x + 5,5, _onceShipBut.width,self.height - 2*5}];
    _addShipCar.layer.cornerRadius = 6;
    _addShipCar.layer.masksToBounds = YES;
    _addShipCar.backgroundColor = [UIColor redColor];
    [_addShipCar setTitle:@"加入购物车" forState:UIControlStateNormal];
    _addShipCar.titleLabel.font = [UIFont systemFontOfSize:15];
    _addShipCar.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_addShipCar];

    
    
    
    
   
}

-(void)setPriceLabelText:(NSString *)price Count:(NSString *)count{
    self.priceLabel.text = price;
    self.ShipingCount.text = count;
}
@end
