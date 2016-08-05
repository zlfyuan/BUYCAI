//
//  ZLFBottomBuyView.h
//  DianCaiBao
//
//  Created by zluof on 16/8/3.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLFBottomBuyView : UIView
{
    UIImageView *_shipImage;
    
    UILabel *_alertLabel;
    
    UIButton *_onceShipBut;
    UIButton *_addShipCar;
}
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *ShipingCount;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)setPriceLabelText:(NSString *)price Count:(NSString *)count;
@end
