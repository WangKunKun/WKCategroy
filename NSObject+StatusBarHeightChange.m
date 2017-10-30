//
//  NSObject+StatusBarHeightChange.m
//  MKWeekly
//
//  Created by wangkun on 2017/7/20.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import "NSObject+StatusBarHeightChange.h"
#import <objc/runtime.h>

@implementation NSObject (StatusBarHeightChange)

- (void)setSbhcBlock:(void_float_closure)block
{
    objc_setAssociatedObject(self, @"s_b_h_c_void_float_closure", block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void_float_closure)sbhcBlock
{
    return objc_getAssociatedObject(self, @"s_b_h_c_void_float_closure");
}

- (void)registerStatusBarFrameChange
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarFrameWillChange:)name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    
}
- (void)unregisterStatusBarFrameChange
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
}

- (void)statusBarFrameWillChange:(NSNotification*)notification
{
    // respond to changes
    NSDictionary *statusBarDetail = [notification userInfo];
    NSValue *animationCurve = statusBarDetail[UIApplicationStatusBarFrameUserInfoKey];
    CGRect statusBarFrameBeginRect = [animationCurve CGRectValue];
    int statusBarHeight = statusBarFrameBeginRect.size.height;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.sbhcBlock)
        {
            self.sbhcBlock(statusBarHeight);
        }
    });

}


@end
