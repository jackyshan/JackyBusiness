//
//  LZZRefreshTableFooterView.m
//  YSBBusiness
//
//  Created by lu lucas on 24/11/14.
//  Copyright (c) 2014 lu lucas. All rights reserved.
//

#import "LZZRefreshTableFooterView.h"

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f

#define kContentOffsetY (scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height)


@interface LZZRefreshTableFooterView ()

{
    BOOL _reloading;
}
- (void)setState:(LZZPullRefreshState)aState;
@end

@implementation LZZRefreshTableFooterView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = TEXT_COLOR;
        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _lastUpdatedLabel=label;
        //		[label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 38.0f, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont boldSystemFontOfSize:13.0f];
        label.textColor = TEXT_COLOR;
        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _statusLabel=label;
        //		[label release];
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(25.0f, 65.0f, 30.0f, 55.0f);
        
        layer.contentsGravity = kCAGravityResizeAspect;
        // TODO:图片
        layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            layer.contentsScale = [[UIScreen mainScreen] scale];
        }
#endif
        
        [[self layer] addSublayer:layer];
        _arrowImage=layer;
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(25.0f, 38.0f, 20.0f, 20.0f);
        [self addSubview:view];
        _activityView = view;
        //		[view release];
        
        
        [self setState:LZZPullRefreshNormal];
        
        //箭头和activity居中，隐藏_status和_last
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        layer.frame = CGRectMake((width-55)/2, 20.0f, 30.0f, 55.0f);
        view.frame = CGRectMake((width-20)/2, 20.0f, 20.0f, 20.0f);
        _statusLabel.hidden = YES;
        _lastUpdatedLabel.hidden = YES;
    }
    
    return self;
    
}


#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
    
    if ([_delegate respondsToSelector:@selector(lzzRefreshTableFooterDataSourceLastUpdated:)]) {
        
        NSDate *date = [_delegate lzzRefreshTableFooterDataSourceLastUpdated:self];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setAMSymbol:@"AM"];
        [formatter setPMSymbol:@"PM"];
        [formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [formatter stringFromDate:date]];
        [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //		[formatter release];
        formatter = nil;
        
    } else {
        
        _lastUpdatedLabel.text = nil;
        
    }
    
}

- (void)setState:(LZZPullRefreshState)aState{
    if (_state == LZZPullRefreshNoMore) {
        return;
    }
    
    switch (aState) {
        case LZZPullRefreshPulling:
            
            _statusLabel.text = NSLocalizedString(@"松开开始加载", @"Release to refresh status");
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
            
            break;
        case LZZPullRefreshNormal:
            
            if (_state == LZZPullRefreshPulling) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
                _arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
            }
            
            _statusLabel.text = NSLocalizedString(@"上拉加载更多", @"Pull down to refresh status");
            [_activityView stopAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = NO;
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
            
            [self refreshLastUpdatedDate];
            
            break;
        case LZZPullRefreshLoading:
            
            _statusLabel.text = NSLocalizedString(@"努力加载中...", @"Loading Status");
            [_activityView startAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = YES;
            [CATransaction commit];
            
            break;
        case LZZPullRefreshNoMore:
            _statusLabel.text = NSLocalizedString(@"No More ...", @"Loading Status");
            [_activityView stopAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = YES;
            [CATransaction commit];
            
            break;
        default:
            break;
    }
    
    _state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)lzzRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_state == LZZPullRefreshLoading) {
        
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
        
    } else if (scrollView.isDragging) {
        
        BOOL _loading = NO;
        if ([_delegate respondsToSelector:@selector(lzzRefreshTableFooterDataSourceIsLoading:)]) {
            _loading = [_delegate lzzRefreshTableFooterDataSourceIsLoading:self];
        }
        // fix
        _loading = _reloading;
        
        if (_state == LZZPullRefreshPulling && kContentOffsetY < 65.0f && kContentOffsetY > 0.0f && !_loading) {
            [self setState:LZZPullRefreshNormal];
        } else if (_state == LZZPullRefreshNormal && kContentOffsetY > 65.0f && !_loading) {
            [self setState:LZZPullRefreshPulling];
        }
        
        if (scrollView.contentInset.bottom != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
        
    }
    
}

- (void)lzzRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
    BOOL _loading = NO;
    if ([_delegate respondsToSelector:@selector(lzzRefreshTableFooterDataSourceIsLoading:)]) {
        _loading = [_delegate lzzRefreshTableFooterDataSourceIsLoading:self];
    }
    // fix
    _loading = _reloading;
    
    if (kContentOffsetY >= 65.0f
        && !_loading
        // 内容不超过高度的话，也就不需要上拉加载更多了，不做这个判断的时候，设置tableheaderview时，会产生符合前面的判断，导致进入if里面的问题
        && scrollView.contentSize.height > scrollView.frame.size.height) {
        
        NSLog(@"%f %f %f", scrollView.contentOffset.y, scrollView.frame.size.height, scrollView.contentSize.height);
        
        if ([_delegate respondsToSelector:@selector(lzzRefreshTableFooterDidTriggerRefresh:)]) {
            [_delegate lzzRefreshTableFooterDidTriggerRefresh:self];
        }
        if (self.beginRefreshingCallback) {
            self.beginRefreshingCallback();
            _reloading = YES;
        }
        
        [self setState:LZZPullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 60.0f, 0.0f);
        [UIView commitAnimations];
        
    }
    
}

- (void)lzzRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    
    //fix
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _reloading = NO;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.3];
        [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        [UIView commitAnimations];
        
        [self setState:LZZPullRefreshNormal];
    });
    
}

- (void)endLoadingScroll {
    _statusLabel.hidden = NO;
    [self setState:LZZPullRefreshNoMore];
}

- (void)setLoadingScroll {
    _state = LZZPullRefreshNormal;
    _statusLabel.hidden = YES;
}

// fix
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 不能跟用户交互就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    UIScrollView *scrollView = (UIScrollView *)object;
    if ([@"contentOffset" isEqualToString:keyPath]) {
        if (_state == LZZPullRefreshNoMore) {
        return;
        }
        
        if (scrollView.isDragging) {
            [self lzzRefreshScrollViewDidScroll:scrollView];
        } else {
            [self lzzRefreshScrollViewDidEndDragging:scrollView];
        }
        
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

- (void)dealloc {
    
    _delegate=nil;
    _activityView = nil;
    _statusLabel = nil;
    _arrowImage = nil;
    _lastUpdatedLabel = nil;
    //    [super dealloc];
}


@end
