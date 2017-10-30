//
//  UIButton+AddCornerRadiusLayer.h
//  KanManHua
//
//  Created by wangkun on 2017/9/28.
//  Copyright © 2017年 KanManHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AddCornerRadiusLayer)


@property (nonatomic, assign) CGFloat wkBorderWidth;
@property (nonatomic, strong) UIColor * wkBorderColor;
@property (nonatomic, strong) UIColor * wkBGColor;
@property (nonatomic, assign) CGFloat  wkCornerRadius;
@property (nonatomic, assign, readonly) CGFloat wkCornerRadiusLayerWidth;

//便捷设置圆角
@property (nonatomic, assign) BOOL isAddCornerRadiusLayer;

@end
