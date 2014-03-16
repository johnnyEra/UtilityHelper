//
//  UtilityHelper.m
//  utilityPrac
//
//  Created by Jason on 14-3-13.
//  Copyright (c) 2014年 com.chinasofti. All rights reserved.
//

#import "UtilityHelper.h"
#import "GTMBase64.h"


#define activityViewTag         0x401
#define aViewTag                0x402

@implementation UtilityHelper

// colorWithHexString
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

// Base64
+(NSString * )encodeBase64:(NSString * )input
{
    NSData * data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    // 转换到base64
    data = [GTMBase64 encodeData:data];
    NSString * base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;//[base64String autorelease];
}
+(NSString * )decodeBase64:(NSString * )input
{
    NSData * data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    // 转换到base64
    data = [GTMBase64 decodeData:data];
    NSString * base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;//[base64String autorelease];
}
@end

/*              UITextField
 ********************************************************************************
 */
@implementation UITextField (ZQShakeUITextField)

// shake
- (void) shake {
    CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyAn setDuration:0.6f];
    float offset=5;
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      nil];
    [keyAn setValues:array];
//    [array release];
    NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.1f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.4f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.6f],
                      [NSNumber numberWithFloat:0.7f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f],
                      nil];
    [keyAn setKeyTimes:times];
//    [times release];
    [self.layer addAnimation:keyAn forKey:@"TextAnim"];
}

@end


/*              UINavigationBar
 ********************************************************************************
 */
@implementation UINavigationBar (ZQDropShadow)

// dropShadow
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
    
}

@end

/*              UIView
 ********************************************************************************
 */
@implementation UIView (ZQUIViewShowActivityView)

// show activity
- (void)showActivityViewAtCenter
{
    UIActivityIndicatorView* activityView = [self getActivityViewAtCenter];
    if (activityView == nil){
        [self createActivityViewAtCenter:UIActivityIndicatorViewStyleWhiteLarge];
        activityView = [self getActivityViewAtCenter];
    }
    
    [activityView startAnimating];
}

- (void)hideActivityViewAtCenter
{
    UIActivityIndicatorView* activityView = [self getActivityViewAtCenter];
    if (activityView != nil){
        [activityView stopAnimating];
    }
    for (UIView *view in [self subviews]) {
        if (view != nil && view.tag == aViewTag){
            [view removeFromSuperview];
            return;
        }
    }
    
}

- (void)createActivityViewAtCenter:(UIActivityIndicatorViewStyle)style
{
    static int size = 30;
    UIView* aView = [[UIView alloc] init];
    aView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 50/2, ([UIScreen mainScreen].bounds.size.height-113) /2 - 50/2, 50, 50);
    aView.backgroundColor = [UIColor blackColor];
    aView.layer.cornerRadius = 5;
    aView.layer.masksToBounds = YES;
    aView.tag = aViewTag;
    UIActivityIndicatorView* activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    activityView.frame = CGRectMake(10, 10, size, size);
    activityView.tag = activityViewTag;
    [aView addSubview:activityView];
//    [activityView release];
    
    [self addSubview:aView];
    [self bringSubviewToFront: aView];
//    [aView release];
    
}

- (UIActivityIndicatorView*)getActivityViewAtCenter
{
    for (UIView *view in [self subviews]) {
        if (view.tag == aViewTag) {
            [self bringSubviewToFront:view];
            for (UIView *inview in [view subviews])
            {
                if (inview != nil && [inview isKindOfClass:[UIActivityIndicatorView class]]){
                    return (UIActivityIndicatorView*)inview;
                }
                
            }
        }
    }
    return nil;
}


@end