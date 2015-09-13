//
//  CustomButton.m
//  YSBBusiness
//
//  Created by lu lucas on 28/11/14.
//  Copyright (c) 2014 lu lucas. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return _imageRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return _titleRect;
}

@end
