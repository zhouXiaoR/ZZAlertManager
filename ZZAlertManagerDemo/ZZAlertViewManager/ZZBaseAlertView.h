//
//  TTBaseAlertView.h
//  TMUserEnterBarrageDemo
//
//  Created by 周晓瑞 on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 
 需求以下：
 3. 来了个A弹框，要求移除所有已经展示在当前界面的所有弹框，然后展示A
 4. 来了个A弹框，要求顺序弹出，比如此时当前界面上已经存在，B,C,D了，要求缓存 ，等B，C,D都消失完之后，再弹出A
 5. 同时来了个A,B,C,D弹框，要求按一定的次序弹出，按指定的顺序依次盖在上面->设定优先级即可
 6. 来了A弹框，如果当前界面上已经有了，就忽略
 7. 。。。。。
 **/

typedef enum : NSUInteger {
    ZZShowAlertViewTypeNone = 0,
    ZZShowAlertViewTypeRemoveAllThenShow = 3,
    ZZShowAlertViewTypeSerialShowCache = 4,
    ZZShowAlertViewTypeIgnoreWhenWindowAlreadyExists = 6,
    ZZShowAlertViewTypeOther = 100,
} ZZShowAlertViewType;

@class ZZAlertViewManager;
@interface ZZBaseAlertView : UIView

/**
 视图展示的弹框需求类型
 */
@property(nonatomic,assign)ZZShowAlertViewType showLitmitType;

/**
 视图的管理者，当前是单例即所有的ZZBaseAlertView的管理者都是同一个manager，若不用单例则会不同。
 */
@property(nonatomic,strong)ZZAlertViewManager *ownerAlertManager;

/**
 优先级设置，优先级越高越会被展示在最上层，若优先级相同，则先来后到
 */
@property(nonatomic,assign)NSInteger showAlertPriority;

/**
 内容视图
 */
@property(nonatomic,weak,readonly)UIView *showContentView;

/*子类可重写*/
- (void)zz_base_show;
- (void)zz_base_dismiss;

@end
