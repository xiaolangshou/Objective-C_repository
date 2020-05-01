//
//  ViewController.m
//  BigNumMultiplyDemo
//
//  Created by Thomas Lau on 2020/3/30.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    char str[10000] = {0};
    scanf("%s",str);
    NSString *string = [NSString stringWithUTF8String:str];
    NSArray *strArr = [string componentsSeparatedByString:@" "];
    
    [self bigNumberMultiply2:strArr[0] num2:strArr[1]];
}


- (NSString *)bigNumberMultiply2:(NSString *)num1 num2:(NSString *)num2 {
    
    NSMutableArray *sumArray = [NSMutableArray array];
    //
    for (int i = 0; i < num1.length; i++){
        NSString *numSubstr1 = [num1 substringWithRange:NSMakeRange(i, 1)];
        
        for (int j = 0; j < num2.length; j++){
            NSString *numSubstr2 = [num2 substringWithRange:NSMakeRange(j, 1)];
            NSInteger index = i + j;

            if (sumArray.count > index) {
                NSString *indexStr = sumArray[index];
                NSString *replaStr = [NSString stringWithFormat:@"%@",@(indexStr.longLongValue + numSubstr1.longLongValue * numSubstr2.longLongValue)];
                [sumArray replaceObjectAtIndex:index withObject:replaStr];
            } else {
                NSString *replaStr = [NSString stringWithFormat:@"%@",@(numSubstr1.longLongValue * numSubstr2.longLongValue)];
                [sumArray addObject:replaStr];
            }
        }
    }
    
    //单独处理进位
    for(NSInteger k = sumArray.count - 1; k > 0; k--){
        NSString *indexStr = sumArray[k];

        if(indexStr.longLongValue > 10){
            NSString *indexStrd1 = sumArray[k-1];
            NSString *indexStr11 = [NSString stringWithFormat:@"%@",@(indexStrd1.longLongValue + indexStr.longLongValue / 10)];
            [sumArray replaceObjectAtIndex:k-1 withObject:indexStr11];
            [sumArray replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%@",@(indexStr.longLongValue % 10)]];
        }
    }
    
    // 处理数组第一个数
    if (sumArray.count) {
        NSString *indexStr = sumArray[0];
        if(indexStr.longLongValue > 10){
            NSString *indexStr11 = [NSString stringWithFormat:@"%@",@(indexStr.longLongValue / 10)];
            [sumArray insertObject:indexStr11 atIndex:0];
            if (sumArray.count > 1) {
                [sumArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@",@(indexStr.longLongValue % 10)]];
            } else {
                [sumArray addObject:[NSString stringWithFormat:@"%@",@(indexStr.longLongValue % 10)]];
            }
        }
    }
   
    NSMutableString *sumString = [NSMutableString string];
    for (NSString *str in sumArray) {
        [sumString appendString:str];
    }
    NSLog(@"%@",sumString);
    
    return sumString;
}


@end
