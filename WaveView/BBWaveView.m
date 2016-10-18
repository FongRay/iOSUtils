//
//  BBWaveView.m
//  iOSDemo
//
//  Created by Ray Fong on 16/10/17.
//  Copyright © 2016年 Ray Fong. All rights reserved.
//

#import "BBWaveView.h"

@interface BBWaveView ()

@property (nonatomic, strong) CADisplayLink *timer;

@property (nonatomic, strong) CAShapeLayer *realWaveLayer;

@property (nonatomic, strong) CAShapeLayer *maskWaveLayer;

@property (nonatomic, assign) CGFloat offset;

@end

@implementation BBWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initData];
    }
    return self;
}

- (void)initData {
    self.waveSpeed = 0.5;
    self.waveCurvature = 1.5;
    self.waveHeight = 6;
    self.realWaveColor = [UIColor whiteColor];
    self.maskWaveColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    
    [self.layer addSublayer:self.realWaveLayer];
    [self.layer addSublayer:self.maskWaveLayer];
}

- (CAShapeLayer *)realWaveLayer {
    if (!_realWaveLayer) {
        _realWaveLayer = [CAShapeLayer layer];
        CGRect frame = [self bounds];
        frame.origin.y = frame.size.height - _waveHeight;
        frame.size.height = _waveHeight;
        _realWaveLayer.frame = frame;
        _realWaveLayer.fillColor = _realWaveColor.CGColor;
    }
    return _realWaveLayer;
}

- (CAShapeLayer *)maskWaveLayer {
    if (!_maskWaveLayer) {
        _maskWaveLayer = [CAShapeLayer layer];
        CGRect frame = [self bounds];
        frame.origin.y = frame.size.height - _waveHeight;
        frame.size.height = _waveHeight;
        _maskWaveLayer.frame = frame;
        _maskWaveLayer.fillColor = _maskWaveColor.CGColor;
    }
    return _maskWaveLayer;
}

- (void)setWaveHeight:(CGFloat)waveHeight {
    _waveHeight = waveHeight;
    CGRect frame = [self bounds];
    frame.origin.y = frame.size.height - self.waveHeight;
    frame.size.height = self.waveHeight;
    _realWaveLayer.frame = frame;
    
    CGRect bound = [self bounds];
    bound.origin.y = bound.size.height - self.waveHeight;
    bound.size.height = self.waveHeight;
    _maskWaveLayer.frame = bound;
}

- (void)startWaveAnimation {
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopWaveAnimation {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)wave {
    if (!self.timer) {
        return;
    }
    self.offset += self.waveSpeed;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = self.waveHeight;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, height);
    CGFloat y = 0.f;
    CGMutablePathRef maskPath = CGPathCreateMutable();
    CGPathMoveToPoint(maskPath, NULL, 0, height);
    CGFloat maskY = 0.f;
    for (CGFloat x = 0.f; x <= width; x++) {
        y = height * sinf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(path, NULL, x, y);
        maskY = -y;
        CGPathAddLineToPoint(maskPath, NULL, x, maskY);
    }
    
    CGFloat centX = self.bounds.size.width / 2;
    CGFloat centY = height * sinf(0.01 * self.waveCurvature * centX + self.offset * 0.045);
    if (self.waveBlock) {
        self.waveBlock(centY);
    }
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathCloseSubpath(path);
    self.realWaveLayer.path = path;
    self.realWaveLayer.fillColor = self.realWaveColor.CGColor;
    CGPathRelease(path);
    
    CGPathAddLineToPoint(maskPath, NULL, width, height);
    CGPathAddLineToPoint(maskPath, NULL, 0, height);
    CGPathCloseSubpath(maskPath);
    self.maskWaveLayer.path = maskPath;
    self.maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    CGPathRelease(maskPath);
}

- (void)setCurvature:(CGFloat)curvature speed:(CGFloat)speed height:(CGFloat)height {
    self.waveCurvature = curvature;
    self.waveSpeed = speed;
    self.waveHeight = height;
}

- (void)setRealWaveColor:(UIColor *)realColor maskWaveColor:(UIColor *)maskColor {
    self.realWaveColor = realColor;
    self.maskWaveColor = maskColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
