//
//  ViewController.m
//  JPEGToBMPDemo
//
//  Created by Thomas Lau on 2020/4/30.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "ImageHelper.h"
#import "BitMap.h"

@interface ViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = (NSString*)[[NSBundle mainBundle] pathForResource:@"111" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    int width = image.size.width;
    int height = image.size.height;

    // Create a bitmap
    unsigned char *bitmap = [ImageHelper convertUIImageToBitmapRGBA8:image];

    // Create a UIImage using the bitmap
    UIImage *imageCopy = [ImageHelper convertBitmapRGBA8ToUIImage:bitmap withWidth:width withHeight:height];

    // Display the image copy on the GUI
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(60, 120, 300, 300);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.backgroundColor = UIColor.cyanColor;
    //self.imageView.image = imageCopy;
    
    [self.view addSubview:self.imageView];
    
    NSLog(@"%s", bitmap);

    BitMap *bmp = [[BitMap alloc] init];
    bmp.img = imageCopy;
    NSString *temp = NSTemporaryDirectory();
    NSString *filePath = [temp stringByAppendingPathComponent:@"3.bmp"];
    NSLog(@"%@", filePath);
    
    [NSKeyedArchiver archiveRootObject:bmp toFile:filePath];
    
    //取出归档的文件再解档
    //解档
    BitMap *bmp2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"bmp = %@,",bmp2.img);
    
    self.imageView.image = bmp2.img;
    
    // Cleanup
    free(bitmap);
}

///// 保存到沙盒
//- (void)saveImage:(UIImage*)image ToDocmentWithFileName:(NSString*)fileName{
//    //2.保存到对应的沙盒目录中，具体代码如下：
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];   // 保存文件的名称
//    CGSize size = CGSizeMake(300, 300);  //图片大小
//    UIImage* img = [self scaleToSize:image size:size];//调用图片大小截取方法
//    BOOL result = [UIImagePNGRepresentation(img) writeToFile: filePath atomically:YES]; // 保存成功会返回YES
//    if (result) {
//        NSLog(@"成功保存到沙盒");
//    }else{
//        NSLog(@"没有保存到沙盒");
//    }
//}
//
///// 保存到相册
//- (void)saveImageToAlnum: (UIImage *)image {
//
//    UIImageWriteToSavedPhotosAlbum(image,
//                                   self,
//                                   @selector(SavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),
//                                   nil);
//}
//
//- (void)SavedToPhotosAlbum: (UIImage *)p_w_picpath
//             didFinishSavingWithError:(NSError *)error
//                          contextInfo:(void *)contextInfo
//{
//    NSString *message = @"成功";
//    if (!error) {
//        message = @"成功保存到相册";
//    }else
//    {
//        message = [error description];
//    }
//    NSLog(@"message is %@",message);
//}
//
//- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
//{
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    //返回新的改变大小后的图片
//    return scaledImage;
//}


@end
