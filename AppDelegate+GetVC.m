//
//  AppDelegate+GetVC.m
//  MKWeekly
//
//  Created by wangkun on 2017/10/5.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import "AppDelegate+GetVC.h"
@implementation AppDelegate (GetVC)


+ (UIViewController *)getVisableVC
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return [delegate getVisableVC];
}

+ (void)getNavVCWithBlock:(navClosure)closure
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate getNavVCWithBlock:closure];
}

- (UIViewController *)getVisableVC
{
    UIViewController * vc = self.window.rootViewController;
    while ([vc isKindOfClass:[UITabBarController class]]) {
        vc = ((UITabBarController *)vc).selectedViewController;
    }
    
    while ([vc isKindOfClass:[UINavigationController class]]) {
        vc = ((UINavigationController *)vc).visibleViewController;
    }
    
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    
    return vc;
}

- (void)getNavVCWithBlock:(navClosure)closure
{
    UIViewController * tmpVC = [self getVisableVC];
    UINavigationController * navi = tmpVC.navigationController;
    if (navi) {
        closure(navi);
    }
    else
    {
        [navi dismissViewControllerAnimated:YES completion:^{
            [self getNavVCWithBlock:closure];
        }];
    }
}

+ (UIViewController *)getVCWithClassName:(NSString *)vcClassName
{
    UIViewController * rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([[rootVC className] isEqualToString:vcClassName]) {
        return rootVC;
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabVC = (UITabBarController *)rootVC;
        
        //先从selectedvc里面找
        UIViewController * tabSelectedVC = tabVC.selectedViewController;
        if ([[tabSelectedVC className] isEqualToString:vcClassName]) {
            return tabSelectedVC;
        }
        if ([tabSelectedVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)tabSelectedVC;
            for (UIViewController * navSubVC in nav.viewControllers) {
                if ([[navSubVC className] isEqualToString:vcClassName]) {
                    return navSubVC;
                }
            }
        }
        for (UIViewController * tabSubVC in tabVC.viewControllers) {
            //先找了 这次就不找了
            if ([tabSubVC isEqual:tabVC.selectedViewController]) {
                continue;
            }
            
            if ([[tabSubVC className] isEqualToString:vcClassName]) {
                return tabSubVC;
            }
            if ([tabSubVC isKindOfClass:[UINavigationController class]]) {
                UINavigationController * nav = (UINavigationController *)tabSubVC;
                for (UIViewController * navSubVC in nav.viewControllers) {
                    if ([[navSubVC className] isEqualToString:vcClassName]) {
                        return navSubVC;
                    }
                }
            }
        }
    }
    return nil;
}

+ (UIView *)getVisableView
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return [delegate getVisableView];
}

- (UIView *)getVisableView
{
    UIViewController * vc = [self getVisableVC];
    while (vc.tabBarController) {
        vc = vc.tabBarController;
    }
    while (vc.navigationController) {
        vc = vc.navigationController;
    }
    while (vc.tabBarController) {
        vc = vc.tabBarController;
    }
    while (vc.navigationController) {
        vc = vc.navigationController;
    }
    return vc.view;
}

@end
