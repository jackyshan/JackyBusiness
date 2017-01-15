//
//  Macro.h
//  YSBBusiness
//
//  Created by lu lucas on 4/11/14.
//  Copyright (c) 2014 lu lucas. All rights reserved.
//

#ifndef YSBBusiness_Macro_h
#define YSBBusiness_Macro_h

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kViewHeight (kScreenHeight - 64)

#define bIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define isDeviceIPad ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad)

#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kiOSVersion [[UIDevice currentDevice] systemVersion]

//color
#define COLOR_CLEAR [UIColor clearColor]
#define COLOR_BLACK [UIColor blackColor]
#define COLOR_WHITE [UIColor whiteColor]

// 文字类
#define COLOR_T1 [UIColor colorWithRed:0x2f / 255.0f green:0x31 / 255.0f blue:0x32 / 255.0f alpha:1.0f]
#define COLOR_T2 [UIColor colorWithRed:0x56 / 255.0f green:0x5a / 255.0f blue:0x5c / 255.0f alpha:1.0f]
#define COLOR_T3 [UIColor colorWithRed:0x7c / 255.0f green:0x7c / 255.0f blue:0x7d / 255.0f alpha:1.0f]
#define COLOR_T4 [UIColor colorWithRed:0xfd / 255.0f green:0x5c / 255.0f blue:0x02 / 255.0f alpha:1.0f]
#define COLOR_T5 [UIColor colorWithRed:0xfc / 255.0f green:0x89 / 255.0f blue:0x4b / 255.0f alpha:1.0f]

//可删除
#define COLOR_FFFFFF [UIColor colorWithRed:0x7c / 255.0f green:0x7c / 255.0f blue:0x7d / 255.0f alpha:1.0f]
#define COLOR_000000 [UIColor colorWithRed:0x7c / 255.0f green:0x7c / 255.0f blue:0x7d / 255.0f alpha:1.0f]

// 色块类
#define COLOR_B1 [UIColor colorWithRed:0x7c / 255.0f green:0x7c / 255.0f blue:0x7d / 255.0f alpha:1.0f]
#define COLOR_B2 [UIColor colorWithRed:0xe1 / 255.0f green:0xe2 / 255.0f blue:0xe1 / 255.0f alpha:1.0f]
#define COLOR_B3 [UIColor colorWithRed:0xf5 / 255.0f green:0xf6 / 255.0f blue:0xf5 / 255.0f alpha:1.0f]
#define COLOR_B4 [UIColor colorWithRed:0xfd / 255.0f green:0x5c / 255.0f blue:0x02 / 255.0f alpha:1.0f]
#define COLOR_B5 [UIColor colorWithRed:0xfc / 255.0f green:0x89 / 255.0f blue:0x4b / 255.0f alpha:1.0f]

// 按钮类
#define COLOR_BT1 [UIColor colorWithRed:0xaa / 255.0f green:0xaa / 255.0f blue:0xaa / 255.0f alpha:1.0f]
#define COLOR_BT2 [UIColor colorWithRed:0xfc / 255.0f green:0x89 / 255.0f blue:0x4b / 255.0f alpha:1.0f]
#define COLOR_BT3 [UIColor colorWithRed:0xfd / 255.0f green:0x5c / 255.0f blue:0x02 / 255.0f alpha:1.0f]

// 线类
#define COLOR_L1 [UIColor colorWithRed:0xe1 / 255.0f green:0xe2 / 255.0f blue:0xe1 / 255.0f alpha:1.0f]
#define COLOR_L2 [UIColor colorWithRed:0xfd / 255.0f green:0x5c / 255.0f blue:0x02 / 255.0f alpha:1.0f]

#endif
