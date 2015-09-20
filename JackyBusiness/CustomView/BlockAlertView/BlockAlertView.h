//
//  BlockAlertView.h
//  YSBBusiness
//
//  Created by jackyshan on 15/7/28.
//  Copyright (c) 2015年 lu lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AlertStyle) {
    AlertStyleDefault,
    AlertStyleSheet
};

typedef void (^AlertBlock)(id result);

@class BlockAlertModel;
@interface BlockAlertView : NSObject

@property (nonatomic, assign) AlertStyle alertStyle;
@property (nonatomic, strong) NSString *alertTitle;
@property (nonatomic, strong) NSString *alertMessage;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, assign) id result;

- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title style:(AlertStyle)style;
- (void)addTitle:(NSString *)title block:(AlertBlock)block;
- (void)show;
- (void)showInView:(UIView *)view;
- (void)showInView:(UIView *)view result:(id)result;

@end

@interface BlockAlertModel : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) AlertBlock alertBlock;

- (instancetype)initWithTitle:(NSString *)title block:(AlertBlock)block;

@end
