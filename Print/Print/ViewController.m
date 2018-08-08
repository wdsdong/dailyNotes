//
//  ViewController.m
//  Print
//
//  Created by wds on 2018/7/25.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startScan];
    
    
    NSString *hanzi =   @"王东升王";
    NSString *yingwen = @"wdsdong";
    NSString *shuzi =   @"0.000 _";
    
    int i1 = [self charNumber:hanzi];
    int i2 = [self charNumber:yingwen];
    int i3 = [self charNumber:shuzi];
    
}


//计算NSString中英文字符串的字符长度。ios 中一个汉字算2字符数
- (int)charNumber:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return strlength;
}

// 按字节截取字符串
//if ([self charNumber:coopBoxName] > 12) {
//    NSString* tmp;
//    for (int i = coopBoxName.length; i > 0; i--) {
//        tmp = [coopBoxName substringToIndex:i];
//        if ([self charNumber:tmp] <= 9) {
//            coopBoxName = [tmp stringByAppendingString:@"..."];
//            break;
//        }
//    }
//}

- (void)startScan {
    [super startScan];
    NSLog(@"%@",devicesList);
    
}


@end
