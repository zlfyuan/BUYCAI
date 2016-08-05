//
//  ZLFDetaiVegeTableMode.h
//  DianCaiBao
//
//  Created by zluof on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLFDetaiVegeTableMode : NSObject
/**菜品id*/
@property (nonatomic,copy)NSString *id;
/**单位*/
@property (nonatomic,copy)NSString *unit;
/**介绍*/
@property (nonatomic,copy)NSString *intro;
/**菜品分类*/
@property (nonatomic,strong)NSArray *fenlei;
/**菜品图片*/
@property (nonatomic,copy)NSString *img;
/**菜品标题*/
@property (nonatomic,copy)NSString *title;
/**单价*/
@property (nonatomic,copy)NSString *price;
/**存货数量*/
@property (nonatomic,copy)NSString *inventory;
/**产品id*/
@property (nonatomic,copy)NSString *product_id;
/**数量num*/
@property (nonatomic,copy)NSString *num;
/**积分*/
@property (nonatomic,copy)NSString *integral;
/**数量nums*/
@property (nonatomic,copy)NSString *nums;
@end
