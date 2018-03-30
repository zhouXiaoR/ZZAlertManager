//
//  ZZViewA.m
//  TMUserEnterBarrageDemo
//
//  Created by 周晓瑞 on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZZViewA.h"

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBAColor(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface ZZViewA()
@property(nonatomic,weak)UILabel *tipsLab;
@end

@implementation ZZViewA

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    UILabel * tipsLab = [[UILabel alloc]init];
    tipsLab.text = @"点我消失";
    tipsLab.textColor = [UIColor lightGrayColor];
    tipsLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tipsLab];
    self.tipsLab = tipsLab;
    self.alpha = 0.0f;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = RandColor;
    
    int orx = arc4random_uniform(200);
    int ory = arc4random_uniform(10) + 30;
    
    self.frame = CGRectMake(orx, ory, 200, 100);   
    self.tipsLab.frame = self.bounds;
}

- (void)showAview{
    [super zz_base_show];
    
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismissAview{
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [super zz_base_dismiss];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissAview];
}

@end
