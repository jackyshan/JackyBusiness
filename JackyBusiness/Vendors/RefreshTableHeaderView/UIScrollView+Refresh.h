//
//  UIScrollView+Refresh.h
//  TableViewPull
//
//  Created by lu lucas on 6/11/14.
//
//

#import <UIKit/UIKit.h>


@interface UIScrollView (Refresh)
/**
 *  添加下拉刷新的回调方法，在回调中写网络请求
 *
 *  @param callback 回调方法
 */
- (void)addHeaderWithCallback:(void (^)())callback;
/**
 *  调用此方法完成下拉刷新(废弃)
 */
- (void)endHeaderRefresh;
/**
 *  调用此方法完成下拉刷新
 */
- (void)endHeaderRefreshWithRequestCount:(NSArray *)array;
/**
 *  添加上拉加载更多
 *
 *  @param callback 回调方法
 */
- (void)addFooterWithCallback:(void (^)())callback;
/**
 *  调用此方法完成上拉加载
 */
- (void)endFooterRefresh;

/**
 *  调用此方法显示是否没有更多了
 */
- (void)endFooterNoMore:(NSInteger)pageSize arr:(NSArray *)result;

/**
 *  添加上拉加载更多
 *
 *  @param callback 回调方法
 */
- (void)addImmediateFooterWithCallback:(void (^)())callback pageSize:(NSInteger)count;

- (void)addImmediateFooterWithCallback:(void (^)())callback pageSize:(NSInteger)count noMoreCallback:(void (^)())noMoreCallback;
/**
 *  调用此方法完成上拉加载
 */
- (void)endImmediateFooterRefresh:(NSArray *)array;

- (void)resetImmediateFooterRefreshBMore;

@end
