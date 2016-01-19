//
//  DashLineView.m
//  dashLine
//
//  Created by jackyshan on 15/1/16.
//  Copyright (c) 2015年 jackyshan. All rights reserved.
//

#import "DashLineView.h"

@implementation DashLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [ColorHelper colorWithHexString:@"#d2d2d2"].CGColor);
    CGFloat lengths[] = {5,2};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, 0, 0);
    
    if (_vertical) {
        CGContextAddLineToPoint(context, 0, self.frame.size.height);
    }else{
        CGContextAddLineToPoint(context, self.frame.size.width, 0);
    }
    
    CGContextStrokePath(context);
}

@end
