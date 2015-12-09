//
//  BlockAlertView.m
//  YSBBusiness
//
//  Created by jackyshan on 15/7/28.
//  Copyright (c) 2015年 lu lucas. All rights reserved.
//

#import "BlockAlertView.h"

@interface BlockAlertView()<UIActionSheetDelegate, UIAlertViewDelegate>

@end

@implementation BlockAlertView

- (instancetype)init {
    if (self = [super init]) {
        _models = [NSMutableArray array];
        _alertStyle = AlertStyleDefault;
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    if ([self init]) {
        _alertTitle = title;
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title style:(AlertStyle)style {
    if ([self init]) {
        _alertTitle = title;
        _alertStyle = style;
    }
    
    return self;
}

- (void)addTitle:(NSString *)title block:(AlertBlock)block {
    BlockAlertModel *model = [[BlockAlertModel alloc] initWithTitle:title block:block];
    [_models addObject:model];
}

- (void)show {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    
    [self showInView:view];
}

- (void)showInView:(UIView *)view {
    [self showInView:view result:nil];
}

- (void)showInView:(UIView *)view result:(id)result {
    _result = result;
    
    if (_alertStyle == AlertStyleSheet) {
        UIActionSheet *sheet = [[UIActionSheet alloc] init];
        sheet.title = _alertTitle;
        sheet.delegate = self;
        BlockAlertModel *cancel = [[BlockAlertModel alloc] initWithTitle:@"取消" block:nil];
        [_models addObject:cancel];
        [_models enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BlockAlertModel *model = obj;
            model.index = [sheet addButtonWithTitle:model.title];
        }];
        sheet.cancelButtonIndex = _models.count-1;
        [sheet showInView:view];
        
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = _alertTitle;
    alert.message = _alertMessage;
    alert.delegate = self;
    [_models enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BlockAlertModel *model = obj;
        model.index = [alert addButtonWithTitle:model.title];
    }];
    [alert show];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self clickActionBlock:buttonIndex];
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
}

#pragma mark - UIAlertViewDelegate 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self clickActionBlock:buttonIndex];
}

- (void)alertViewCancel:(UIAlertView *)alertView {
}


// block action
- (void)clickActionBlock:(NSInteger)buttonIndex {
    [_models enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BlockAlertModel *model = obj;
        
        if (model.index == buttonIndex) {
            if (model.alertBlock) {
                model.alertBlock(_result?_result:model.title);
            }
            *stop = YES;
        }
    }];
    
    [_models removeLastObject];
}

- (void)dealloc {
    NSLog(@"block view dealloc");
}

@end

@implementation BlockAlertModel

- (instancetype)initWithTitle:(NSString *)title block:(AlertBlock)block {
    if (self = [super init]) {
        self.title = title;
        self.alertBlock = block;
    }
    
    return self;
}

@end