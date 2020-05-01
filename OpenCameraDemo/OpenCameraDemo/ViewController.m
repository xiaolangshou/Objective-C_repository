//
//  ViewController.m
//  OpenCameraDemo
//
//  Created by Thomas Lau on 2020/5/1.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *camBtn;
@property (strong, nonatomic) UIButton *albumBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 300, 300)];
    self.imageView.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:self.imageView];
    
    self.albumBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, 60, 30)];
    self.albumBtn.backgroundColor = UIColor.greenColor;
    [self.albumBtn setTitle:@"album" forState:UIControlStateNormal];
    [self.albumBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.view addSubview:self.albumBtn];
    [self.albumBtn addTarget:self action:@selector(albumBtnTapped)
            forControlEvents:UIControlEventTouchUpInside];
    
    self.camBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, 400, 60, 30)];
    self.camBtn.backgroundColor = UIColor.greenColor;
    [self.camBtn setTitle:@"camera" forState:UIControlStateNormal];
    [self.camBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.view addSubview:self.camBtn];
    [self.camBtn addTarget:self action:@selector(camBtnTapped)
            forControlEvents:UIControlEventTouchUpInside];
    
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
}

- (UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
    }
    return _picker;
}

#pragma mark

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    // 获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // 返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)camBtnTapped {
    NSLog(@"%s", __func__);
    
    BOOL isPicker = NO;
    // 打开相机
    isPicker = true;
    // 判断相机是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        isPicker = true;
    }
    
    [self presentPicker:isPicker];
}

- (void)albumBtnTapped {
    NSLog(@"%s", __func__);
    
    BOOL isPicker = NO;
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    isPicker = true;
    
    [self presentPicker:isPicker];
}

- (void)presentPicker: (BOOL)isPick
{
    if (isPick) {
        [self presentViewController:self.picker animated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"相机不可用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
