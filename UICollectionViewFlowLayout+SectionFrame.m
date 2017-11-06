//
//  UICollectionViewFlowLayout+SectionFrame.m
//  KanManHua
//
//  Created by wangkun on 2017/10/24.
//  Copyright © 2017年 KanManHua. All rights reserved.
//

#import "UICollectionViewFlowLayout+SectionFrame.h"

@implementation UICollectionViewFlowLayout (SectionFrame)

- (NSIndexPath*)getVisableMinIndexPathForSection:(NSUInteger)section
{
    NSArray * indexpaths =     [self.collectionView indexPathsForVisibleItems];
    NSIndexPath * minIndexPath = nil;
    for (NSIndexPath * indexPath in indexpaths) {
        if (indexPath.section == section) {
            if (minIndexPath == nil) {
                minIndexPath = [indexPath copy];
            }
            if (minIndexPath.row > indexPath.row) {
                minIndexPath = [indexPath copy];
            }
        }
    }
    return minIndexPath;
}


//计算section的frame
- (NSArray<NSValue *> *)calculateSectionsFrame
{
    NSUInteger sections = [self.collectionView numberOfSections];
    NSMutableArray * arr =[NSMutableArray array];
    //    NSUInteger maxSection = [self.collectionView indexPathsForVisibleItems].lastObject.section;
    for (NSUInteger i = 0; i < sections; i ++) {
        CGRect sectionFrame = [self getFrameWithSection:i isContainHeader:YES isContainFooter:YES isOnlyVisible:NO];
        [arr addObject:[NSValue valueWithCGRect:sectionFrame]];
    }
    return arr;
}

- (CGRect)getVisibleFrameWithSection:(NSUInteger)section
{
    return [self getVisibleFrameWithSection:section isContainHeader:YES isContainFooter:YES];
}

- (CGRect)getVisibleFrameWithSection:(NSUInteger)section isContainHeader:(BOOL)isContainHeader isContainFooter:(BOOL)isContainFooter
{
    return [self getFrameWithSection:section isContainHeader:isContainHeader isContainFooter:isContainFooter isOnlyVisible:YES];
}


- (CGRect)getFrameWithSection:(NSUInteger)i isContainHeader:(BOOL)isContainHeader isContainFooter:(BOOL)isContainFooter isOnlyVisible:(BOOL)isOnlyVisible
{
    NSUInteger sectionItemCount = [self.collectionView numberOfItemsInSection:i];
    //第一个
    NSIndexPath * fristIndexPath = [NSIndexPath indexPathForItem:0 inSection:i];
    //算头部和尾部
    
    
    CGRect headerFrame = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:fristIndexPath].frame;
    CGRect footerFrame = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:fristIndexPath].frame;
    
    CGRect fristFrame = CGRectZero;
    CGRect lastFrame = CGRectZero;
    
    if (sectionItemCount <= 0) {
        fristFrame = isContainHeader ? headerFrame : CGRectZero;
        lastFrame = isContainFooter ? footerFrame : CGRectZero;
    }
    else
    {
        fristFrame = [self layoutAttributesForItemAtIndexPath:fristIndexPath].frame;
        NSIndexPath * lastIndexPath = [NSIndexPath indexPathForItem:sectionItemCount - 1 inSection:i];
        lastFrame = [self layoutAttributesForItemAtIndexPath:lastIndexPath].frame;
        
        if (isContainHeader) {
            if (headerFrame.size.width > 0 && headerFrame.size.height > 0) {
                fristFrame = headerFrame;
            }
        }

        if (isContainFooter) {
            if (footerFrame.size.width > 0 && footerFrame.size.height > 0) {
                lastFrame = headerFrame;
            }
        }

    }
    
    //组合成section的frame
    //分横向滚动和竖向滚动
    //情况1 同一行
    CGFloat width = lastFrame.origin.x + lastFrame.size.width;
    CGFloat height = lastFrame.origin.y + lastFrame.size.height;
    
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionVertical:
            if (width < self.collectionView.frame.size.width) {
                width = width < self.collectionView.frame.size.width ? self.collectionView.frame.size.width : width;
            }
            break;
        case UICollectionViewScrollDirectionHorizontal:
            if (height < self.collectionView.frame.size.height) {
                height = height < self.collectionView.frame.size.height ? self.collectionView.frame.size.height : height;
            }
            break;
        default:
            break;
    }
    
    
    CGRect sectionFrame = CGRectMake(fristFrame.origin.x, fristFrame.origin.y, width, height);
    
    if (isOnlyVisible) {
        CGRect cvVisableFrame = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
        sectionFrame = CGRectIntersection(sectionFrame, cvVisableFrame);
        if (CGRectIsNull(sectionFrame)) {
            sectionFrame = CGRectZero;
        }
    }
    return sectionFrame;
}
@end
