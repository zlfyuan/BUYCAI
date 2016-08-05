//
//  ZLFDetaiCateMode.h
//  DianCaiBao
//
//  Created by zluof on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLFDetaiCateMode : NSObject
/**分类id*/
@property (nonatomic,copy)NSString *id;
/**单价*/
@property (nonatomic,copy)NSString *price;
/**菜品标题*/
@property (nonatomic,copy)NSString *title;
/**数量*/
@property (nonatomic,copy)NSString *nums;
/**介绍*/
@property (nonatomic,copy)NSString *instro;
/**积分*/
@property (nonatomic,copy)NSString *integral;
/**存货数量*/
@property (nonatomic,copy)NSString *inventory;
@end
