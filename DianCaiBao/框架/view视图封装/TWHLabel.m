//
//  TWHLabel.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "TWHLabel.h"

@implementation TWHLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/*
 UILabel *agreeProtolLab = [[UILabel alloc]initWithFrame:CGRectMake(userTypeTf.frame.origin.x+50, userTypeTf.frame.origin.y+userTypeTf.frame.size.height+30, 200, 18)];
 agreeProtolLab.text = @"同意配菜宝  《用户服务协议》";
 agreeProtolLab.font = [UIFont systemFontOfSize:14];
 NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:agreeProtolLab.text];
 NSRange noteRnage = NSMakeRange([[noteStr string]rangeOfString:@"《用户服务协议》"].location, [[noteStr string]rangeOfString:@"《用户服务协议》"].length);
 [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] range:noteRnage];
 [agreeProtolLab setAttributedText:noteStr];
 [bottomScroll addSubview:agreeProtolLab];
 */

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)text font:(UIFont *)font rangeString:(NSString *)rangeStr
{
    if([super initWithFrame:frame])
    {
        self.text = text;
        self.font = font;
        self.textColor = [UIColor lightGrayColor];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:self.text];
        NSRange noteRnage = NSMakeRange([[noteStr string]rangeOfString:rangeStr].location, [[noteStr string]rangeOfString:rangeStr].length);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:227/255.f green:125.0/255.f blue:36.0/255.f alpha:1.0] range:noteRnage];
        [self setAttributedText:noteStr];
    }
    return self;
}

@end
