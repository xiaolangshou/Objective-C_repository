//
//  CyanView.m
//  PassAndReactChainDemo
//
//  Created by Liu Tao on 2020/2/23.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "CyanView.h"

@implementation CyanView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    NSLog(@"cyan view hit test...");
    return [super hitTest:point withEvent:event];
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(200.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(200.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds,
                         -0.5 * widthDelta,
                         -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"cyan view touches began...");
    [super touchesBegan:touches withEvent:event];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.cyanColor;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.cyanColor;
    }
    return self;
}
@end
