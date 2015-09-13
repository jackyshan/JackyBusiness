//
//  ThreeSubLabel.m
//  YSBBusiness
//
//  Created by jackyshan on 12/2/14.
//  Copyright (c) 2014 lu lucas. All rights reserved.
//

#import "ThreeSubLabel.h"

@implementation ThreeSubLabel

- (instancetype)initWithFrame:(CGRect)frame left:(NSAttributedString *)left center:(NSAttributedString *)center right:(NSAttributedString *)right
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        if (!_leftLabel) {
            _leftLabel = [[UILabel alloc] init];
        }
        
        if (!_centerLabel) {
            _centerLabel = [[UILabel alloc] init];
        }
        
        if (!_rightLabel) {
            _rightLabel = [[UILabel alloc] init];
        }
        
        _leftLabel.attributedText = left;
        _centerLabel.attributedText = center;
        _rightLabel.attributedText = right;
        
        [self addSubview:_leftLabel];
        [self addSubview:_centerLabel];
        [self addSubview:_rightLabel];
        
        [self autoFit];
    }
    
    return self;
}

- (void)autoFit
{
    CGRect rect = self.frame;
    int buttonWidth = ceilf(CGRectGetWidth(rect)/3.0);
    int buttonHeight = ceilf(CGRectGetHeight(rect));
    CGRect buttonFrame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    _leftLabel.frame = buttonFrame;
    
    buttonFrame.origin.x = buttonWidth;
    _centerLabel.frame = buttonFrame;
    
    buttonFrame.origin.x = CGRectGetMaxX(buttonFrame);
    buttonFrame.size.width = ceilf(CGRectGetWidth(rect) - CGRectGetMinX(buttonFrame));
    _rightLabel.frame = buttonFrame;
}

@end
