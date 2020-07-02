//
//  TLAudioFilePathTool.h
//  TLRecorderKit
//
//  Created by Thomas Lau on 2019/2/21.
//  Copyright © 2019年 蔚来物联科技（深圳）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLAudioFilePathTool : NSObject

// 判断文件或文件夹是否存在

+ (BOOL)TL_judgeFileOrFolderExists:(NSString *)filePathName;


/**
 判断文件是否存在
 
 @param filePath 文件路径
 @return YES:存在 NO:不存在
 */
+ (BOOL)TL_judgeFileExists:(NSString *)filePath;

/**
 类方法创建文件夹目录

 @param folderName 文件夹的名字
 @return 返回一个路径
 */
+ (NSString *)TL_createFolder:(NSString *)folderName;

@end

NS_ASSUME_NONNULL_END
