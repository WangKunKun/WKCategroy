//
//  UIImageView+CornerRadius.h
//  MyPractise
//
//  Created by lzy on 16/3/1.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (CornerRadius)


/**
 判断是否是headiv 自带边框 和 圆角
 */
@property (nonatomic, assign) BOOL zy_isHeaderIV;

@property (assign, nonatomic) CGFloat   zyRadius;
@property (assign, nonatomic) CGFloat   zyBorderWidth;
@property (strong, nonatomic) UIColor * zyBorderColor;


@end
