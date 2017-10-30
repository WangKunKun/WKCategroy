//
//  UIButton+WKPattern.m
//  DetailPageDemo
//
//  Created by wangkun on 2017/6/19.
//  Copyright © 2017年 wangkun. All rights reserved.
//

#import "UIButton+WKPattern.h"

@implementation UIButton (WKPattern)

- (void)layoutWithInsidePattern:(UIButtonContentInsidePattern)insidePattern contentPattern:(UIButtonContentPattern)contentPattern space:(CGFloat)space
{
    
    CGRect imageFrame = [self convertRect:self.imageView.frame toView:[UIApplication sharedApplication].keyWindow];
    CGRect labelFrame = [self convertRect:self.titleLabel.frame toView:[UIApplication sharedApplication].keyWindow];

    CGFloat imageWidth = imageFrame.size.width;
    CGFloat imageHeight = imageFrame.size.height;
    CGFloat labelWidth = labelFrame.size.width;
    CGFloat labelHeight = labelFrame.size.height;
    //上下结构 内部先保证图片的宽度，有可能出现图片宽度 占据了btn的所有宽度，则label宽度为0了

//    if (insidePattern >= 2) {
//        if (labelWidth <= 0) {
//            labelWidth = self.frame.size.width;
//            self.titleLabel.width  = self.frame.size.width;
//        }
//    }
    
//    NSNumberFormatter * nbf = [[NSNumberFormatter alloc] init];
//    CGFloat systemV = [[nbf numberFromString:[UIDevice currentDevice].systemVersion] floatValue];
//    
//    if (systemV >= 8.0) {
//        labelWidth = self.titleLabel.intrinsicContentSize.width;
//        labelHeight = self.titleLabel.intrinsicContentSize.height;
//    }
//    else
//    {
//        labelWidth = self.titleLabel.frame.size.width;
//        labelHeight = self.titleLabel.frame.size.height;
//    }
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets lableEdgeInsets = UIEdgeInsetsZero;

    CGFloat left = 10;
    CGFloat right = self.frame.size.width - (labelWidth + imageWidth + space / 2.0 + 10);
    switch (insidePattern) {
        case UIButtonContentInsidePattern_top:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space / 2.0, 0, 0, -labelWidth);
            lableEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-space/2.0, 0);
            right = self.frame.size.width - (labelWidth > imageWidth ? labelWidth : imageWidth) - 10;

            break;
        case UIButtonContentInsidePattern_left:
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            lableEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
            break;
        case UIButtonContentInsidePattern_bottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            lableEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWidth, 0, 0);
            break;
            
        case UIButtonContentInsidePattern_right:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            lableEdgeInsets = UIEdgeInsetsMake(0, -imageWidth-space/2.0, 0, imageWidth+space/2.0);
            break;
        default:
            break;
    }
    
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = lableEdgeInsets;
    switch (contentPattern) {
        case UIButtonContentPattern_left:
            self.contentEdgeInsets = UIEdgeInsetsMake(0, left, 0, right);
            break;
        case UIButtonContentPattern_right:
        {
            CGFloat tmp = right;
            right = left;
            left = tmp;
            self.contentEdgeInsets = UIEdgeInsetsMake(0, left, 0, right);
        }
            break;
            
        case UIButtonContentPattern_center:
            break;
        default:
            break;
    }
    

    
}

@end
