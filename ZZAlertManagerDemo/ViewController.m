//
//  ViewController.m
//  ZZAlertManagerDemo
//
//  Created by 周晓瑞 on 2018/3/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"

#import "ZZAlertViewManager.h"

#import "ZZViewA.h"

@interface ViewController (){
    ZZViewA * _vv1;
    ZZViewA * _vv2;
    ZZViewA * _vv3;
    ZZViewA * _vv4;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}




- (IBAction)btnClick:(UIButton *)sender {
    int  tag  = sender.tag;
    if (tag == 1) {
        ZZViewA * v1 = [[ZZViewA alloc]init];
        [v1 showAview];
        _vv1 = v1;
    } if (tag == 2) {
        ZZViewA * v1 = [[ZZViewA alloc]init];
        v1.showAlertPriority = 120;
        [v1 showAview];
        _vv2 = v1;
    } if (tag == 3) {
        ZZViewA * v1 = [[ZZViewA alloc]init];
        v1.showLitmitType = ZZShowAlertViewTypeRemoveAllThenShow; 
        [v1 showAview];
        _vv3 = v1;
    } if (tag == 4) {
        ZZViewA * v1 = [[ZZViewA alloc]init];
        v1.showLitmitType = ZZShowAlertViewTypeSerialShowCache;
        [v1 showAview];
        _vv4 = v1;
    }if (tag == 5) {
        ZZViewA * v1 = [[ZZViewA alloc]init];
        v1.showAlertPriority = -10;
        [v1 showAview];
        _vv4 = v1;
    }if (tag == 6) {
        ZZViewA * v1 = [[ZZViewA alloc]init];
        v1.showLitmitType = ZZShowAlertViewTypeIgnoreWhenWindowAlreadyExists;
        [v1 showAview];
        _vv4 = v1;
    }
}


- (IBAction)clearSview:(id)sender {
    
    [[ZZAlertViewManager alertViewManager]zz_removeAlertView:_vv1 complete:^(id obj) {
        NSLog(@"删除了没有 -- %@",obj);
    }];
    
}



- (IBAction)clearAllWc:(id)sender {
    [[ZZAlertViewManager alertViewManager]zz_removeAndClearAlertView];
}


- (IBAction)findSpecView:(id)sender {
    NSArray * resultArray = [[ZZAlertViewManager alertViewManager]isExistsSpecialClassAlertView:NSStringFromClass([ZZViewA class])];
    
    //NSArray * resultArray = [[ZZAlertViewManager alertViewManager]isExistsSpecialPriorityAlertView:10];
    for (ZZBaseAlertView * alert  in resultArray) {
        UIWindow * window = alert.window;
        NSLog(@"查找 结果 --- %@ -- %@ - %d",alert,window,alert.showAlertPriority);
    }
    
}


@end
