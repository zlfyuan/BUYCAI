//
//  JJYpageView.m
//  UI--21--分页功能的封装
//
//  Created by 揭建有 on 16/3/14.
//  Copyright © 2016年 揭建有. All rights reserved.
//

#import "LunbopageView.h"


@interface LunbopageView()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

/** 定时器*/
@property (nonatomic, strong)NSTimer *timer;

@end
@implementation LunbopageView

#pragma mark  初始化方法
/**
 * 当控件通过代码创建时,就会调用这个方法
 * 当控件通过代码创建时,想做一些初始化操作，应该在这个方法中执行
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 * 当控件从XIB、storyboard中创建完毕时，就会调用这个方法
 * 当控件从XIB、story中创建完毕后的初始化操作。应该在这个方法中执行
 */
- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.scrollView.backgroundColor = [UIColor cyanColor];
    
    [self startTimer];
}

+ (instancetype)pageView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

/**
 *当控件的尺寸发生改变的时候，会自动调用这个方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置scrollView的frame
    self.scrollView.frame = self.bounds;
    self.scrollView.bounces = NO;
    //获得scrollView的尺寸
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat scrollH = self.scrollView.frame.size.height;
    
    //设置pageControl
    CGFloat pageW = 100;
    CGFloat pageH = 20;
    CGFloat pageX = scrollW - pageW;
    CGFloat pageY = scrollH - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    //设置内容大小
    self.scrollView.contentSize = CGSizeMake(self.imageNames.count * scrollW, 0);
    
    //设置所有imageView的frame
    for (int i = 0; i < self.scrollView.subviews.count; i ++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.frame = CGRectMake(i * scrollW , 0, scrollW, scrollH);
    }
}

#pragma mark  setter方法的重写
- (void)setCurrenColor:(UIColor *)currenColor
{
    _currenColor = currenColor;
    
    self.pageControl.currentPageIndicatorTintColor = currenColor;
}

-(void)setOtherColor:(UIColor *)otherColor
{
    _otherColor = otherColor;
    self.pageControl.pageIndicatorTintColor = otherColor;
}

- (void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    
    //移除之前的所有imageView
    //让subviews数组中的所有对象都执行removeFromSuperview
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //根据图片名创建对应个数的imageView
    for (int i = 0; i < imageNames.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageNames[i]];
        [self.scrollView addSubview:imageView];
        imageView.tag=100+i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicked)];
        [imageView addGestureRecognizer:tap];
}
    
    //设置总页数
    self.pageControl.numberOfPages = imageNames.count;
    
    //当图片张数小于等于1时 圆点将不再显示
    self.pageControl.hidden = imageNames.count <= 1;//==self.pageControl.hidesForSinglePage = YES;
}

-(void)tapClicked
{

}

#pragma mark  UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
}

//用户的手只要在拖拽图片  定时器将停止工作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

//用户的手一松开图片  定时器将开始工作
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

#pragma mark  定时器的控制
- (void)startTimer
{
    //创建一个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    //为了防止用户在使用其他控件时scrollView能正常滚动 
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
     self.timer = nil;
}

/**
 *下一页
 */
- (void)nextPage
{
    [UIView animateWithDuration:5.0 animations:^{
        NSInteger page = self.pageControl.currentPage + 1;
    if (page == self.pageControl.numberOfPages) {
        page = 0;
    }
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = page * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
        
    }];
    
}

@end
