//
//  ViewController.m
//  UDPSocketDemo
//
//  Created by Thomas Lau on 2020/3/23.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncUdpSocket.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) GCDAsyncUdpSocket *udpClient;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupView {
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, 100, 50)];
    _btn.backgroundColor = UIColor.redColor;
    [_btn addTarget:self action:@selector(btnTapped) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (void)btnTapped {
    _udpClient = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:<#(nullable dispatch_queue_t)#>]
}

@end
