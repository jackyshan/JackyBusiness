//
//  ThreeSubLabel.h
//  YSBBusiness
//
//  Created by jackyshan on 12/2/14.
//  Copyright (c) 2014 lu lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeSubLabel : UIView

@property (nonatomic) UILabel *leftLabel;
@property (nonatomic) UILabel *centerLabel;
@property (nonatomic) UILabel *rightLabel;

- (instancetype)initWithFrame:(CGRect)frame left:(NSAttributedString *)left center:(NSAttributedString *)center right:(NSAttributedString *)right;

@end
