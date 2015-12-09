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

#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#undef bLogSwitch
#undef kSendLog
#undef bCatchCrash
#ifdef DEBUG
#define bCatchCrash NO
#define bLogSwitch YES
#define kSendLog REALTIME
#else
#define bCatchCrash YES
#define bLogSwitch NO
#define kSendLog SEND_ON_EXIT
#define NSLog(...) {}
#endif

#define kButtonTag  10000

#pragma mark - 颜色
#define kMainColor [UIColor colorWithRed:0xf8 / 255.0f green:0xb0 / 255.0f blue:0xcf / 255.0f alpha:1.0f]
#define kBackgroundColor [UIColor whiteColor]
#define kAlertViewRedColor [UIColor colorWithRed:230 / 255.0f green:0 / 255.0f blue:18 / 255.0f alpha:1.0f]
#define COLOR_CLEAR [UIColor clearColor]
#define COLOR_1B1B1B [UIColor colorWithRed:0x1b / 255.0f green:0x1b / 255.0f blue:0x1b / 255.0f alpha:1.0f]
#define COLOR_FD5C02 [UIColor colorWithRed:0xfd / 255.0f green:0x5c / 255.0f blue:0x02 / 255.0f alpha:1.0f]
#define COLOR_EEEEEE [UIColor colorWithRed:0xee / 255.0f green:0xee / 255.0f blue:0xee / 255.0f alpha:1.0f]
#define COLOR_707070 [UIColor colorWithRed:0x70 / 255.0f green:0x70 / 255.0f blue:0x70 / 255.0f alpha:1.0f]
#define COLOR_D2D2D2 [UIColor colorWithRed:0xd2 / 255.0f green:0xd2 / 255.0f blue:0xd2 / 255.0f alpha:1.0f]
#define COLOR_E5E5E5 [UIColor colorWithRed:0xe5 / 255.0f green:0xe5 / 255.0f blue:0xe5 / 255.0f alpha:1.0f]
#define COLOR_FE5C03 [UIColor colorWithRed:0xfe / 255.0f green:0x5c / 255.0f blue:0x03 / 255.0f alpha:1.0f]
#define COLOR_DCDCDC [UIColor colorWithRed:0xdc / 255.0f green:0xdc / 255.0f blue:0xdc / 255.0f alpha:1.0f]
#define COLOR_BFBFBF [UIColor colorWithRed:0xbf / 255.0f green:0xbf / 255.0f blue:0xbf / 255.0f alpha:1.0f]
#define COLOR_C9C9C9 [UIColor colorWithRed:0xc9 / 255.0f green:0xc9 / 255.0f blue:0xc9 / 255.0f alpha:1.0f]
#define COLOR_FFFFFF [UIColor colorWithRed:0xff / 255.0f green:0xff / 255.0f blue:0xff / 255.0f alpha:1.0f]
#define COLOR_AAAAAA [UIColor colorWithRed:0xaa / 255.0f green:0xaa / 255.0f blue:0xaa / 255.0f alpha:1.0f]
#define COLOR_7D7D7D [UIColor colorWithRed:0x7d / 255.0f green:0x7d / 255.0f blue:0x7d / 255.0f alpha:1.0f]
#define COLOR_00A0E9 [UIColor colorWithRed:0x00 / 255.0f green:0xa0 / 255.0f blue:0xe9 / 255.0f alpha:1.0f]
#define COLOR_E60012 [UIColor colorWithRed:0xe6 / 255.0f green:0x00 / 255.0f blue:0x12 / 255.0f alpha:1.0f]
#define COLOR_626262 [UIColor colorWithRed:0x62 / 255.0f green:0x62 / 255.0f blue:0x62 / 255.0f alpha:1.0f]
#define COLOR_B5B5B5 [UIColor colorWithRed:0xb5 / 255.0f green:0xb5 / 255.0f blue:0xb5 / 255.0f alpha:1.0f]
#define COLOR_A0A0A0 [UIColor colorWithRed:0xa0 / 255.0f green:0xa0 / 255.0f blue:0xa0 / 255.0f alpha:1.0f]
#define COLOR_000000 [UIColor colorWithRed:0x00 / 255.0f green:0x00 / 255.0f blue:0x00 / 255.0f alpha:1.0f]
#define COLOR_4B4949 [UIColor colorWithRed:0x4b / 255.0f green:0x49 / 255.0f blue:0x49 / 255.0f alpha:1.0f]
#define COLOR_3F3D3D [UIColor colorWithRed:0x4b / 255.0f green:0x49 / 255.0f blue:0x49 / 255.0f alpha:1.0f]
#define COLOR_525151 [UIColor colorWithRed:0x52 / 255.0f green:0x51 / 255.0f blue:0x51 / 255.0f alpha:1.0f]
#define COLOR_00B7EE [UIColor colorWithRed:0x00 / 255.0f green:0xb7 / 255.0f blue:0xee / 255.0f alpha:1.0f]
#define COLOR_313131 [UIColor colorWithRed:0x31 / 255.0f green:0x31 / 255.0f blue:0x31 / 255.0f alpha:1.0f]
#define COLOR_323232 [UIColor colorWithRed:0x32 / 255.0f green:0x32 / 255.0f blue:0x32 / 255.0f alpha:1.0f]
#define COLOR_666666 [UIColor colorWithRed:0x66 / 255.0f green:0x66 / 255.0f blue:0x66 / 255.0f alpha:1.0f]
#define COLOR_393837 [UIColor colorWithRed:0x39 / 255.0f green:0x38 / 255.0f blue:0x37 / 255.0f alpha:1.0f]
#define COLOR_ECEDED [UIColor colorWithRed:0xec / 255.0f green:0xed / 255.0f blue:0xed / 255.0f alpha:1.0f]
#define COLOR_F8F8F8 [UIColor colorWithRed:0xf8 / 255.0f green:0xf8 / 255.0f blue:0xf8 / 255.0f alpha:1.0f]
#define COLOR_FDA574 [UIColor colorWithRed:0xfd / 255.0f green:0xa5 / 255.0f blue:0x74 / 255.0f alpha:1.0f]
#define COLOR_FC950F [UIColor colorWithRed:0xfc / 255.0f green:0x95 / 255.0f blue:0x0f / 255.0f alpha:1.0f]
#define COLOR_6B6B6B [UIColor colorWithRed:0x6b / 255.0f green:0x6b / 255.0f blue:0x6b / 255.0f alpha:1.0f]
#define COLOR_B7B7B7 [UIColor colorWithRed:0xb7 / 255.0f green:0xb7 / 255.0f blue:0xb7 / 255.0f alpha:1.0f]
#define COLOR_FF5A00 [UIColor colorWithRed:0xff / 255.0f green:0x5a / 255.0f blue:0x00 / 255.0f alpha:1.0f]
#define COLOR_4F4D4D [UIColor colorWithRed:0x4f / 255.0f green:0x4d / 255.0f blue:0x4d / 255.0f alpha:1.0f]
#define COLOR_FD0802 [UIColor colorWithRed:0xfd / 255.0f green:0x08 / 255.0f blue:0x02 / 255.0f alpha:1.0f]
#define COLOR_2F2E2D [UIColor colorWithRed:0x2f / 255.0f green:0x2e / 255.0f blue:0x2d / 255.0f alpha:1.0f]
#define COLOR_62605E [UIColor colorWithRed:0x62 / 255.0f green:0x62 / 255.0f blue:0x5e / 255.0f alpha:1.0f]
#define COLOR_595857 [UIColor colorWithRed:0x59 / 255.0f green:0x58 / 255.0f blue:0x57 / 255.0f alpha:1.0f]
#define COLOR_454543 [UIColor colorWithRed:0x45 / 255.0f green:0x45 / 255.0f blue:0x43 / 255.0f alpha:1.0f]
#define COLOR_898989 [UIColor colorWithRed:0x89 / 255.0f green:0x89 / 255.0f blue:0x89 / 255.0f alpha:1.0f]
#define COLOR_969696 [UIColor colorWithRed:0x96 / 255.0f green:0x96 / 255.0f blue:0x96 / 255.0f alpha:1.0f]
#define COLOR_535353 [UIColor colorWithRed:0x53 / 255.0f green:0x53 / 255.0f blue:0x53 / 255.0f alpha:1.0f]
#define COLOR_656464 [UIColor colorWithRed:0x65 / 255.0f green:0x64 / 255.0f blue:0x64 / 255.0f alpha:1.0f]
#define COLOR_979797 [UIColor colorWithRed:0x97 / 255.0f green:0x97 / 255.0f blue:0x97 / 255.0f alpha:1.0f]
#define COLOR_646464 [UIColor colorWithRed:0x64 / 255.0f green:0x64 / 255.0f blue:0x64 / 255.0f alpha:1.0f]
#define COLOR_464646 [UIColor colorWithRed:0x46 / 255.0f green:0x46 / 255.0f blue:0x46 / 255.0f alpha:1.0f]
#define COLOR_5A5A5A [UIColor colorWithRed:0x5A / 255.0f green:0x5A / 255.0f blue:0x5A / 255.0f alpha:1.0f]
#define COLOR_F5F5F5 [UIColor colorWithRed:0xf5 / 255.0f green:0xf5 / 255.0f blue:0xf5 / 255.0f alpha:1.0f]
#define COLOR_E5F5FF [UIColor colorWithRed:0xe5 / 255.0f green:0xf5 / 255.0f blue:0xff / 255.0f alpha:1.0f]
#define COLOR_733506 [UIColor colorWithRed:0x73 / 255.0f green:0x35 / 255.0f blue:0x06 / 255.0f alpha:1.0f]
#define COLOR_E2E2E2 [UIColor colorWithRed:0xe2 / 255.0f green:0xe2 / 255.0f blue:0xe2 / 255.0f alpha:1.0f]
#define COLOR_B4B4B4 [UIColor colorWithRed:0xb4 / 255.0f green:0xb4 / 255.0f blue:0xb4 / 255.0f alpha:1.0f]

// 专业版配色表
// 文字类
#define COLOR_T1 [UIColor colorWithRed:0x2f / 255.0f green:0x31 / 255.0f blue:0x32 / 255.0f alpha:1.0f]
#define COLOR_T2 [UIColor colorWithRed:0x56 / 255.0f green:0x5a / 255.0f blue:0x5c / 255.0f alpha:1.0f]
#define COLOR_T3 [UIColor colorWithRed:0x7c / 255.0f green:0x7c / 255.0f blue:0x7d / 255.0f alpha:1.0f]
#define COLOR_T4 [UIColor colorWithRed:0xfd / 255.0f green:0x5c / 255.0f blue:0x02 / 255.0f alpha:1.0f]
#define COLOR_T5 [UIColor colorWithRed:0xfc / 255.0f green:0x89 / 255.0f blue:0x4b / 255.0f alpha:1.0f]

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
