//
//  NSData+ContentType.h
//  MKWeekly
//
//  Created by wangkun on 2017/7/27.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    WKFileType_UnKnown = 0,
    WKFileType_Image,
    WKFileType_Zip,
    WKFileType_Rar,
    WKFileType_Pdf,
    WKFileType_Txt,
    WKFileType_Dir
} WKFileType;

@interface NSData (ContentType)

- (WKFileType)getWkContentType;

@end
