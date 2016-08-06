//
//  ZLFDetaiViewCell.m
//  DianCaiBao
//
//  Created by zluof on 16/8/3.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "ZLFDetaiViewCell.h"
#import "ZLFDetaiVegeTableMode.h"
#import "ZLFDetaiCateMode.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJExtension/MJExtension.h>
@interface ZLFDetaiViewCell ()
/**分类数据*/
@property (nonatomic, strong)NSMutableArray *fenLeiData;
@end
@implementation ZLFDetaiViewCell{
    
    UIButton *_but2;
    UIButton *_but5;
    UIButton *_but20;
    NSInteger _vegeCount;
    CGFloat _allPrice;
    BOOL _isfenlei;
    NSInteger _fenleiIndex;

}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _vegeCount = 0;
        _isfenlei = NO;
        _allPrice = 0;
        [self setUI];
    }
    return self;
}
-(void)setUI{
    
    CGFloat marginY = 15;
    CGFloat marginX = 5;
    
    UIView *borderView = [[UIView alloc]initWithFrame:(CGRect){marginX, marginY ,2*self.height/1.5, 2*self.height/1.5}];
    borderView.layer.borderColor = [UIColor grayColor].CGColor;
    borderView.layer.borderWidth = 1.0;
    borderView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:borderView];
    self.vegetableImage = [[UIImageView alloc]initWithFrame:(CGRect){5,5,borderView.width - 10,borderView.width -10}];
     self.vegetableImage.backgroundColor = [UIColor clearColor];
    [borderView addSubview:self.vegetableImage];
    
    UIView *viewLine = [[UIView alloc]initWithFrame:(CGRect){0,borderView.height + borderView.y + marginY ,self.width,1}];
    viewLine.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:viewLine];
    
    self.vegetableName = [[UILabel alloc]initWithFrame:(CGRect){borderView.width + borderView.x +10, borderView.y, self.width - borderView.width - borderView.x, 15}];
//    self.vegetableName.textAlignment = NSTextAlignmentCenter;
    self.vegetableName.font = [UIFont systemFontOfSize:15];
    self.vegetableName.text = @"大西芹2斤/袋";
    self.vegetableName.textColor = [UIColor lightGrayColor];
    self.vegetableName.numberOfLines = 0;
    self.vegetableName.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.vegetableName];
    
    self.vegetablePrice = [[UILabel alloc]initWithFrame:(CGRect){self.vegetableName.x,self.vegetableName.y + self.vegetableName.height +5, self.width - borderView.width - borderView.x, 15}];
//    self.vegetablePrice.textAlignment = NSTextAlignmentCenter;
    self.vegetablePrice.font = [UIFont systemFontOfSize:15];
    self.vegetablePrice.text = @"¥ 20.0";
    self.vegetablePrice.textColor = [UIColor lightGrayColor];
    self.vegetablePrice.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.vegetablePrice];
    
    _but2 = [[UIButton alloc]initWithFrame:(CGRect){self.vegetableName.x , self.vegetablePrice.y + self.vegetablePrice.height + 5, 25,20}];
    _but2.layer.cornerRadius = 5.0;
    _but2.layer.masksToBounds = YES;
    _but2.titleLabel.font = [UIFont systemFontOfSize:12];
    _but2.backgroundColor = [UIColor orangeColor];
    [_but2 setTitle:@"2斤" forState:UIControlStateNormal];
    [_but2 addTarget:self action:@selector(but2_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_but2];
    
    
    _but5 = [[UIButton alloc]initWithFrame:(CGRect){_but2.width + _but2.x +10, _but2.y, 25,20}];
     _but5.backgroundColor = [UIColor lightGrayColor];
    _but5.layer.cornerRadius = 5.0;
    _but5.layer.masksToBounds = YES;
    _but5.titleLabel.font = [UIFont systemFontOfSize:12];
    [_but5 setTitle:@"5斤" forState:UIControlStateNormal];
    [_but5 addTarget:self action:@selector(but5_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_but5];
    
    _but20 = [[UIButton alloc]initWithFrame:(CGRect){_but5.width + _but5.x + 10,_but5.y, 30,20}];
    _but20.backgroundColor = [UIColor lightGrayColor];
    _but20.layer.cornerRadius = 5.0;
    _but20.layer.masksToBounds = YES;
    _but20.titleLabel.font = [UIFont systemFontOfSize:12];
    [_but20 setTitle:@"20斤" forState:UIControlStateNormal];
    [_but20.titleLabel sizeToFit];
    [_but20 addTarget:self action:@selector(but20_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_but20];
    
    
    self.subtractCount = [[UIButton alloc]initWithFrame:(CGRect){_but20.width + _but20.x + _but5.width , _but20.y - 5,25,25}];
    [self.subtractCount setBackgroundImage:[UIImage imageNamed:@"-+"] forState:UIControlStateNormal];
    self.subtractCount.hidden = YES;
    [self.subtractCount addTarget:self action:@selector(substractButCount) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.subtractCount];
    
    self.vegetableCount = [[UILabel alloc]initWithFrame:(CGRect){self.subtractCount.x + self.subtractCount.width,self.subtractCount.y,15,self.subtractCount.height}];
    self.vegetableCount.textAlignment = NSTextAlignmentCenter;
    self.vegetableCount.text = [NSString stringWithFormat:@"%ld",(long)_vegeCount];
    self.vegetableCount.hidden = YES;
    [self.contentView addSubview:self.vegetableCount];
    
    self.addCount = [[UIButton alloc]initWithFrame:(CGRect){self.vegetableCount.width + self.vegetableCount.x, _but20.y - 5,25,25}];
    [self.addCount setBackgroundImage:[UIImage imageNamed:@"＋-0"] forState:UIControlStateNormal];
    [self.addCount addTarget:self action:@selector(addButCount) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addCount];
    
    
}


/**
 *添加数据
 */
-(void)setVegeTableMode:(ZLFDetaiVegeTableMode *)vegeTableMode{
    _vegeTableMode = vegeTableMode;
    NSString *imgurl = [NSString stringWithFormat:@"http://dcj.0791jr.com/data/attachment/item/%@",_vegeTableMode.img];
    [self.vegetableImage sd_setImageWithURL:[NSURL URLWithString:imgurl]];
    
    
//    HULog(@"%lu",(unsigned long)_vegeTableMode.fenlei.count);
    
    
    if (_vegeTableMode.fenlei.count == 0) {
        _but2.hidden = YES;
        _but20.hidden = YES;
        _but5.hidden =YES;
    }
    if (_vegeTableMode.fenlei.count == 1) {
        
        _but20.hidden = YES;
        _but5.hidden =YES;
        
    }
    if (_vegeTableMode.fenlei.count == 2) {
        
        _but20.hidden = YES;
        
    }
    if (_vegeTableMode.fenlei.count == 3) {
        
    }
    
    
    
    self.vegetableName.text = _vegeTableMode.title;
    self.vegetablePrice.text = [NSString stringWithFormat:@"¥ %@",_vegeTableMode.price];
    
    self.fenLeiData = [ZLFDetaiCateMode mj_objectArrayWithKeyValuesArray:_vegeTableMode.fenlei];
}
#pragma mark--选择数量
-(void)addButCount{
    self.subtractCount.hidden = NO;
    self.vegetableCount.hidden = NO;
    self.vegetableCount.text = [NSString stringWithFormat:@"%ld",++_vegeCount];
    if ([self.vegetableCount.text isEqualToString:@"10"]||[self.vegetableCount.text isEqualToString:@"100"]) {
        CGRect frame = (CGRect){self.subtractCount.frame.origin.x - 10 , _but20.y - 5,25,25};
        self.subtractCount.frame = frame;
        CGRect frameV = (CGRect){self.subtractCount.x + self.subtractCount.width,self.subtractCount.y,15+10,self.subtractCount.height};
        self.vegetableCount.frame = frameV;
        
    }
    CGFloat allPrice = 0;
    CGFloat allp = 0;
    if (_isfenlei == NO) {
        
        CGFloat price =[self.vegeTableMode.price floatValue];
        CGFloat number = _vegeCount;
        allPrice =( price * number);
        HULog(@"%.2f",allPrice);
    }else{
        ZLFDetaiCateMode *modeCate = self.fenLeiData[_fenleiIndex];
        CGFloat price = [modeCate.price floatValue];
        CGFloat number = _vegeCount;
        allp = price * number;
        HULog(@"%.2f",allp);
    }
   
    CGFloat all = allp + allPrice;
    _allPrice = all;
    HULog(@"%.2f",all);
    [NotificationCenter postNotificationName:@"NotificationCenterShipingInfo" object:self userInfo:@{@"ALLPRICE":[NSString stringWithFormat:@"%.2f",all],@"COUNT":@(_vegeCount)}];
}
-(void)substractButCount{
    self.vegetableCount.text = [NSString stringWithFormat:@"%ld",--_vegeCount];
    if (_vegeCount == 0) {
        CGRect frame = (CGRect){_but20.width + _but20.x + _but5.width , _but20.y - 5,25,25};
        self.subtractCount.frame = frame;
        CGRect frameV = (CGRect){self.subtractCount.x + self.subtractCount.width,self.subtractCount.y,15,self.subtractCount.height};
        self.vegetableCount.frame = frameV;
        self.vegetableCount.hidden = YES;
        self.subtractCount.hidden = YES;
    }
}
#pragma mark--选择重量
-(void)but2_Clicked:(UIButton *)but2{
    _isfenlei = NO;
    _fenleiIndex = 0;
    _vegeCount = 0;
    
    self.vegetableCount.text = [NSString stringWithFormat:@"%ld",_vegeCount];
    self.vegetableCount.hidden = YES;
    self.subtractCount.hidden = YES;
    but2.backgroundColor = [UIColor orangeColor];
    _but5.backgroundColor = [UIColor lightGrayColor];
    _but20.backgroundColor = _but5.backgroundColor;
    ZLFDetaiCateMode *modeCate = self.fenLeiData[0];
    self.vegetableName.text = modeCate.title;
    self.vegetablePrice.text = [NSString stringWithFormat:@"¥ %@",modeCate.price];
}
-(void)but5_Clicked:(UIButton *)but5{
    _isfenlei = YES;
    _fenleiIndex = 1;
    _vegeCount = 0;
     self.vegetableCount.text = [NSString stringWithFormat:@"%ld",_vegeCount];
    self.vegetableCount.hidden = YES;
    self.subtractCount.hidden = YES;

    but5.backgroundColor = [UIColor orangeColor];
    _but20.backgroundColor = [UIColor lightGrayColor];
    _but2.backgroundColor = _but20.backgroundColor;
    
    ZLFDetaiCateMode *modeCate = self.fenLeiData[1];
    self.vegetableName.text = modeCate.title;
    self.vegetablePrice.text = [NSString stringWithFormat:@"¥ %@",modeCate.price];
    
}
-(void)but20_Clicked:(UIButton *)but20{
    _isfenlei = YES;
     _fenleiIndex = 2;
    _vegeCount = 0;
    self.vegetableCount.hidden = YES;
    self.subtractCount.hidden = YES;

     self.vegetableCount.text = [NSString stringWithFormat:@"%ld",_vegeCount];
    but20.backgroundColor = [UIColor orangeColor];
    _but5.backgroundColor = [UIColor lightGrayColor];
    _but2.backgroundColor = _but5.backgroundColor;
    
    ZLFDetaiCateMode *modeCate = self.fenLeiData[2];
    self.vegetableName.text = modeCate.title;
    self.vegetablePrice.text = [NSString stringWithFormat:@"¥ %@",modeCate.price];
}





-(NSMutableArray *)fenLeiData{
    if (_fenLeiData == nil) {
        _fenLeiData = [NSMutableArray new];
    }
    return _fenLeiData;
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
