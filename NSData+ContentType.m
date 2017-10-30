//
//  NSData+ContentType.m
//  MKWeekly
//
//  Created by wangkun on 2017/7/27.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import "NSData+ContentType.h"
@implementation NSData (ContentType)

- (WKFileType)getWkContentType
{
    const NSInteger length = 12;
    Byte bytes[length];
    if ([self length] >= length) {
        [self getBytes:&bytes length:length];
    }
    else
    {
        //小于12个就··· 不知道会不会有问题
        return WKFileType_UnKnown;
    }
    
    
    switch (bytes[0]) {
        case 0xFF://jpeg
        case 0x89://png
        case 0x47://gif
        case 0x49:
        case 0x4D://tiff
            return WKFileType_Image;
        case 0x52:
        {
            // R as RIFF for WEBP
            
            NSString *testString = [[NSString alloc] initWithData:[self subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return WKFileType_Image;
            }
            break;
        }
            
        case 0x25:
            return WKFileType_Pdf;
        case 0x46:
            return WKFileType_Txt;
    }
    
    if (bytes[0] == 'P' && bytes[1] == 'K' && bytes[2] == 3 && bytes[3] == 4) {
        // File starts with ZIP magic ...
        return WKFileType_Zip;
    }
    if (bytes[0] == 0x52 && bytes[1] == 0x61 && bytes[2] == 0x72 && bytes[3] == 0x21 && bytes[4] == 0x1A && bytes[5] == 0x07 ) {
        if (bytes[6] == 0x00) {
            return WKFileType_Rar;
        }
        else
        {
            if (bytes[6] == 0x01 && bytes[7] == 0x00) {
                return WKFileType_Rar;
            }
        }
    }
    
    
    return WKFileType_UnKnown;
}
@end
