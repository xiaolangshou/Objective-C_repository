//
//  son.m
//  TabBarVC2
//
//  Created by Liu Tao on 2020/2/20.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "son.h"

@interface son ()

+ (void)foo;

@property (nonatomic, copy) NSString *name;

@end

@implementation son

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id cls = [son class];
    void *obj = &cls;
    [(__bridge id)obj speak];
}

- (void)speak {
    NSLog(@"my name's %@", self.name);
}

- (void)foo {
    NSLog(@"IMP: [...]");
}

- (id)init {
 self = [super init];
    
    if (self) {
        /* - (Class)class {
            return object_getClass(self);
         
         由于当前类和父类都没有定义class方法，所以系统会自动追溯到根类NSObject中，其class定义如上
         */
        
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
        NSLog(@"----");
        
        BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]]; // y
        BOOL res2 = [(id)[son class] isKindOfClass:[NSObject class]]; // y
        BOOL res3 = [(id)[NSObject class] isMemberOfClass:[NSObject class]]; // n
        BOOL res4 = [(id)[son class] isKindOfClass:[son class]]; // n
        BOOL res5 = [(id)[son class] isMemberOfClass:[son class]]; // n
        
        NSLog(@"%@", [NSObject class]);
        NSLog(@"%@", [son class]);
        NSLog(@"----");
        NSLog(@"%s", res1 == YES ? "YES" : "NO");
        NSLog(@"%s", res2 == YES ? "YES" : "NO");
        NSLog(@"%s", res3 == YES ? "YES" : "NO");
        NSLog(@"%s", res4 == YES ? "YES" : "NO");
        NSLog(@"%s", res5 == YES ? "YES" : "NO");
        NSLog(@"----");
        
        
        
//        [son foo];
//        [[son new] foo];
    }
    return self;
}

@end
