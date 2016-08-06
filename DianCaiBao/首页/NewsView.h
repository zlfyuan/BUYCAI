//
//  NewsView.h
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnClickBlock)(NSInteger index);

@interface NewsView : UIView

@property(nonatomic,copy)btnClickBlock block;

-(instancetype)initWithFrame:(CGRect)frame imgArr:(NSArray *)imgArr btnTitleArr:(NSArray *)titleArr backblock:(void(^)(NSInteger index))block;

@end
