//
//  JFRecorderTableViewCell.h
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/6.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFRecorderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PrizeImgView;
@property (weak, nonatomic) IBOutlet UILabel *PrizeNameLab;
@property (weak, nonatomic) IBOutlet UILabel *PrizeJFNum;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UILabel *exchangeNumLab;

@end
