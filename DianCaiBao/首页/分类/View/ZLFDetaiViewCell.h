//
//  ZLFDetaiViewCell.h
//  DianCaiBao
//
//  Created by zluof on 16/8/3.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLFDetaiVegeTableMode;
@class ZLFDetaiCateMode;
@interface ZLFDetaiViewCell : UITableViewCell
/**菜品图片View*/
@property (nonatomic, strong)UIImageView *vegetableImage;
/**菜品名字*/
@property (nonatomic, strong)UILabel *vegetableName;
/**菜品单价*/
@property (nonatomic, strong)UILabel *vegetablePrice;
/**增加数量按钮*/
@property (nonatomic, strong)UIButton *addCount;
/**减少数量按钮*/
@property (nonatomic, strong)UIButton *subtractCount;
/**菜品数量*/
@property (nonatomic, strong)UILabel *vegetableCount;



@property (nonatomic, strong)ZLFDetaiVegeTableMode *vegeTableMode;
@property (nonatomic, strong)ZLFDetaiCateMode *vegeCateMode;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
