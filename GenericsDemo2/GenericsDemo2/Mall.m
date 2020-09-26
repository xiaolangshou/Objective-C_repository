//
//  Mall.m
//  GenericsDemo2
//
//  Created by Thomas Lau on 2020/9/26.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "Mall.h"

@interface Mall()

@property (nonatomic, strong) NSMutableArray<id> *stock;

@end

@implementation Mall

- (instancetype)init {
    self = [super init];
    if (self) {
        _stock = [NSMutableArray array];
    }
    
    return self;
}

- (void)buy:(id)product {
    
    [_stock addObject:product];
    NSLog(@"buy");
    NSLog(@"stock: %@", _stock);
}

- (id)sell {
    
    id res = _stock.lastObject;
    [_stock removeLastObject];
    NSLog(@"sell");
    NSLog(@"stock: %@", _stock);
    
    return res;
}

@end
