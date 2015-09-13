
/*--------------------------------------------
 *Name：ThreeSubView.m
 *Desc：自定义三个button实现
 *Date：2014/06/03
 *Auth：shanhq
 *--------------------------------------------*/

#if !__has_feature(objc_arc)
#error no "objc_arc" compiler flag
#endif

#import "ThreeSubView.h"

@interface ThreeSubView ()

@property (nonatomic, copy) ButtonSelectBlock leftBlock;
@property (nonatomic, copy) ButtonSelectBlock centerBlock;
@property (nonatomic, copy) ButtonSelectBlock rightBlock;

@end

@implementation ThreeSubView

- (id)initWithFrame:(CGRect)frame leftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLeftButtonSelectBlock:leftButtonSelectBlock centerButtonSelectBlock:centerButtonSelectBlock rightButtonSelectBlock:rightButtonSelectBlock];
    }
    return self;
}

- (void)setLeftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock
{
    self.leftBlock = leftButtonSelectBlock;
    self.centerBlock = centerButtonSelectBlock;
    self.rightBlock = rightButtonSelectBlock;
    
    if (!self.leftButton) {
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.centerButton) {
        self.centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.rightButton) {
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.leftBlock) {
        self.leftButton.userInteractionEnabled = NO;
    }
    
    if (!self.centerBlock) {
        self.centerButton.userInteractionEnabled = NO;
    }
    
    if (!self.rightBlock) {
        self.rightButton.userInteractionEnabled = NO;
    }
    
    [self.leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerButton addTarget:self action:@selector(centerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.leftButton];
    [self addSubview:self.centerButton];
    [self addSubview:self.rightButton];
}

- (void)leftAction:(UIButton *)button
{
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)centerAction:(UIButton *)button
{
    if (self.centerBlock) {
        self.centerBlock();
    }
}

- (void)rightAction:(UIButton *)button
{
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (void)autoFit
{
    CGRect rect = self.frame;
    int buttonWidth = ceilf(CGRectGetWidth(rect)/3.0);
    int buttonHeight = ceilf(CGRectGetHeight(rect));
    CGRect buttonFrame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    self.leftButton.frame = buttonFrame;
    
    buttonFrame.origin.x = buttonWidth;
    self.centerButton.frame = buttonFrame;
    
    buttonFrame.origin.x = CGRectGetMaxX(buttonFrame);
    buttonFrame.size.width = ceilf(CGRectGetWidth(rect) - CGRectGetMinX(buttonFrame));
    self.rightButton.frame = buttonFrame;
}

@end
