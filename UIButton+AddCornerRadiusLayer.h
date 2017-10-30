//
//  UIButton+AddCornerRadiusLayer.h
//  KanManHua
//
//  Created by wangkun on 2017/9/28.
//  Copyright © 2017年 KanManHua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WKBtnCRLayerArea) {
    WKBtnCRLayerArea_JustLabel = 0,
    WKBtnCRLayerArea_JustImageView,
    WKBtnCRLayerArea_LabelAndImageView,
};

@interface UIButton (AddCornerRadiusLayer)

@property (nonatomic, assign) CGFloat wkBorderWidth;
@property (nonatomic, strong) UIColor * wkBorderColor;
@property (nonatomic, strong) UIColor * wkBGColor;
@property (nonatomic, assign) CGFloat  wkCornerRadius;
@property (nonatomic, assign, readonly) CGFloat wkCornerRadiusLayerWidth;


/**
 圆角包含区域，默认仅文本
 */
@property (nonatomic, assign) WKBtnCRLayerArea wkCRLayerArea;
/**
 便捷设置圆角 不影响点击区域，点击区域可设置很大，只针对btn的iv和lable内容出于做处理
 根据area决定区域 可包含仅对文本设置，仅对图片设置，图片和文字整体设置，不支持图片和文字 分开设置圆角区域
 */
@property (nonatomic, assign) BOOL isAddCornerRadiusLayer;

@end
