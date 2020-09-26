//
//  MBCollection.m
//  GenericsDemo2
//
//  Created by Thomas Lau on 2020/9/26.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "MBCollection.h"

@implementation MBCollection

- (void)addObject:(id)object {
    
    NSLog(@"addObject");
    [self.elements addObject:object];
}

- (BOOL)insertOBject:(id)object atIndex:(NSInteger)index {
    
    NSLog(@"insertOBject");
    [self.elements insertObject:object atIndex:index];
    
    return YES;
}

@end
