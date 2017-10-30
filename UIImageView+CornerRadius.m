//
//  UIImageView+CornerRadius.m
//  MyPractise
//
//  Created by lzy on 16/3/1.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UIImageView+CornerRadius.h"
#import <objc/runtime.h>


@interface UIImageView ()

@property (nonatomic, strong) CALayer * wkMaskLayer;
@property (nonatomic, strong) CAShapeLayer * wkBorderLayer;


@end





@implementation UIImageView (CornerRadius)




- (void)validateFrame {
    if (self.frame.size.width == 0) {
        [self.class swizzleLayoutSubviews];
    }
}

+ (void)swizzleMethod:(SEL)oneSel anotherMethod:(SEL)anotherSel {
    Method oneMethod = class_getInstanceMethod(self, oneSel);
    Method anotherMethod = class_getInstanceMethod(self, anotherSel);
    method_exchangeImplementations(oneMethod, anotherMethod);
}


+ (void)swizzleLayoutSubviews {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(layoutSubviews) anotherMethod:@selector(zy_LayoutSubviews)];
    });
}

- (void)zy_LayoutSubviews {
    [self zy_LayoutSubviews];
    if (self.zy_isHeaderIV) {

        
        if (!self.wkMaskLayer) {
            self.wkMaskLayer = [CALayer layer];
            self.wkMaskLayer.frame = self.bounds;
            self.wkMaskLayer.cornerRadius = self.width / 2.0;
            self.wkMaskLayer.backgroundColor = [UIColor whiteColor].CGColor;
            self.wkMaskLayer.name = @"wkMaskLayer";
        }

        if (!self.wkBorderLayer) {
            self.wkBorderLayer = [CAShapeLayer layer];
            UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.width/2.0];
            
            CGRect aaa = CGRectMake(0.5, 0.5, self.width - 1, self.height - 1);
            UIBezierPath * pathTwo = [UIBezierPath bezierPathWithRoundedRect:aaa cornerRadius:self.width/2.0 - 0.5];
            [path appendPath:pathTwo];
            self.wkBorderLayer.path = path.CGPath;
            self.wkBorderLayer.fillColor = HexColor(@"d9d9d9").CGColor;
            self.wkBorderLayer.fillRule = kCAFillRuleEvenOdd;

        }

        [self.layer addSublayer:self.wkBorderLayer];
        self.layer.mask = self.wkMaskLayer;

//        self.layer.cornerRadius = self.width / 2.0;
//        self.clipsToBounds = YES;
//        self.layer.borderColor = HexColor(@"d9d9d9").CGColor;
//        self.layer.borderWidth = 0.5;
    }
    else
    {
        if (self.wkMaskLayer) {
            self.layer.mask = nil;
        }
        if (self.wkBorderLayer) {
            [self.wkBorderLayer removeFromSuperlayer];
        }
//        if (self.layer.cornerRadius == self.width / 2.0)
//        {
//            self.layer.cornerRadius = 0;
//            self.layer.borderWidth = 0;
//
//        }
    }
}

+ (void)load
{
    [self swizzleLayoutSubviews];
}


#pragma mark property
- (CGFloat)zyBorderWidth {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setZyBorderWidth:(CGFloat)zyBorderWidth {
    objc_setAssociatedObject(self, @selector(zyBorderWidth), @(zyBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)zyBorderColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZyBorderColor:(UIColor *)zyBorderColor {
    objc_setAssociatedObject(self, @selector(zyBorderColor), zyBorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




- (CGFloat)zyRadius {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setZyRadius:(CGFloat)zyRadius {
    objc_setAssociatedObject(self, @selector(zyRadius), @(zyRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setZy_isHeaderIV:(BOOL)zy_isHeaderIV
{
    objc_setAssociatedObject(self, @selector(zy_isHeaderIV), @(zy_isHeaderIV), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (BOOL)zy_isHeaderIV
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}





- (void)setWkMaskLayer:(CALayer *)wkMaskLayer
{
    objc_setAssociatedObject(self, @selector(wkMaskLayer), wkMaskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (CALayer *)wkMaskLayer
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWkBorderLayer:(CAShapeLayer *)wkBorderLayer
{
    objc_setAssociatedObject(self, @selector(wkBorderLayer), wkBorderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)wkBorderLayer
{
    return objc_getAssociatedObject(self, _cmd);
}

@end








//ZYCornerRadius is available under the MIT license.
//Please visit https://github.com/liuzhiyi1992/ZYCornerRadius for details.
