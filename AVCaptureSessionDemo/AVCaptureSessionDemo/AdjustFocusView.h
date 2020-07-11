//
//  AdjustFocusView.h
//  AVCaptureSessionDemo
//
//  Created by Thomas Lau on 2020/7/11.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdjustFocusView : UIView

@property (nonatomic, assign) CGFloat originWidth;

- (void)setFrameByAnimateWithCenter: (CGPoint)center;

@end

NS_ASSUME_NONNULL_END
