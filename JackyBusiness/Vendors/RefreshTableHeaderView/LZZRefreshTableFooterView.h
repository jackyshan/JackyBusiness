//
//  LZZRefreshTableFooterView.h
//  YSBBusiness
//
//  Created by lu lucas on 24/11/14.
//  Copyright (c) 2014 lu lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
    LZZPullRefreshPulling = 0,
    LZZPullRefreshNormal,
    LZZPullRefreshLoading,
    LZZPullRefreshNoMore,
}   LZZPullRefreshState;

@protocol LZZRefreshTableFooterViewDelegate;

@interface LZZRefreshTableFooterView : UIView

{
    __weak id<LZZRefreshTableFooterViewDelegate> _delegate;
    LZZPullRefreshState _state;
    
    UILabel *_lastUpdatedLabel;
    UILabel *_statusLabel;
    CALayer *_arrowImage;
    UIActivityIndicatorView *_activityView;
    
    
}

@property(nonatomic,weak) id <LZZRefreshTableFooterViewDelegate> delegate;
@property (nonatomic, copy) void (^beginRefreshingCallback)();

- (void)refreshLastUpdatedDate;
- (void)lzzRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)lzzRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)lzzRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

- (void)endLoadingScroll;
- (void)setLoadingScroll;

@end

@protocol LZZRefreshTableFooterViewDelegate <NSObject>
- (void)lzzRefreshTableFooterDidTriggerRefresh:(LZZRefreshTableFooterView *)view;
- (BOOL)lzzRefreshTableFooterDataSourceIsLoading:(LZZRefreshTableFooterView *)view;
@optional
- (NSDate*)lzzRefreshTableFooterDataSourceLastUpdated:(LZZRefreshTableFooterView *)view;
@end

