//
//  ZLFCategroyCell.m
//  DianCaiBao
//
//  Created by zluof on 16/8/3.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ZLFCategroyCell.h"

@implementation ZLFCategroyCell


- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    self.backgroundColor = selected ?  MYCOLOR(0, 194, 16) : MYCOLOR(246, 246, 246) ;
    self.textLabel.textColor = selected ?  [UIColor whiteColor]: [UIColor blackColor];
    [super setSelected:selected animated:animated];

}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.textLabel.font = [UIFont systemFontOfSize:15];

    self.textLabel.adjustsFontSizeToFitWidth = YES;
    
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    
}
@end
