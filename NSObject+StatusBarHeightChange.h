//
//  NSObject+StatusBarHeightChange.h
//  MKWeekly
//
//  Created by wangkun on 2017/7/20.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import <Foundation/Foundation.h>

//返回值_参数_类型
typedef void(^void_float_closure)(CGFloat);

@interface NSObject (StatusBarHeightChange)

@property (nonatomic, copy) void_float_closure sbhcBlock;


- (void)registerStatusBarFrameChange;
- (void)unregisterStatusBarFrameChange;

@end
