//
//  HBMacro.h
//  HolyBible
//
//  Created by zhou on 14-3-8.
//  Copyright (c) 2014年 zhou. All rights reserved.
//


//1.首次启动判断
//#define First_Launched @"firstLaunch"

//2.ios7系统判断
#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)

//3.是否IPhone5、是否IPad
#define isIPhone5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),1[[UIScreen mainScreen] currentMode].size) : NO)

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//4.加载图片宏：
#define LOADIMAGE(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

//5.rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//6.设置颜色RGB
#define COLOR(R, G, B, A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//-------------------获取设备大小-------------------------
//NavBar高度
#define NavigationBar_HEIGHT 44
#define TabBar_HEIGHT 49
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif



