//
//  LZZImmediateRefreshTableFooterView.m
//  YSBBusiness
//
//  Created by lu lucas on 17/4/15.
//  Copyright (c) 2015 lu lucas. All rights reserved.
//

#import "LZZImmediateRefreshTableFooterView.h"
#define TEXT_COLOR	 [UIColor colorWithRed:31.0/255.0 green:31.0/255.0 blue:31.0/255.0 alpha:1.0]

#define kContentOffsetY (scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height)


@interface LZZImmediateRefreshTableFooterView ()

{
    BOOL _reloading;
    
    BOOL _bNoMore;
    
    RefreshImmediateFooterType _type;
    
    LZZImmediatePullRefreshState _state;
    
    UIScrollView *_scrollView;
    
    UILabel *_statusLabel;
    UIActivityIndicatorView *_activityView;
    
    void (^_noMoreCallback)() ;
}

@end

@implementation LZZImmediateRefreshTableFooterView


- (id)initWithFrame:(CGRect)frame noMoreCallback:(void (^)())noMoreCallback
{
    if (self = [super initWithFrame:frame]) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = COLOR_B3;
        
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.center = CGPointMake(127.0f, 25.0f);
        [self addSubview:view];
        _activityView = view;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view.frame) + 16.0f, 18.0f, CGRectGetWidth(frame), 20.0f)];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = COLOR_T2;
        label.backgroundColor = COLOR_CLEAR;
        label.textAlignment = NSTextAlignmentLeft;
        label.userInteractionEnabled = YES;
        [self addSubview:label];
        _statusLabel=label;
        
        if (noMoreCallback != nil) {
            _type = RefreshImmediateFooterTypeButtom;
            _noMoreCallback = [noMoreCallback copy];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_click:)];
            [_statusLabel addGestureRecognizer:tap];
        }
        
        
        [self setState:LZZImmediatePullRefreshHide];
        
    }
    
    return self;
    
}


#pragma mark -
#pragma mark Setters


- (void)setState:(LZZImmediatePullRefreshState)aState{
    
    switch (aState) {
        case LZZImmediatePullRefreshHide:
        {
            _activityView.hidden = YES;
            _statusLabel.hidden = YES;
        }
            break;
        case LZZImmediatePullRefreshNoMore:
        {
            _activityView.hidden = NO;
            _statusLabel.hidden = NO;
            
            _statusLabel.text = (_type == RefreshImmediateFooterTypeButtom)?@"没有找到？去查看更多品类 >":@"没有更多了";
            _statusLabel.textAlignment = NSTextAlignmentCenter;
            _statusLabel.center = CGPointMake(self.center.x, _activityView.center.y);
            [_activityView stopAnimating];
            
            _bNoMore = YES;
        }
            
            
            break;
        case LZZImmediatePullRefreshLoading:
        {
            _activityView.hidden = NO;
            _statusLabel.hidden = NO;
            
            _statusLabel.text = @"正在加载...";
            _statusLabel.textAlignment = NSTextAlignmentLeft;
            _statusLabel.frame = CGRectMake(CGRectGetMaxX(_activityView.frame) + 16.0f, 18.0f, CGRectGetWidth(_statusLabel.frame), 20.0f);
            [_activityView startAnimating];
            
            _bNoMore = NO;
        }
            
            break;
        default:
            break;
    }
    
    _state = aState;
}

- (void)configNoMore:(NSInteger)count
{
    if (count == 0
        || count < _pageSize) {
        
        
        if (_scrollView.contentSize.height < _scrollView.frame.size.height) {
            [self setState:LZZImmediatePullRefreshHide];
        } else {
            [self setState:LZZImmediatePullRefreshNoMore];
        }
        
    } else {
        [self setState:LZZImmediatePullRefreshHide];
        _bNoMore = NO;
    }
}

- (void)_click:(UITapGestureRecognizer *)ges
{
    if (_noMoreCallback) {
        _noMoreCallback();
    }
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)lzzRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentSize.height < scrollView.frame.size.height) {
        return;
    }
    
    if (_reloading == YES
        || _bNoMore == YES) {
        
        return;
    }
    
    if (kContentOffsetY > 48.0f) {
        if (self.beginRefreshingCallback) {
            self.beginRefreshingCallback();
            [self setState:LZZImmediatePullRefreshLoading];
            _reloading = YES;
        }
    }
    
    
}

- (void)lzzRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView count:(NSInteger)count {
    
    //fix
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _reloading = NO;
        
        if (count < _pageSize) {
            if (_scrollView.contentSize.height < _scrollView.frame.size.height) {
                [self setState:LZZImmediatePullRefreshHide];
            } else {
                [self setState:LZZImmediatePullRefreshNoMore];
            }
        } else {
            [self setState:LZZImmediatePullRefreshHide];
        }
        
    });
    
}

// fix
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 不能跟用户交互就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    UIScrollView *scrollView = (UIScrollView *)object;
    if ([@"contentOffset" isEqualToString:keyPath]) {
        [self lzzRefreshScrollViewDidScroll:scrollView];
        
    } else if ([@"contentSize" isEqualToString:keyPath]) {
        [self _adjustFrameWithContentSize:scrollView];
        
    }
}

// 加了这个才使得remove的时候调用willmove，这样就能移除观察者
- (void)removeFromSuperview
{
    [super removeFromSuperview];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:@"contentOffset" context:nil];
    [self.superview removeObserver:self forKeyPath:@"contentSize" context:nil];
    
    if (newSuperview) { // 新的父控件
        [newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
        [self _adjustFrameWithContentSize:newSuperview];
    }
}

- (void)_adjustFrameWithContentSize:(UIView *)newSuperview
{
    
    _scrollView = (UIScrollView *)newSuperview;
    _scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 48.0f, 0.0f);
    
    UIScrollView *view = (UIScrollView *)newSuperview;
    // 内容的高度
    CGFloat contentHeight = view.contentSize.height;
    // 表格的高度
    CGFloat scrollHeight = view.frame.size.height;
    // 设置位置和尺寸
    CGFloat y = MAX(contentHeight, scrollHeight);
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc
{
    _activityView = nil;
    _statusLabel = nil;
}

@end
