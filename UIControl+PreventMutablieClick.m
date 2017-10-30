//
//  UIControl+PreventMutablieClick.m
//  MKWeekly
//
//  Created by wangkun on 2017/8/8.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import "UIControl+PreventMutablieClick.h"

@implementation UIControl (PreventMutablieClick)

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";
static const char *UIcontrol_ignoreEvent = "UIcontrol_ignoreEvent";

- (NSTimeInterval)wk_acceptEventTime
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setWk_acceptEventTime:(NSTimeInterval)wk_acceptEventTime
{
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(wk_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)wk_acceptEventInterval {
    
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setWk_acceptEventInterval:(NSTimeInterval)wk_acceptEventInterval {
    
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(wk_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (BOOL)wk_ignoreEvent {
    
    return [objc_getAssociatedObject(self, UIcontrol_ignoreEvent) boolValue];
    
}

- (void)setWk_ignoreEvent:(BOOL)wk_ignoreEvent {
    
    objc_setAssociatedObject(self, UIcontrol_ignoreEvent, @(wk_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

+ (void)load {
    
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    
    Method b = class_getInstanceMethod(self, @selector(__wk_sendAction:to:forEvent:));
    
    method_exchangeImplementations(a, b);
    
}

- (void)__wk_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (!self.wk_ignoreEvent){
        [self __wk_sendAction:action to:target forEvent:event];
        return;
    }
    
    if ([NSDate date].timeIntervalSince1970 - self.wk_acceptEventInterval < self.wk_acceptEventTime) {
        return;
    }
    
    if (self.wk_acceptEventTime >= 0) {
        self.wk_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    [self __wk_sendAction:action to:target forEvent:event];

    
}


@end
