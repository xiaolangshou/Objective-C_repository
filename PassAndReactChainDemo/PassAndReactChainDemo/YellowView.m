//
//  YellowView.m
//  PassAndReactChainDemo
//
//  Created by Liu Tao on 2020/2/23.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "YellowView.h"

@implementation YellowView

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    NSLog(@"yellow view hit test...");
//    return [super hitTest:point withEvent:event];
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    NSLog(@"yellow view touches began...");
//    [super touchesBegan:touches withEvent:event];
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.yellowColor;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.yellowColor;
    }
    return self;
}
@end
