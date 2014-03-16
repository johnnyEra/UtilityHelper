//
//  UtilityHelper.h
//  utilityPrac
//
//  Created by Jason on 14-3-13.
//  Copyright (c) 2014年 com.chinasofti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBMacro.h"                 // 自定义宏

#import "UIButton+Bootstrap.h"      // Nice and flat style
#import "BButton.h"                 // Twitter Bootstrap Style

@interface UtilityHelper : NSObject


// colorWithHexString
-(UIColor*)colorWithHexString:(NSString*)hex;
// Base64 编码和解码
+(NSString * )encodeBase64:(NSString * )input;
+(NSString * )decodeBase64:(NSString * )input;

@end

/*
 ********************************************************************************
 */
@interface UITextField (ZQShakeUITextField)
// 给 UITextField 加上晃动效果
- (void)shake;
@end

/*
 ********************************************************************************
 */
@interface UINavigationBar (ZQDropShadow)
// 给 UINavigationBar 加上偏移阴影
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;
@end

/*
 ********************************************************************************
 */
@interface UIView (ZQUIViewShowActivityView)
// 给 UIView 加上Activity 效果
- (void)showActivityViewAtCenter;
- (void)hideActivityViewAtCenter;
- (void)createActivityViewAtCenter:(UIActivityIndicatorViewStyle)style;
- (UIActivityIndicatorView*)getActivityViewAtCenter;
@end