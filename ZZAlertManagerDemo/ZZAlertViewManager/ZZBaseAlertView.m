//
//  TTBaseAlertView.m
//  TMUserEnterBarrageDemo
//
//  Created by 周晓瑞 on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZZBaseAlertView.h"
#import "ZZAlertViewManager.h"

static CGFloat const kAlertBackgroundViewAlpha = 0.65;

@interface ZZBaseAlertView()
@property(nonatomic,weak)UIView *showContentView;
@end


@implementation ZZBaseAlertView
- (instancetype)init{
    if (self = [super init]) {
        [self zz_init_data];
        [self zz_initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self zz_init_data];
        [self zz_initUI];
    }
    return self;
}

- (void)zz_initUI{
    [self showContentView];
}

- (void)zz_init_data{
    self.showLitmitType = ZZShowAlertViewTypeNone;
    self.showAlertPriority = 0;
    self.ownerAlertManager = [ZZAlertViewManager alertViewManager];
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:kAlertBackgroundViewAlpha];
    self.showContentView.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - override

- (void)zz_base_show{
    [self.ownerAlertManager zz_show:self];
}
- (void)zz_base_dismiss{
    [self.ownerAlertManager zz_dismiss:self];
}


#pragma mark - getter

- (UIView *)showContentView{
    if (_showContentView == nil) {
        UIView * showCotView = [[UIView alloc]init];
        [self addSubview:showCotView];
        _showContentView = showCotView;
    }
    return _showContentView;
}

@end
