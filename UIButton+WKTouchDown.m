//
//  UIButton+WKTouchDown.m
//  KanManHua
//
//  Created by wangkun on 2017/10/2.
//  Copyright © 2017年 KanManHua. All rights reserved.
//

#import "UIButton+WKTouchDown.h"
#import <objc/runtime.h>



@interface UIButton ()

@property (nonatomic, strong) UIColor * tmpTitleColor;//存储临时的标题颜色
@property (nonatomic, strong) UIColor * tmpBGColor;//存储临时的背景色
@property (nonatomic, assign) UIControlState  tmpState;//存储临时状态

@end

@implementation UIButton (WKTouchDown)

- (void)setTouchDownBGColor:(UIColor *)touchDownBGColor
{
    
    objc_setAssociatedObject(self, @"touchDownBGColor",touchDownBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)touchDownBGColor
{
    UIColor * color = objc_getAssociatedObject(self, @"touchDownBGColor");
    return color ?: RGBCOLOR(224, 117, 102);
}

- (void)setTmpBGColor:(UIColor *)tmpBGColor
{
    
    objc_setAssociatedObject(self, @"tmpBGColor",tmpBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)tmpBGColor
{
    UIColor * color = objc_getAssociatedObject(self, @"tmpBGColor");
    return color ;
}

- (void)setTouchDownTitleColor:(UIColor *)touchDownTitleColor
{
    objc_setAssociatedObject(self, @"touchDownTitleColor",touchDownTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)touchDownTitleColor
{
    UIColor * color = objc_getAssociatedObject(self, @"touchDownTitleColor");
    return color ?: [UIColor whiteColor];
}

- (void)setTmpTitleColor:(UIColor *)tmpTitleColor
{
    objc_setAssociatedObject(self, @"tmpTitleColor",tmpTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)tmpTitleColor
{
    UIColor * color = objc_getAssociatedObject(self, @"tmpTitleColor");
    return color;
}

- (void)setTmpState:(UIControlState)tmpState
{
    objc_setAssociatedObject(self, @"tmpState", @(tmpState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIControlState)tmpState
{
    return [objc_getAssociatedObject(self, @"tmpState") unsignedIntegerValue];
}

- (void)setIsVaildDownModel:(BOOL)isVaildDownModel
{
    objc_setAssociatedObject(self, @"isVaildDownModel", @(isVaildDownModel), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (isVaildDownModel) {
        [self addTarget:self action:@selector(btnOutSide:) forControlEvents:(UIControlEventTouchUpOutside)];
        [self addTarget:self action:@selector(btnDown:) forControlEvents:(UIControlEventTouchDown)];
        [self addTarget:self action:@selector(btnInSide:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    else
    {
        [self removeTarget:self action:@selector(btnOutSide:) forControlEvents:(UIControlEventTouchUpOutside)];
        [self removeTarget:self action:@selector(btnDown:) forControlEvents:(UIControlEventTouchDown)];
        [self removeTarget:self action:@selector(btnInSide:) forControlEvents:(UIControlEventTouchUpInside)];

    }
}

- (BOOL)isVaildDownModel
{
    return [objc_getAssociatedObject(self, @"isVaildDownModel") boolValue];
}

- (void)btnOutSide:(UIButton *)btn
{
    [btn setTitleColor:self.tmpTitleColor forState:self.tmpState];
    btn.backgroundColor = self.tmpBGColor;
}

- (void)btnDown:(UIButton *)btn
{
    self.tmpBGColor = self.backgroundColor;
    self.tmpState = self.state;
    self.tmpTitleColor = [self titleColorForState:self.state];
    
    [btn setTitleColor:self.touchDownTitleColor forState:self.state];
    btn.backgroundColor = self.touchDownBGColor;
}

- (void)btnInSide:(UIButton *)btn
{
    [self btnOutSide:btn];
}

@end
