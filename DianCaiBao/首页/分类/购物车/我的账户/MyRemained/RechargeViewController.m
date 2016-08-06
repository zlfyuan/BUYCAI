//
//  RechargeViewController.m
//  DianCaiBao
//
//  Created by 汤文洪 on 16/8/5.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "RechargeViewController.h"
#import "TWHLabel.h"
#import "TWHTextFiled.h"
#import "TWHButton.h"
#import "ShowMessage.h"

@interface RechargeViewController ()
{
    UILabel *YENumLab;
//    UIButton *zfbBtn;
//    UIButton *wxbBtn;
    TWHTextFiled *inputTf;
}
/** 支付宝 */
@property(nonatomic,strong)UIButton *zfbBtn;
/** 微信支付 */
@property(nonatomic,strong)UIButton *wxBtn;

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

-(void)setUI
{
   UILabel *YELab = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 25)];
    YELab.textColor = [UIColor blackColor];
    YELab.font = [UIFont systemFontOfSize:17];
    YELab.text = @"我的余额 : ";
    [self.view addSubview:YELab];
    
    YENumLab = [[UILabel alloc]initWithFrame:CGRectMake(YELab.frame.origin.x+YELab.frame.size.width, 23, 55, 25)];
    YENumLab.textColor = [UIColor orangeColor];
    YENumLab.font = [UIFont systemFontOfSize:14];
    YENumLab.text = @"0.00 元";
    [self.view addSubview:YENumLab];
    
    inputTf = [[TWHTextFiled alloc]initWithFrame:CGRectMake(10, YELab.frame.origin.y+YELab.frame.size.height+10, self.view.frame.size.width-30, 30) placehold:@"请输入金额"];
    [self.view addSubview:inputTf];
    
    UILabel *fsLab = [[UILabel alloc]initWithFrame:CGRectMake(10, inputTf.frame.origin.y+inputTf.frame.size.height+10, 120, 25)];
    fsLab.text = @"充值方式 : ";
    fsLab.font = [UIFont systemFontOfSize:18];
    fsLab.textColor = [UIColor blackColor];
    [self.view addSubview:fsLab];
    
//    UIView *ZFView = [[UIView alloc]initWithFrame:CGRectMake(0, fsLab.frame.origin.y+fsLab.frame.size.height+10, self.view.frame.size.width, 70)];
//    ZFView.userInteractionEnabled = YES;
//    [self.view addSubview:ZFView];
    
    NSArray *imgArr = @[@"zhifubao",@"weixin"];
    NSArray *textArr = @[@"支付宝",@"微信支付"];
    for (int i = 0; i<2; i++) {
        UIImageView *fsImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10,fsLab.frame.origin.y+fsLab.frame.size.height+10+i*25+(i+1)*5, 25, 25)];
        fsImgView.image = [UIImage imageNamed:imgArr[i]];
        [self.view addSubview:fsImgView];
        UILabel *fsLabel = [[UILabel alloc]initWithFrame:CGRectMake(fsImgView.frame.origin.x+fsImgView.frame.size.width+10,fsLab.frame.origin.y+fsLab.frame.size.height+10+i*25+(i+1)*5, 80, 25)];
        fsLabel.textColor = [UIColor lightGrayColor];
        fsLabel.font = [UIFont systemFontOfSize:14];
        fsLabel.text = textArr[i];
        [self.view addSubview:fsLabel];
    }
    
    _zfbBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, fsLab.frame.origin.y+fsLab.frame.size.height+10+10, 15, 15)];
    [_zfbBtn setBackgroundImage:[UIImage imageNamed:@"radio_nomer"] forState:UIControlStateNormal];
    [_zfbBtn setBackgroundImage:[UIImage imageNamed:@"radio_selecte"] forState:UIControlStateSelected];
    _zfbBtn.selected = YES;
    [_zfbBtn addTarget:self action:@selector(zfbBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zfbBtn];
    
    _wxBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, fsLab.frame.origin.y+fsLab.frame.size.height+10+35, 15, 15)];
    [_wxBtn setBackgroundImage:[UIImage imageNamed:@"radio_nomer"] forState:UIControlStateNormal];
    [_wxBtn setBackgroundImage:[UIImage imageNamed:@"radio_selecte"] forState:UIControlStateSelected];
    [_wxBtn addTarget:self action:@selector(wxBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wxBtn];
    
    TWHButton *payButton = [[TWHButton alloc]initWithFrame:CGRectMake(10, fsLab.frame.origin.y+fsLab.frame.size.height+10+70+20, self.view.frame.size.width-20, 30) cornerRadius:3.0 font:[UIFont systemFontOfSize:15] titleColor:[UIColor whiteColor] backGroundColor:[UIColor orangeColor] title:@"立即充值"];
    [payButton addTarget:self action:@selector(payBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
}

-(void)zfbBtnClicked:(UIButton *)sender
{
    [_wxBtn setBackgroundImage:[UIImage imageNamed:@"radio_nomer"] forState:UIControlStateNormal];
//    _wxBtn.selected = NO;
    
    UIButton *btn = sender;
    if (btn.selected){
        
        [btn setImage:[UIImage imageNamed:@"radio_selecte"] forState:UIControlStateSelected];
    }else{
        [btn setImage:[UIImage imageNamed:@"radio_selecte"] forState:UIControlStateNormal];
    }
    btn.selected = !btn.selected;
}

-(void)wxBtnClicked:(UIButton *)sender
{
    [_zfbBtn setBackgroundImage:[UIImage imageNamed:@"radio_nomer"] forState:UIControlStateNormal];
    _zfbBtn.selected = NO;
        
    UIButton *btn = sender;
    if (btn.selected){
       
        [btn setImage:[UIImage imageNamed:@"radio_selecte"] forState:UIControlStateSelected];
    }else{
        [btn setImage:[UIImage imageNamed:@"radio_selecte"] forState:UIControlStateNormal];
    }
    btn.selected = !btn.selected;
}

-(void)payBtnClicked{
    if (inputTf.text.length<1) {
        [ShowMessage showMessage:@"请输入充值金额" duration:2.0];
    }
    else
    {
        if (_zfbBtn.selected==YES) {
            [ShowMessage showMessage:@"您使用了支付宝支付" duration:2.0];
        }
        else if (_wxBtn.selected==YES)
        {
            [ShowMessage showMessage:@"您使用了微信支付" duration:2.0];
        }
        [self myAlert:@"点菜宝请求使用支付宝"];
    }
}

-(void)myAlert:(NSString *)alertStr
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"" message:alertStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
     UIAlertAction *conFirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     //调用支付宝/微信
         
     }];
        
    [ac addAction:cancleAction];
    [ac addAction:conFirmAction];
    [self presentViewController:ac animated:YES completion:nil];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
