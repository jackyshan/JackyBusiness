//
//  LZZImmediateRefreshTableFooterView.h
//  YSBBusiness
//
//  Created by lu lucas on 17/4/15.
//  Copyright (c) 2015 lu lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
    LZZImmediatePullRefreshNoMore = 0,
    LZZImmediatePullRefreshLoading,
    LZZImmediatePullRefreshHide,
}   LZZImmediatePullRefreshState;


typedef enum{
    RefreshImmediateFooterTypeText = 0,
    RefreshImmediateFooterTypeButtom,
}   RefreshImmediateFooterType;

@interface LZZImmediateRefreshTableFooterView : UIView

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, copy) void (^beginRefreshingCallback)();

- (id)initWithFrame:(CGRect)frame noMoreCallback:(void (^)())noMoreCallback;

- (void)lzzRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView count:(NSInteger)count;
- (void)configNoMore:(NSInteger)count;

@end
