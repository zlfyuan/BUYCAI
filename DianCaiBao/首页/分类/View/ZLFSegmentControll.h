//
//  ZLFSegmentControll.h
//  DianCaiBao
//
//  Created by zluof on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentedControlDelegate <NSObject>

@optional

/**
 * 点击button的代理方法
 *
 * @param 点击的Button
 *
 * @return 无
 */
-(void)buttonClick:(UIButton*)button;

@end


@interface ZLFSegmentControll : UIScrollView


///包含按钮标题的数组
@property(nonatomic, strong)NSArray* titles;
///指示器
@property(nonatomic, strong)UIView* pointerView;
///背景颜色
@property(nonatomic, strong)UIColor* bgColor;
///按钮的正常时的字体颜色
@property(nonatomic, strong)UIColor* butTitleNormalColor;
///按钮选中时的颜色
@property(nonatomic, strong)UIColor* butTitleSelectedColor;
///指示器颜色
@property(nonatomic, strong)UIColor* pointerColor;
///指示器动画时间
@property(nonatomic, assign)NSTimeInterval duration;
///选中的按钮
@property(nonatomic, assign)NSInteger selected;

///点击按钮时的块，含有按钮的索引和按钮对象
@property(nonatomic, strong)void (^clickBlock)(NSInteger index, UIButton* button);
///代理属性
@property(nonatomic, strong)id<SegmentedControlDelegate> Segdelegate;

/**
 * 初始化方法
 * @param frame 大小和位置
 * @param titles 含有按钮的标题的数组
 * @param block 一个带有选中按钮的索引的块
 * @return 自定义的分段控件
 */
-(instancetype)initWithFrame:(CGRect)frame Titles:(NSArray*)titles ClickBlock:(void (^)(NSInteger index))block;
@end
