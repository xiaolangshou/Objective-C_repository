//
//  ViewController.m
//  KeyArchiveDemo
//
//  Created by Thomas Lau on 2020/4/30.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *person = [[Person alloc] init];
    person.name = @"Thomas";
    
    NSString *temp = NSTemporaryDirectory();
    NSString *filePath = [temp stringByAppendingPathComponent:@"1.data"];
    NSLog(@"%@", filePath);
    
    // 归档
    [NSKeyedArchiver archiveRootObject:person toFile:filePath];
}


@end
