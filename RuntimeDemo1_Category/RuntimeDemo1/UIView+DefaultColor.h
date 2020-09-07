//
//  UIView+DefaultColor.h
//  RuntimeDemo1
//
//  Created by Thomas Lau on 2020/9/7.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DefaultColor)

@property (nonatomic, strong) UIColor *defaultColor;

@end

NS_ASSUME_NONNULL_END
