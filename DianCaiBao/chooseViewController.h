//
//  chooseViewController.h
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/2.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLFCityMode;
@interface chooseViewController : UIViewController
/**城市模型数据*/
@property (nonatomic, strong)NSMutableArray *CityModeData;
/**block回调城市名*/
@property (nonatomic,copy)void(^city)(NSString *cit);
@end
