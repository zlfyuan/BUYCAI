//
//  ZLFBottomBuyView.h
//  DianCaiBao
//
//  Created by zluof on 16/8/3.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLFBottomBuyView;

@protocol BottomDelegate <NSObject>
@required
-(void)bottomAndItem:(ZLFBottomBuyView *)bottomView item:(NSInteger)butag;

@end
@interface ZLFBottomBuyView : UIView
{
    UIImageView *_shipImage;
    
    UILabel *_alertLabel;
    
    UIButton *_onceShipBut;
    UIButton *_addShipCar;
}

/**单价*/
@property (nonatomic, strong)UILabel *priceLabel;
/**菜品数量*/
@property (nonatomic, strong)UILabel *ShipingCount;

/**代理*/
@property(nonatomic,weak)id<BottomDelegate> bottomdelegate;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)setPriceLabelText:(NSString *)price Count:(NSString *)count;

@end





