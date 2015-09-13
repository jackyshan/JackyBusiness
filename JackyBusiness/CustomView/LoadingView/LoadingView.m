//
//  LoadingView.m
//  YSBBusiness
//
//  Created by lu lucas on 17/8/15.
//  Copyright (c) 2015 lu lucas. All rights reserved.
//

#import "LoadingView.h"
#import "Masonry.h"

@interface LoadingView ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@end

@implementation LoadingView

- (void)dealloc{
    [_maskImageView.layer removeAllAnimations];
}

- (void)defineLayout
{
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.maskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
}

- (void)addSubviews
{
    [self addSubview:self.backImageView];
    [self addSubview:self.maskImageView];
}

- (UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_back"]];
    }
    
    return _backImageView;
}

- (UIImageView *)maskImageView
{
    if (!_maskImageView) {
        _maskImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_mask"]];
        
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 0.6f;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = MAXFLOAT;
        
        [_maskImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
    
    return _maskImageView;
}


@end
