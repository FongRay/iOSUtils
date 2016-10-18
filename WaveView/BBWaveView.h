//
//  BBWaveView.h
//  iOSDemo
//
//  Created by Ray Fong on 16/10/17.
//  Copyright © 2016年 Ray Fong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBWaveView : UIView

typedef void (^BBWaveBlock)(CGFloat currentY);

@property (nonatomic, assign) CGFloat waveCurvature;

@property (nonatomic, assign) CGFloat waveSpeed;

@property (nonatomic, assign) CGFloat waveHeight;

@property (nonatomic, strong) UIColor *realWaveColor;

@property (nonatomic, strong) UIColor *maskWaveColor;

@property (nonatomic, copy) BBWaveBlock waveBlock;

- (void)setCurvature:(CGFloat)curvature
               speed:(CGFloat)speed
              height:(CGFloat)height;

- (void)setRealWaveColor:(UIColor *)realColor
           maskWaveColor:(UIColor *)maskColor;

- (void)stopWaveAnimation;

- (void)startWaveAnimation;

@end
