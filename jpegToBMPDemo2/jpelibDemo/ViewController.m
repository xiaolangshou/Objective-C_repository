//
//  ViewController.m
//  jpelibDemo
//
//  Created by GangLing Wei on 2020/5/5.
//  Copyright © 2020 GangLing Wei. All rights reserved.
//

#import "ViewController.h"
#import "TZImagePickerController.h"
#import "aaaa.h"
#import "test.h"


#ifdef DEBUG
#define NSLog(format,...) printf("\n[%s] %s [第%d行] %s\n",__TIME__,__FUNCTION__,__LINE__,[[NSString stringWithFormat:format,## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

@interface ViewController ()<TZImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self aaaaa];
    });
}


- (void)aaaaa
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.cropRect = CGRectMake(self.view.center.x - 40, self.view.center.y - 80, 200, 200);
    [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos,
                                                              NSArray *assets,
                                                              BOOL isSelectOriginalPhoto,
                                                              NSArray<NSDictionary *> *infos)
    {
        UIImage *image = photos[0];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        NSString *jpgPath = GetDocumentPathWithFile(@"111.jpg");
        [data writeToFile:jpgPath atomically:YES];
        
        NSString *path2 = GetDocumentPathWithFile(@"test.bmp");
        char *char1 = (char *)[jpgPath UTF8String];
        char *chat2 = (char *)[path2 UTF8String];
        start(char1, chat2);// 将jpg 转 24位bmp
        
        NSString *path3 = GetDocumentPathWithFile(@"8Bmp.bmp");
        char *chat3 = (char *)[path3 UTF8String];
        RgbToGray(chat2, chat3);// 将24位bmp转8位bmp
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:
                                  [UIImage imageWithData:
                                   [NSData dataWithContentsOfFile:path2]]];
        imageView.frame = CGRectMake(0, 0, 200, 200);
        imageView.center = CGPointMake(200, self.view.center.y - 150);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imageView];
        
        UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:path3]]];
        imageView2.frame = CGRectMake(0, 0, 200, 200);
        imageView2.center = CGPointMake(200, self.view.center.y + 150);
        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imageView2];
    }];
    
    [self presentViewController: imagePickerVc animated: YES completion: nil];// 跳转
}

- (void)bbbbb
{
    NSString *path2 = GetDocumentPathWithFile(@"test.bmp");
    NSString *path3 = GetDocumentPathWithFile(@"8Bmp.bmp");
    char *chat2 = (char *)[path2 UTF8String];
    char *chat3 = (char *)[path3 UTF8String];
    RgbToGray(chat2, chat3);
}


NSString *GetDocumentPathWithFile(NSString *file)
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if (file) {
        return [path stringByAppendingPathComponent:file];
    }
    
    return path;
}

@end
