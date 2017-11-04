//
//  UIImageView+CornerRadius.m
//  MyPractise
//
//  Created by lzy on 16/3/1.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UIImageView+CornerRadius.h"
#import <objc/runtime.h>
#import "UIImage+Tint.h"

@interface UIImageView ()

@property (nonatomic, strong) CAShapeLayer * wkMaskLayer;
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
        [self wkLayerInit];
        self.wkBorderLayer.fillColor = HexColor(@"d9d9d9").CGColor;
    }
    else if (self.zy_isVipHeaderIV)
    {
        [self wkLayerInit];
        self.wkBorderLayer.fillColor = HexColor(@"ffc323").CGColor;
        //添加
        
    }
    else
    {
        if (self.wkMaskLayer) {
            self.layer.mask = nil;
        }
        if (self.wkBorderLayer) {
            [self.wkBorderLayer removeFromSuperlayer];
        }
    }
}

+ (void)load
{
    [self swizzleLayoutSubviews];
}


- (void)wkLayerInit
{
    
    if (!self.wkMaskLayer) {
        self.wkMaskLayer = [CAShapeLayer layer];
        
        self.wkMaskLayer.backgroundColor = [UIColor whiteColor].CGColor;
        self.wkMaskLayer.name = @"wkMaskLayer";
        self.layer.mask = self.wkMaskLayer;
    }
    
    if (!self.wkBorderLayer) {
        self.wkBorderLayer = [CAShapeLayer layer];
        self.wkBorderLayer.fillRule = kCAFillRuleEvenOdd;
        [self.layer addSublayer:self.wkBorderLayer];
    }
    

    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.width/2.0];
    self.wkMaskLayer.path = maskPath.CGPath;

    

    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.width/2.0];
    CGRect aaa = CGRectMake(self.zyBorderWidth, self.zyBorderWidth, self.width - self.zyBorderWidth * 2, self.height - self.zyBorderWidth * 2);
    UIBezierPath * pathTwo = [UIBezierPath bezierPathWithRoundedRect:aaa cornerRadius:self.width/2.0 - self.zyBorderWidth];
    [path appendPath:pathTwo];
    self.wkBorderLayer.path = path.CGPath;
    


    
    
}

#pragma mark property
- (CGFloat)zyBorderWidth {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return number ? [number unsignedIntegerValue] : 0.5;
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
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return number ? [number unsignedIntegerValue] : self.width / 2.0;
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

- (void)setZy_isVipHeaderIV:(BOOL)zy_isVipHeaderIV
{
    
    objc_setAssociatedObject(self, @selector(zy_isVipHeaderIV), @(zy_isVipHeaderIV), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)zy_isVipHeaderIV
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}




- (void)setWkMaskLayer:(CAShapeLayer *)wkMaskLayer
{
    objc_setAssociatedObject(self, @selector(wkMaskLayer), wkMaskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (CAShapeLayer *)wkMaskLayer
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
