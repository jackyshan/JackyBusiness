//
//  DashLineVerView.m
//  YSBBusiness
//
//  Created by jackyshan on 15/2/26.
//  Copyright (c) 2015年 lu lucas. All rights reserved.
//

#import "DashLineVerView.h"

@implementation DashLineVerView

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
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGFloat lengths[] = {5,2};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, self.frame.size.height);
    CGContextStrokePath(context);
}

@end
