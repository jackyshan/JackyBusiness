
/*--------------------------------------------
 *Name：ThreeSubView.h
 *Desc：自定义三个button
 *Date：2014/06/03
 *Auth：shanhq
 *--------------------------------------------*/

#import <UIKit/UIKit.h>

typedef void(^ButtonSelectBlock)(void);

@interface ThreeSubView : UIView

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIButton *rightButton;

- (id)initWithFrame:(CGRect)frame leftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock;

- (void)setLeftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock;

- (void)autoFit;

@end