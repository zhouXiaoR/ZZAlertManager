//
//  TMAlertViewManager.h
//  TMUserEnterBarrageDemo
//
//  Created by 周晓瑞 on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZZAlertViewManagerRemoveFinishedBlock)(id obj);

@class ZZBaseAlertView;

@interface ZZAlertViewManager : NSObject

+ (instancetype)alertViewManager;

@property(nonatomic,strong,readonly)NSMutableArray <ZZBaseAlertView*>*alertViewsArray;

/**
 当前屏幕上是否存在ZZBaseAlertView类型弹框
 */
@property(nonatomic,assign,readonly)BOOL isExistsAlertViewKeyWindow;

/**
 展示与消失，最好让ZZBaseAlertView或者子类调用
 */
- (void)zz_show:(ZZBaseAlertView *)alertView;
- (void)zz_dismiss:(ZZBaseAlertView *)alertView;

/**
 当前window上是否存在指定特定类型的view

 @param alertClass 类型
 @return 若存在会返回
 */
- (NSArray <ZZBaseAlertView *>*)isExistsSpecialClassAlertView:(NSString *)alertClass;

/**
 当前window上是否存在指定优先级别的view
 
 @param alertPriority 类型
 @return 若存在会返回数组
 */
- (NSArray <ZZBaseAlertView *>*)isExistsSpecialPriorityAlertView:(NSInteger)alertPriority;

/**
 移除指定的alert
 @param alertView 指定的alert
 */
- (void)zz_removeAlertView:(ZZBaseAlertView *)alertView;
- (void)zz_removeAlertView:(ZZBaseAlertView *)alertView complete:(ZZAlertViewManagerRemoveFinishedBlock)block;

/*
 移除屏幕上所有类型的ZZBaseAlertView，并清理缓存 
 */
- (void)zz_removeAndClearAlertView;
@end
