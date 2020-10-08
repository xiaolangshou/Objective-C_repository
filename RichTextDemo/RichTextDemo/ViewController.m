//
//  ViewController.m
//  RichTextDemo
//
//  Created by Thomas Lau on 2020/10/8.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *allow_textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 90, 200, 200)];
    allow_textView.editable = YES;
    allow_textView.scrollEnabled = NO;
    allow_textView.textContainerInset = UIEdgeInsetsZero;
    allow_textView.textContainer.lineFragmentPadding = 0;
    allow_textView.linkTextAttributes = @{NSForegroundColorAttributeName:UIColor.blueColor};
    allow_textView.delegate = self;
    [self.view addSubview:allow_textView];
    
    NSString *appName = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    NSString *rangeStr = [NSString stringWithFormat:@"《%@隐私政策》",appName];
    NSString *protocolStr = [NSString stringWithFormat:@"阅读并同意%@",rangeStr];
    NSRange privacyRange = [protocolStr rangeOfString:rangeStr];
    NSMutableAttributedString *privacyMutableAttrStr = [[NSMutableAttributedString alloc] initWithString:protocolStr attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:12.0],NSForegroundColorAttributeName:UIColor.cyanColor}];
    
    //给需要 点击事件的部分添加链接
    [privacyMutableAttrStr addAttribute:NSLinkAttributeName value:@"privacy://" range:privacyRange];
    allow_textView.attributedText = privacyMutableAttrStr;
}

- (BOOL)textView: (UITextView *)textView
        shouldInteractWithURL: (NSURL *)URL
        inRange:(NSRange)characterRange
{
    //这里调用方法跳到隐私政策页面
    if ([URL.scheme isEqualToString:@"privacy"]) {
        NSLog(@"%s - 隐私跳转",__func__);
        return NO;
    }
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    return NO;
}

@end
