//
//  UIButton+WKTouchDown.h
//  KanManHua
//
//  Created by wangkun on 2017/10/2.
//  Copyright © 2017年 KanManHua. All rights reserved.
//

#import <UIKit/UIKit.h>


//实现和安卓一样的功能
@interface UIButton (WKTouchDown)

@property (nonatomic, assign) BOOL isVaildDownModel;
@property (nonatomic, strong) UIColor * touchDownTitleColor;
@property (nonatomic, strong) UIColor * touchDownBGColor;

@end
