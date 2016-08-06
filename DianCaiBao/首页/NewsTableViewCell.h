//
//  NewsTableViewCell.h
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

/** 新闻图片 */
@property (weak, nonatomic) IBOutlet UIImageView *HeadImgView;
/** 新闻标题 */
@property (weak, nonatomic) IBOutlet UILabel *NewsTitle;
/** 新闻内容 */
@property (weak, nonatomic) IBOutlet UILabel *newsText;


@end
