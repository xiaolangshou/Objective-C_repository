//
//  ColorView.h
//  DelegateDemo
//
//  Created by Thomas Lau on 2020/3/9.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TLProtocol <NSObject>

- (void)changeColor: (UIColor *)color;

@end

@interface ColorView : UIView

@property (weak, nonatomic) id<TLProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
