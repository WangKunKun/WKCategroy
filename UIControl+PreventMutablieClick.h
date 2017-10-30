//
//  UIControl+PreventMutablieClick.h
//  MKWeekly
//
//  Created by wangkun on 2017/8/8.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (PreventMutablieClick)

@property (nonatomic, assign) NSTimeInterval wk_acceptEventInterval;//添加点击事件的间隔时间 无效时间
@property (nonatomic, assign) NSTimeInterval wk_acceptEventTime;//上一次点击响应的时间
@property (nonatomic, assign) BOOL wk_ignoreEvent;//是否需要忽略快速点击事件   几秒内无效

@end
