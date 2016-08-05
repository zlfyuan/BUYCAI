//
//  ZLFCategroyMode.h
//  DianCaiBao
//
//  Created by zluof on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLFCategroyMode : NSObject
/**分类id*/
@property (nonatomic,copy)NSString *id;
/**类目标识*/
@property (nonatomic,copy)NSString *spid;
/**子类目*/
@property (nonatomic,copy)NSArray *sub_cate;
/**类目名称*/
@property (nonatomic,copy)NSString *name;
@end
