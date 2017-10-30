//
//  UIButton+AddCornerRadiusLayer.m
//  KanManHua
//
//  Created by wangkun on 2017/9/28.
//  Copyright © 2017年 KanManHua. All rights reserved.
//

#import "UIButton+AddCornerRadiusLayer.h"
#import <objc/runtime.h>

static NSString * layerName = @"WKCornerRadiusLayer";
@implementation UIButton (AddCornerRadiusLayer)

- (void)setWkBGColor:(UIColor *)wkBGColor
{
    objc_setAssociatedObject(self, @"wkBGColor", wkBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)wkBGColor
{
    UIColor * color = objc_getAssociatedObject(self, @"wkBGColor");
    return color ?: [UIColor clearColor];
}

- (void)setWkBorderColor:(UIColor *)wkBorderColor
{
    objc_setAssociatedObject(self, @"wkBorderColor", wkBorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)wkBorderColor
{
    UIColor * color = objc_getAssociatedObject(self, @"wkBorderColor");
    return color ? color : [UIColor whiteColor];
}

- (void)setWkBorderWidth:(CGFloat)wkBorderWidth
{
    objc_setAssociatedObject(self, @"wkBorderWidth", @(wkBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wkBorderWidth
{
    NSNumber * number = objc_getAssociatedObject(self, @"wkBorderWidth");
    return number ? [number floatValue] : -1;
}

- (void)setWkCornerRadius:(CGFloat)wkCornerRadius
{
    objc_setAssociatedObject(self, @"wkCornerRadius", @(wkCornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wkCornerRadius
{
    NSNumber * number = objc_getAssociatedObject(self, @"wkCornerRadius");
    
    
    return number ? [number floatValue] : -1;

}


- (CGFloat)wkCornerRadiusLayerWidth
{
    return [self getCornerRadiusLayer].width;
}

- (void)setIsAddCornerRadiusLayer:(BOOL)isAddCornerRadiusLayer
{
    objc_setAssociatedObject(self, @"isAddCornerRadiusLayer", @(isAddCornerRadiusLayer), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setCornerRadiusLayer];

}

- (BOOL)isAddCornerRadiusLayer
{
    return [objc_getAssociatedObject(self, @"isAddCornerRadiusLayer") boolValue];
}



- (void)setCornerRadiusLayer
{
    CALayer * thisLayer = [self getCornerRadiusLayer];
    if (self.isAddCornerRadiusLayer) {
        CGRect titleLabelFrame = [self convertRect:self.titleLabel.frame toView:self];
        CGFloat layerWidth = titleLabelFrame.size.width;
        CGFloat layerHeight = titleLabelFrame.size.height;
        
        
        if (layerWidth == 0 || layerHeight == 0) {
            return;
        }
        layerHeight += 5;
        layerWidth += 15;
        if (!thisLayer) {
            CALayer * layer = [CALayer layer];
            layer.cornerRadius = self.wkCornerRadius < 0 ? 10 : self.wkCornerRadius ;
            layer.borderWidth = self.wkBorderWidth < 0 ? 0.5 : self.wkBorderWidth;
            layer.borderColor = self.wkBorderColor.CGColor;
            layer.backgroundColor = self.wkBGColor.CGColor;
            layer.name = layerName;
            //计算宽度
            CGFloat width = self.frame.size.width;
            CGFloat height = self.frame.size.height;
            UIView * view = [UIApplication sharedApplication].keyWindow;
            if (width == 0 || height == 0 ) {
                CGRect rect = [self.superview convertRect:self.frame toView:view];
                width = rect.size.width;
                height = rect.size.height;
            }
            
            //WKFIX 超出btn范围的处理
            if (width > 0 && height > 0) {
                CGFloat offset = layerWidth + titleLabelFrame.origin.x - self.frame.size.width;
                if (offset > 0) {
                    
                }
            }
            
            layer.center = CGPointMake(titleLabelFrame.origin.x + titleLabelFrame.size.width / 2.0, titleLabelFrame.origin.y + titleLabelFrame.size.height/2.0);
            layer.bounds = CGRectMake(0, 0, layerWidth,layerHeight);
            CATransition * t = [CATransition new];
            t.type = kCATransitionFade;
            [self.layer addAnimation:t forKey:nil];
            [self.layer addSublayer:layer];
        }
        else
        {
            thisLayer.center = CGPointMake(titleLabelFrame.origin.x + titleLabelFrame.size.width / 2.0, titleLabelFrame.origin.y + titleLabelFrame.size.height/2.0);
            thisLayer.bounds = CGRectMake(0, 0, layerWidth,layerHeight);
        }
    }
    else
    {
        if (thisLayer != nil) {
            [thisLayer removeFromSuperlayer];
        }
    }
}

- (CALayer *)getCornerRadiusLayer
{
    CALayer * thisLayer = nil;
    for (CALayer * layer in self.layer.sublayers) {
        if ([layer.name isEqualToString:layerName]) {
            thisLayer = layer;
            break;
        }
    }
    return thisLayer;
}


+ (void)load{
    Method originalMethod = class_getInstanceMethod([self class], @selector(layoutSubviews));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(wk_layoutSubviews));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)wk_layoutSubviews
{
    [self wk_layoutSubviews];
    [self setCornerRadiusLayer];
}
@end
