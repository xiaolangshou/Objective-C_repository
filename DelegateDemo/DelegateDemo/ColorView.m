//
//  ColorView.m
//  DelegateDemo
//
//  Created by Thomas Lau on 2020/3/9.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ColorView.h"

@implementation ColorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    // 方法一
    [NSThread detachNewThreadWithBlock:^{
        [NSThread sleepForTimeInterval:3.0];
        [self performSelectorOnMainThread:@selector(changeViewColor) withObject:nil waitUntilDone:true];
    }];
}

- (void)changeViewColor {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeColor:)]) {
        [self.delegate changeColor:UIColor.redColor];
    }
}

// 方法二
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeColor:)]) {
        [self.delegate changeColor:UIColor.redColor];
    }
}

@end
