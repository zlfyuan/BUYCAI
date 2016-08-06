//
//  noneShoppingCar.h
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/3.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonBlock) (id sender);

@interface noneShoppingCar : UIView

-(void)addButtonAction:(ButtonBlock)block;

@end
