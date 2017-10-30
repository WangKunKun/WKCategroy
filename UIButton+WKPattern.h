//
//  UIButton+WKPattern.h
//  DetailPageDemo
//
//  Created by wangkun on 2017/6/19.
//  Copyright © 2017年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    UIButtonContentInsidePattern_left = 0, //图左 字右
    UIButtonContentInsidePattern_right,
    UIButtonContentInsidePattern_top,
    UIButtonContentInsidePattern_bottom
} UIButtonContentInsidePattern;

typedef enum : NSUInteger {
    UIButtonContentPattern_left,
    UIButtonContentPattern_right,
    UIButtonContentPattern_center,
} UIButtonContentPattern;

@interface UIButton (WKPattern)

- (void)layoutWithInsidePattern:(UIButtonContentInsidePattern)insidePattern contentPattern:(UIButtonContentPattern)contentPattern space:(CGFloat)space;




@end
