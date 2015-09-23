//
//  UIScrollView+Refresh.m
//  TableViewPull
//
//  Created by lu lucas on 6/11/14.
//
//

#import "UIScrollView+Refresh.h"
#import "EGORefreshTableHeaderView.h"
#import <objc/runtime.h>
#import "LZZRefreshTableFooterView.h"
#import "LZZImmediateRefreshTableFooterView.h"

@interface UIScrollView ()

@end

@implementation UIScrollView (Refresh)

static char LZZRefreshHeaderViewKey;
static char LZZRefreshFooterViewKey;
static char LZZImmediateRefreshFooterViewKey;

- (void)setHeader:(EGORefreshTableHeaderView *)header
{
    [self willChangeValueForKey:@"LZZRefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &LZZRefreshHeaderViewKey,
                             header,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"LZZRefreshHeaderViewKey"];
}

- (void)setFooter:(LZZRefreshTableFooterView *)footer
{
    [self willChangeValueForKey:@"LZZRefreshFooterViewKey"];
    objc_setAssociatedObject(self, &LZZRefreshFooterViewKey,
                             footer,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"LZZRefreshFooterViewKey"];
}

- (void)setImmediateFooter:(LZZImmediateRefreshTableFooterView *)footer
{
    [self willChangeValueForKey:@"LZZImmediateRefreshFooterViewKey"];
    objc_setAssociatedObject(self, &LZZImmediateRefreshFooterViewKey,
                             footer,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"LZZImmediateRefreshFooterViewKey"];
}

- (EGORefreshTableHeaderView *)header
{
    return objc_getAssociatedObject(self, &LZZRefreshHeaderViewKey);
}

- (LZZRefreshTableFooterView *)footer
{
    return objc_getAssociatedObject(self, &LZZRefreshFooterViewKey);
}

- (LZZImmediateRefreshTableFooterView *)immediateFooter
{
    return objc_getAssociatedObject(self, &LZZImmediateRefreshFooterViewKey);
}


- (void)addHeaderWithCallback:(void (^)())callback
{
    // 1.创建新的header
    if (!self.header) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        [self addSubview:view];
        [self setHeader:view];
        [view refreshLastUpdatedDate];
    }
    
    // 2.设置block回调
    self.header.beginRefreshingCallback = callback;
}

- (void)endHeaderRefresh
{
    [self.header egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

- (void)addFooterWithCallback:(void (^)())callback
{
    
    if (!self.footer) {
        //LZZRefreshTableFooterView *view = [[LZZRefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f, self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        LZZRefreshTableFooterView *view = [[LZZRefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f, self.bounds.size.height , self.frame.size.width, self.bounds.size.height)];
        [self addSubview:view];
        [self setFooter:view];
        [view refreshLastUpdatedDate];
    }
    
    // 2.设置block回调
    self.footer.beginRefreshingCallback = callback;
}

- (void)endFooterRefresh
{
    
    [self.footer lzzRefreshScrollViewDataSourceDidFinishedLoading:self];
}

- (void)endFooterNoMore:(NSInteger)pageSize arr:(NSArray *)result {
    if (!result || pageSize > result.count) {
        [self.footer endLoadingScroll];
    }
    else {
        [self.footer setLoadingScroll];
    }
}

- (void)addImmediateFooterWithCallback:(void (^)())callback pageSize:(NSInteger)count
{
    
    [self addImmediateFooterWithCallback:callback pageSize:count noMoreCallback:nil];
}

- (void)addImmediateFooterWithCallback:(void (^)())callback pageSize:(NSInteger)count noMoreCallback:(void (^)())noMoreCallback
{
    if (!self.immediateFooter) {
        LZZImmediateRefreshTableFooterView *view = [[LZZImmediateRefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f, self.bounds.size.height , self.frame.size.width, self.bounds.size.height) noMoreCallback:noMoreCallback];
        [self addSubview:view];
        [self setImmediateFooter:view];
        view.pageSize = count;
    }
    
    // 2.设置block回调
    self.immediateFooter.beginRefreshingCallback = callback;
}

- (void)endImmediateFooterRefresh:(NSArray *)array
{
    if ([array respondsToSelector:@selector(count)]) {
        [self.immediateFooter lzzRefreshScrollViewDataSourceDidFinishedLoading:self count:array.count];
    } else {
        [self.immediateFooter lzzRefreshScrollViewDataSourceDidFinishedLoading:self count:0];
    }
    
}



- (void)endHeaderRefreshWithRequestCount:(NSArray *)array
{
    [self.header egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    if ([array respondsToSelector:@selector(count)]) {
        [self.immediateFooter configNoMore:array.count];
    } else {
        [self.immediateFooter configNoMore:0];
    }
    
    
}

- (void)resetImmediateFooterRefreshBMore
{
    [self.immediateFooter configNoMore:self.immediateFooter.pageSize];
    
}

@end
