//
//  UICollectionViewFlowLayout+SectionFrame.h
//  KanManHua
//
//  Created by wangkun on 2017/10/24.
//  Copyright © 2017年 KanManHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewFlowLayout (SectionFrame)
- (CGRect)getFrameWithSection:(NSUInteger)i isContainHeader:(BOOL)isContainHeader isContainFooter:(BOOL)isContainFooter isOnlyVisible:(BOOL)isOnlyVisible;//获取section的frame 可以超出屏幕 （即便没有渲染也可知道）
- (NSArray<NSValue *> *)calculateSectionsFrame;

- (CGRect)getVisibleFrameWithSection:(NSUInteger)section;//默认包含header和footer
- (CGRect)getVisibleFrameWithSection:(NSUInteger)section isContainHeader:(BOOL)isContainHeader isContainFooter:(BOOL)isContainFooter;//获取section的frame
- (NSIndexPath*)getVisableMinIndexPathForSection:(NSUInteger)section;

@end
