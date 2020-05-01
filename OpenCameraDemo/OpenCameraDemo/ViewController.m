//
//  ViewController.m
//  OpenCameraDemo
//
//  Created by Thomas Lau on 2020/5/1.
//  Copyright © 2020 TLLTD. All rights reserved.
//
#define width UIScreen.mainScreen.bounds.size.width
#define height UIScreen.mainScreen.bounds.size.height

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) UIButton *camBtn;
@property (strong, nonatomic) UIButton *albumBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
}

- (void)setupView {
    
    // 相册
    self.albumBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/2 - 50, 400, 100, 40)];
    self.albumBtn.backgroundColor = UIColor.systemBlueColor;
    [self.albumBtn setTitle:@"album" forState:UIControlStateNormal];
    [self.albumBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.view addSubview:self.albumBtn];
    [self.albumBtn addTarget:self action:@selector(albumBtnTapped)
            forControlEvents:UIControlEventTouchUpInside];
    
    // 相机
    self.camBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/2 - 50, 500, 100, 40)];
    self.camBtn.backgroundColor = UIColor.systemBlueColor;
    [self.camBtn setTitle:@"camera" forState:UIControlStateNormal];
    [self.camBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.view addSubview:self.camBtn];
    [self.camBtn addTarget:self action:@selector(camBtnTapped)
            forControlEvents:UIControlEventTouchUpInside];
    
    
    if (!self.picker) {
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.allowsEditing = YES;
    }
}

- (void)camBtnTapped {
    NSLog(@"%s", __func__);
    
    BOOL isPicker = NO;
    // 打开相机
    isPicker = true;
    // 判断相机是否可用
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        isPicker = true;
    }
    
    [self presentPicker: isPicker];
}

- (void)albumBtnTapped {
    NSLog(@"%s", __func__);
    
    BOOL isPicker = NO;
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    isPicker = true;
    
    [self presentPicker: isPicker];
}

- (void)presentPicker: (BOOL)isPick
{
    if (isPick) {
        [self presentViewController:self.picker animated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"错误"
                                                                       message: @"相机不可用"
                                                                preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle: @"确定"
                                                         style: UIAlertActionStyleCancel
                                                       handler: nil];
        [alert addAction: action];
        
        [self presentViewController: alert animated:YES completion:nil];
    }
}


#pragma mark

// 获取图片后
- (void)imagePickerController: (UIImagePickerController *)picker
didFinishPickingMediaWithInfo: (NSDictionary<NSString *, id> *)info
{
    [picker dismissViewControllerAnimated: YES completion: nil];
}

// 按取消按钮时
- (void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated: YES completion: nil];
}

@end
