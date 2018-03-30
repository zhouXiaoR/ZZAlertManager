//
//  TMAlertViewManager.m
//  TMUserEnterBarrageDemo
//
//  Created by 周晓瑞 on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZZAlertViewManager.h"
#import "ZZBaseAlertView.h"

@interface ZZAlertViewManager()
@property(nonatomic,strong)NSMutableArray <ZZBaseAlertView*>*alertViewsArray;
@property(nonatomic,strong)NSMutableArray <ZZBaseAlertView *>*alertViewsCachesArray;
@end


static ZZAlertViewManager * __alertManager =nil;
@implementation ZZAlertViewManager

+ (instancetype)alertViewManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __alertManager = [[self alloc]init];
    });
    return __alertManager;
}

- (void)zz_show:(ZZBaseAlertView *)alertView{
    if (!alertView) return;
    
    if (alertView.showLitmitType == ZZShowAlertViewTypeRemoveAllThenShow) {
        for (ZZBaseAlertView * tempAlert in self.alertViewsArray) {
            [tempAlert removeFromSuperview];
        }
        [self.alertViewsArray removeAllObjects];
        [self.alertViewsArray addObject:alertView];
        [self zz_sortAddWindow];
    }else if (alertView.showLitmitType == ZZShowAlertViewTypeSerialShowCache){
        if (self.alertViewsArray.count <= 0) {
            [self.alertViewsArray addObject:alertView];
            [self zz_keyWindow:alertView];
        }else{
             [self.alertViewsCachesArray addObject:alertView];
        }
    }else if (alertView.showLitmitType == ZZShowAlertViewTypeIgnoreWhenWindowAlreadyExists){
        if (!self.isExistsAlertViewKeyWindow) {
            [self zz_keyWindow:alertView];
        }
    }else{
        [self.alertViewsArray addObject:alertView];
        [self sortAlertViewsPriority];
        [self zz_sortAddWindow];
    }
}

- (void)zz_dismiss:(ZZBaseAlertView *)alertView{
     if (!alertView) return;

     [self zz_removeAlertView:alertView];
}



#pragma mark - 私有

- (void)zz_keyWindow:(ZZBaseAlertView *)alertView{
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

- (void)zz_sortAddWindow{
    for (ZZBaseAlertView * alert in self.alertViewsArray) {
        [self zz_keyWindow:alert];
    }
}

- (void)sortAlertViewsPriority{
    if (self.alertViewsArray.count < 2)
        return;
    [self.alertViewsArray sortUsingComparator:^NSComparisonResult(ZZBaseAlertView *obj1, ZZBaseAlertView * obj2) {
        if (obj1.showAlertPriority <= obj2.showAlertPriority) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
}

#pragma mark - 公有

- (BOOL)isExistsAlertViewKeyWindow{
    return self.alertViewsArray.count > 0 ? YES : NO;
}

- (void)zz_removeAlertView:(ZZBaseAlertView *)alertView{
    [self zz_removeAlertView:alertView complete:nil];
}

- (void)zz_removeAlertView:(ZZBaseAlertView *)alertView complete:(ZZAlertViewManagerRemoveFinishedBlock)block{
    if (![self.alertViewsArray containsObject:alertView]){
        if (block) {
            block(nil);
        }
        return;
    }
    NSInteger currentAlertViewIndex = 
    [self.alertViewsArray indexOfObject:alertView];
    [alertView removeFromSuperview];
    [self.alertViewsArray removeObjectAtIndex:currentAlertViewIndex];
    if (block) {
        block(alertView);
    }
    
  //  1. 处理缓存 
    [self zz_cachesAlertViews];
}

- (void)zz_removeCacheAlertView:(ZZBaseAlertView *)alertView{
    if (![self.alertViewsArray containsObject:alertView])
        return;
    
    NSInteger currentCacheAlertViewIndex = 
    [self.alertViewsCachesArray indexOfObject:alertView];
    [self.alertViewsCachesArray removeObjectAtIndex:currentCacheAlertViewIndex];
}
- (void)zz_removeAndClearAlertView{
    for (ZZBaseAlertView * alert  in self.alertViewsArray) {
        [alert removeFromSuperview];
    }
    [self.alertViewsCachesArray removeAllObjects];
    [self.alertViewsArray removeAllObjects];
}

- (void)zz_cachesAlertViews{
    if (self.alertViewsArray.count > 0) return;
    if (self.alertViewsCachesArray.count <= 0) return;
    
    ZZBaseAlertView * alertView = self.alertViewsCachesArray.firstObject;
    if (alertView) {
        [self.alertViewsArray addObject:alertView];
        [self zz_keyWindow:alertView];
        [self zz_removeCacheAlertView:alertView];
    }
}
- (NSArray <ZZBaseAlertView *>*)isExistsSpecialClassAlertView:(NSString *)alertClass{
    if (!alertClass || alertClass.length == 0)
        return nil;
    
    if (self.alertViewsArray.count <= 0 && self.alertViewsCachesArray.count <= 0)
        return nil;
    
    NSMutableArray * speArray = [NSMutableArray array];
    
    for (ZZBaseAlertView *alert in self.alertViewsArray) {
        NSString * currentClass = NSStringFromClass([alert class]);
        if ([currentClass isEqualToString:alertClass]){
            [speArray addObject:alert];
        }
    }
    
    for (ZZBaseAlertView *alert in self.alertViewsCachesArray) {
        NSString * currentClass = NSStringFromClass([alert class]);
        if ([currentClass isEqualToString:alertClass]){
            [speArray addObject:alert];
        }
    }
    
    return speArray;
}

- (NSArray <ZZBaseAlertView *>*)isExistsSpecialPriorityAlertView:(NSInteger)alertPriority{
    if (alertPriority < 0) return nil;
    
    if (self.alertViewsArray.count <= 0 && self.alertViewsCachesArray.count <= 0)
        return nil;
    
    NSMutableArray * speArray = [NSMutableArray array];
    
    for (ZZBaseAlertView *alert in self.alertViewsArray) {
        if (alertPriority == alert.showAlertPriority){
            [speArray addObject:alert];
        }
    }
    
    for (ZZBaseAlertView *alert in self.alertViewsCachesArray) {
        if (alertPriority == alert.showAlertPriority){
            [speArray addObject:alert];
        }
    }
    
    return speArray;
}

#pragma mark - getter

- (NSMutableArray<ZZBaseAlertView *> *)alertViewsArray{
    if (_alertViewsArray == nil) {
        _alertViewsArray = [NSMutableArray array];
    }
    return _alertViewsArray;
}

- (NSMutableArray<ZZBaseAlertView *> *)alertViewsCachesArray{
    if (_alertViewsCachesArray == nil) {
        _alertViewsCachesArray = [NSMutableArray array];
    }
    return _alertViewsCachesArray;
}

@end
