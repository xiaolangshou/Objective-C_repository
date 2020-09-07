//
//  ViewController.m
//  RuntimeDemo3_NSCoding
//
//  Created by Thomas Lau on 2020/9/7.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import <Objc/runtime.h>

@interface ViewController ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *job;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (id)initWithCoder:(NSCoder *)coder {
    
    if (self = [super initWithCoder:coder]) {
        unsigned int outCount;
        
        Ivar * ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i ++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[coder decodeObjectForKey:key] forKey:key];
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    
    unsigned int outCount;
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar * ivar = &ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(*ivar)];
        [coder encodeObject:[self valueForKey:key] forKey:key];
    }
}


@end
