//
//  SectionSegmentLineView.h
//  YSBPro
//  tableview的section分割线
//  Created by jackyshan on 14/12/18.
//  Copyright (c) 2014年 lu lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionSegmentLineViewDelegate <NSObject>

- (void)changeSegmentTag:(NSInteger)tag;

@end


@interface SectionSegmentLineView : UIView

@property (nonatomic, weak) id<SectionSegmentLineViewDelegate> deledate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

- (void)btnAction:(UIButton *)sender;

@end
