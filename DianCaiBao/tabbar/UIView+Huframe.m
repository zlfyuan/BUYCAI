//
//  UIView+Huframe.m
//  自定义taberbar
//
//  Created by 汤文洪 on 16/6/6.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "UIView+Huframe.h"

@implementation UIView (Huframe)
-(void)setSize:(CGSize)size
{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
}
-(CGSize)size
{
    return self.frame.size;
}
-(void)setWidth:(CGFloat)width
{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
    
}
-(void)setHeight:(CGFloat)height
{
    CGRect frame=self.frame;
    frame.size.width=height;
    self.frame=frame;
    
}
-(void)setX:(CGFloat)x
{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
    
}
-(void)setY:(CGFloat)y
{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
-(CGFloat)x
{
    return self.frame.origin.x;
}
-(CGFloat)y
{
    return  self.frame.origin.y; 
}
@end
