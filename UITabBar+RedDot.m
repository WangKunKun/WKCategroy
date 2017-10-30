//
//  UITabBar+RedDot.m
//  MKWeekly
//
//  Created by Banning on 2017/8/28.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import "UITabBar+RedDot.h"

#define TabbarItemNums 4.0

@implementation UITabBar (RedDot)

//显示红点
- (void)zy_showBadgeOnItmIndex:(int)index{
    [self zy_removeBadgeOnItemIndex:index];
    //新建小红点
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888+index;
    bview.layer.cornerRadius = 3;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor colorWithHexString:@"ff3b30"];
    //这段代码 只适合 接近满编的tabbar   如果iphone 只有1或者2个的item 雪崩。ipad少于6个也雪崩
//    CGRect tabFram = self.frame;
//    float percentX = (index+0.6)/TabbarItemNums;
//    CGFloat x = ceilf(percentX*tabFram.size.width);
//    CGFloat y = ceilf(0.1*tabFram.size.height);
    CGFloat x = 0;
    CGFloat y = 0;
    NSUInteger thisIndex = 0;
    for (UIView * barBtn in self.subviews) {
        if ([barBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //顺利找到位置
            if (thisIndex == index) {
                //找到 imageview 放到imageview右边
                for (UIView * subView in barBtn.subviews) {
                    if ([subView isKindOfClass:[UIImageView class]]) {
                        x = subView.right - 3;
                        y = barBtn.top + 3;
                    }
                }                
                bview.frame = CGRectMake(x, y, 6, 6);
                [barBtn addSubview:bview];
                [barBtn bringSubviewToFront:bview];
                break;
            }
            thisIndex += 1;

        }
    }
}
//隐藏红点
-(void)zy_hideBadgeOnItemIndex:(int)index{
    [self zy_removeBadgeOnItemIndex:index];
}
//移除控件
- (void)zy_removeBadgeOnItemIndex:(int)index{
    //直接加到uitabbarbtn上
    for (UIView*subView in self.subviews) {
        for (UIView*nextView in subView.subviews) {
            if (nextView.tag == 888+index) {
                [nextView removeFromSuperview];
            }
        }

    }
}


@end
