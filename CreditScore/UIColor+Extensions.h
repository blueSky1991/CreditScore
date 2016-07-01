//
//  UIColor+Extensions.h
//  CreditScore
//
//  Created by 张东东 on 16/6/29.
//  Copyright © 2016年 张东东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extensions)

+ (UIColor *)colorWithHex:(long)hexColor;

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)alpha;

@end