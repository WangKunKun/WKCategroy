//
//  AppDelegate+GetVC.h
//  MKWeekly
//
//  Created by wangkun on 2017/10/5.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import "AppDelegate.h"
typedef void(^navClosure)(UINavigationController * nav);

@interface AppDelegate (GetVC)

//获得vc
+ (void)getNavVCWithBlock:(navClosure)closure;
+ (UIViewController *)getVisableVC;
+ (UIViewController *)getVCWithClassName:(NSString *)vcClassName;

@end
