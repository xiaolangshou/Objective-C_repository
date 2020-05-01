//
//  ViewController.m
//  RemoteCamDemo_Recieve
//
//  Created by Thomas Lau on 2020/4/18.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "DisplayViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) DisplayViewController *vc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.本 Demo 作为播放端,需要先运行 采集端开启 Socket 监听.
    // 2.然后运行本 Demo,会自动建立 Socket 连接
    // 3.接受到H264视频裸流,解码并播放
    [self setupView];
}

- (void)setupView {
    
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 80, 40)];
    [self.btn setTitle:@"显示" forState: UIControlStateNormal];
    self.btn.backgroundColor = UIColor.cyanColor;
    [self.btn addTarget:self action:@selector(btnTapped) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: self.btn];
}

- (void)btnTapped {
    
    self.vc = [[DisplayViewController alloc] init];
    [self presentViewController: self.vc animated: YES completion: nil];
}

@end
