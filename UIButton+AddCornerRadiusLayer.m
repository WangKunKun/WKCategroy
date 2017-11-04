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


- (void)setWidthIncrement:(CGFloat)widthIncrement
{
    objc_setAssociatedObject(self, @"widthIncrement", @(widthIncrement), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (CGFloat)widthIncrement
{
    NSNumber * number = objc_getAssociatedObject(self, @"widthIncrement");
    return number ? [number unsignedIntegerValue] : 15;
}

- (void)setBorderLayer:(CALayer *)borderLayer{
    objc_setAssociatedObject(self, @"borderLayer",borderLayer , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)borderLayer{
    return objc_getAssociatedObject(self, @"borderLayer");
}


- (void)setHeightIncrement:(CGFloat)heightIncrement
{
    objc_setAssociatedObject(self, @"heightIncrement", @(heightIncrement), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (CGFloat)heightIncrement
{
    NSNumber * number = objc_getAssociatedObject(self, @"heightIncrement");
    return number ? [number unsignedIntegerValue] : 5;
}


- (void)setWkCRLayerArea:(WKBtnCRLayerArea)wkCRLayerArea
{
    objc_setAssociatedObject(self, @"wkCRLayerArea", @(wkCRLayerArea), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WKBtnCRLayerArea)wkCRLayerArea
{
    NSNumber * number = objc_getAssociatedObject(self, @"wkCRLayerArea");
    NSUInteger style = number ? [number unsignedIntegerValue] : 0;
    return style;
}

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
    return [self getCornerRadiusLayer].frame.size.width;
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

- (void)setBtnBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth widthIncrement:(CGFloat)widthIncrement heightIncrement:(CGFloat)heightIncrement backgroundColor:(UIColor *)backgroundColor{
    self.wkBorderColor = borderColor;
    self.wkBorderWidth = borderWidth;
    self.widthIncrement = widthIncrement;
    self.heightIncrement = heightIncrement;
    if (backgroundColor) {
        self.wkBGColor = backgroundColor;
    }
    self.isAddCornerRadiusLayer = YES;
}

- (void)setBtnBorderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth widthIncrement:(CGFloat)widthIncrement heightIncrement:(CGFloat)heightIncrement backgroundColor:(UIColor *)backgroundColor
{
    self.wkCornerRadius = cornerRadius;
    self.wkBorderColor = borderColor;
    self.wkBorderWidth = borderWidth;
    self.widthIncrement = widthIncrement;
    self.heightIncrement = heightIncrement;
    if (backgroundColor) {
        self.wkBGColor = backgroundColor;
    }
    self.isAddCornerRadiusLayer = YES;
}


- (void)setCornerRadiusLayer
{
    CALayer * thisLayer = [self getCornerRadiusLayer];
    if (self.isAddCornerRadiusLayer) {
        CGRect titleLabelFrame = [self convertRect:self.titleLabel.frame toView:self];
        CGRect imageViewFrame = [self convertRect:self.imageView.frame toView:self];
        CGRect contentFrame = self.wkCRLayerArea == WKBtnCRLayerArea_JustLabel ? titleLabelFrame : (self.wkCRLayerArea == WKBtnCRLayerArea_JustImageView ? imageViewFrame : CGRectUnion(titleLabelFrame, imageViewFrame));
        
        CGFloat layerWidth = contentFrame.size.width;
        CGFloat layerHeight = contentFrame.size.height;
        if (layerWidth == 0 || layerHeight == 0) {
            return;
        }
        layerHeight += self.heightIncrement;
        layerWidth += self.widthIncrement;
        if (!thisLayer) {
            if (self.borderLayer) {
                [self.borderLayer removeFromSuperlayer];
            }
            
            CALayer * layer = [CALayer layer];
            layer.cornerRadius = layerHeight/2 < 0 ? 10 : layerHeight/2 ;
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
                CGFloat offset = layerWidth + contentFrame.origin.x - self.frame.size.width;
                if (offset > 0) {
                    
                }
            }
            
            layer.frame = [self getFrameWithNewCenter:CGPointMake(contentFrame.origin.x + contentFrame.size.width / 2.0, contentFrame.origin.y + contentFrame.size.height/2.0) frame:layer.frame];
            layer.bounds = CGRectMake(0, 0, layerWidth,layerHeight);
            CATransition * t = [CATransition new];
            t.type = kCATransitionFade;
            [self.layer addAnimation:t forKey:nil];
            self.borderLayer = layer;
            [self.layer addSublayer:layer];
            [self bringSubviewToFront:self.titleLabel];
            [self bringSubviewToFront:self.imageView];
        }
        else
        {
            thisLayer.frame = [self getFrameWithNewCenter:CGPointMake(contentFrame.origin.x + contentFrame.size.width / 2.0, contentFrame.origin.y + contentFrame.size.height/2.0) frame:thisLayer.frame] ;
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

- (CGRect)getFrameWithNewCenter:(CGPoint)center frame:(CGRect)frame
{
    CGRect newFrame = frame;
    newFrame.origin.x = center.x - frame.size.width * 0.5;
    newFrame.origin.y = center.y - frame.size.height * 0.5;
    return newFrame;
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
