//
//  SectionSegmentLineView.m
//  YSBPro
//
//  Created by jackyshan on 14/12/18.
//  Copyright (c) 2014年 lu lucas. All rights reserved.
//

#import "SectionSegmentLineView.h"

@interface SectionSegmentLineView()
{
    int _titleCount;
    UIView *_moveView;
}

@end

@implementation SectionSegmentLineView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    
    if (self) {
        if (titles.count > 0) {
            _titleCount = (int)titles.count;
            self.backgroundColor = COLOR_FFFFFF;
            //topline
            UILabel *topLine = [InputHelper createLabelWithFrame:CGRectMake(0, 0, self.width, 1)
                                                              title:nil
                                                          textColor:COLOR_CLEAR
                                                            bgColor:COLOR_D2D2D2
                                                           fontSize:18.f
                                                      textAlignment:NSTextAlignmentLeft
                                                          addToView:self
                                                           bBold:NO];
            //btn
            CGFloat cx = 0, cy = topLine.buttom, cw = self.width/titles.count, ch = self.height - 1;
            for (NSString *str in titles) {
                UIButton *btn = [InputHelper createButtonWithTitle:str
                                                         textColor:COLOR_1B1B1B
                                                           bgColor:COLOR_FFFFFF
                                                       bgColorHigh:COLOR_CLEAR
                                                          fontSize:14.f
                                                            target:self
                                                            action:@selector(btnAction:)
                                                               tag:10000+[titles indexOfObject:str]
                                                         addToView:self
                                                             frame:CGRectMake(cx, cy, cw, ch)
                                                 supportAotuLayout:NO];
                [btn setTitleColor:COLOR_FE5C03 forState:UIControlStateSelected];
                
                if ([titles indexOfObject:str] != titles.count-1) {
                    cx = btn.right;
                    UILabel *line = [InputHelper createLabelWithFrame:CGRectMake(cx, ch/2-15/2, 1, 15)
                                                                title:nil
                                                            textColor:COLOR_CLEAR
                                                              bgColor:COLOR_D2D2D2
                                                             fontSize:14.f
                                                        textAlignment:NSTextAlignmentLeft
                                                            addToView:self
                                                                bBold:NO];
                    cx = line.right;
                }
            }
            UIButton *btn = (UIButton *)[self viewWithTag:10000];
            btn.selected = YES;
            
            //buttomline
            [InputHelper createLabelWithFrame:CGRectMake(0, self.height - 1, self.width, 1)
                                                              title:nil
                                                          textColor:COLOR_CLEAR
                                                            bgColor:COLOR_D2D2D2
                                                           fontSize:18.f
                                                      textAlignment:NSTextAlignmentLeft
                                                          addToView:self
                                                              bBold:NO];
            
            _moveView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 4.0f, btn.width/2, 2.0f)];
            _moveView.backgroundColor = kMainColor;
            [self addSubview:_moveView];
            _moveView.center = CGPointMake(btn.center.x, _moveView.center.y);
            
        }
    }
    
    return self;
}

- (void)btnAction:(UIButton *)sender
{
    if (sender.selected) {
        return;
    }
    
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.2f animations:^{
        _moveView.center = CGPointMake(sender.center.x, _moveView.center.y);
    }];
    
    for (int i = 10000; i< 10000+_titleCount; i++) {
        if (i == sender.tag) {
            continue;
        }
        
        UIButton *btn = (UIButton *)[self viewWithTag:i];
        btn.selected = NO;
    }
    
    if (_deledate && [_deledate respondsToSelector:@selector(changeSegmentTag:)]) {
        [_deledate changeSegmentTag:sender.tag];
    }
}

@end
