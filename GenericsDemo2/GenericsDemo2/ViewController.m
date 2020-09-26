//
//  ViewController.m
//  GenericsDemo2
//
//  Created by Thomas Lau on 2020/9/26.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "MBCollection.h"
#import "Mall.h"

// 协议
@protocol Vegetables <NSObject>
@required
- (void)func;
@end

// 类
@class Meats;
@protocol Meats <NSObject>
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不指定泛型类型的情况下，不同类型的泛型可以相互转化。
    MBCollection *collection;
    MBCollection <NSString *> *string_collection;
    MBCollection <NSMutableString *> *mString_collection;
    
    collection = string_collection;
    string_collection = collection;
    collection = mString_collection;
    
    // 声明泛型元素时加__kindof 表示其中的类为该类或其子类。
    NSMutableString *str = string_collection.elements.firstObject;
    NSLog(@"%@", str);
    
    
    //
    MBCollection *collection1 = [[MBCollection alloc] init];
    [collection1 addObject:@333];
    [collection1 insertOBject:@111 atIndex:3];
    NSLog(@"%@", collection1.elements);
    
    
    //
    Mall<Meats *> *mall = [Mall new];
    Mall<id<Vegetables>> *mall2 = [Mall new];
}

@end
