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

//圆角layer
@property (nonatomic, strong) CALayer *borderLayer;
//圆角layer的边框宽
@property (nonatomic, assign) CGFloat wkBorderWidth;
//圆角layer的边框颜色
@property (nonatomic, strong) UIColor * wkBorderColor;
//圆角layer的背景色
@property (nonatomic, strong) UIColor * wkBGColor;
//圆角layer的圆角度
@property (nonatomic, assign) CGFloat wkCornerRadius;
/**
 layer的实际宽度
 */
@property (nonatomic, assign, readonly) CGFloat wkCornerRadiusLayerWidth;
/**
 layer生成时，添加的宽度增量
 */
@property (nonatomic, assign) CGFloat widthIncrement;
/**
 layer生成时，添加的高度增量
 */
@property (nonatomic, assign) CGFloat heightIncrement;//高度增量


/**
 圆角包含区域，默认仅文本
 */
@property (nonatomic, assign) WKBtnCRLayerArea wkCRLayerArea;
/**
 便捷设置圆角 不影响点击区域，点击区域可设置很大，只针对btn的iv和lable内容出于做处理
 根据area决定区域 可包含仅对文本设置，仅对图片设置，图片和文字整体设置，不支持图片和文字 分开设置圆角区域
 */
@property (nonatomic, assign) BOOL isAddCornerRadiusLayer;


/**
 带边框控件,调用此方法则自动开启isAddCornerRadiusLayer属性
 此方法不传CornerRadius 默认为高度的一半,即边缘为半圆
 */
- (void)setBtnBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth widthIncrement:(CGFloat)widthIncrement heightIncrement:(CGFloat)heightIncrement backgroundColor:(UIColor *)backgroundColor;

- (void)setBtnBorderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth widthIncrement:(CGFloat)widthIncrement heightIncrement:(CGFloat)heightIncrement backgroundColor:(UIColor *)backgroundColor;


@end
