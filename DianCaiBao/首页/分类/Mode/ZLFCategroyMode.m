//
//  ZLFCategroyMode.m
//  DianCaiBao
//
//  Created by zluof on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ZLFCategroyMode.h"

@implementation ZLFCategroyMode

-(NSArray *)sub_cate{
    if (!_sub_cate ) {
        _sub_cate = [NSArray new];
    }
    return _sub_cate;
}

@end
