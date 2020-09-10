//
//  UIView+DefaultColor.m
//  RuntimeDemo1
//
//  Created by Thomas Lau on 2020/9/7.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "UIView+DefaultColor.h"

@implementation UIView (DefaultColor)

@dynamic defaultColor;

static char kDefaultColorKey;

- (void)setDefaultColor:(UIColor *)defaultColor {
    
    objc_setAssociatedObject(self, &kDefaultColorKey, defaultColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)defaultColor {
    
    return objc_getAssociatedObject(self, &kDefaultColorKey);
}


@end
