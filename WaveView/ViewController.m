//
//  ViewController.m
//  iOSDemo
//
//  Created by Ray Fong on 16/9/5.
//  Copyright © 2016年 Ray Fong. All rights reserved.
//

#import "ViewController.h"
#import "BBWaveView.h"


#define KHexColor(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@property (nonatomic, strong) BBWaveView *waveView;

- (IBAction)startAnimate:(id)sender;

- (IBAction)stopAnimate:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat width = CGRectGetWidth(self.view.bounds);
    _waveView = [[BBWaveView alloc] initWithFrame:CGRectMake(0, 0, width, 200)];
    [_waveView setBackgroundColor:KHexColor(0x00FF7F)];
    [_waveView setCurvature:1.6 speed:0.6 height:8];
    [_waveView setWaveBlock:^(CGFloat currentY){
        //NSLog(@"Y:%f", currentY);
    }];
    [self.view addSubview:_waveView];
    
    CGFloat offset = (width - 100 * 2 - 20) / 2;
    UIButton *start = [[UIButton alloc] initWithFrame:CGRectMake(offset, 300, 100, 30)];
    [start setBackgroundColor:[UIColor redColor]];
    [start setTitle:@"开始" forState:UIControlStateNormal];
    [start addTarget:self action:@selector(startAnimate:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:start];
    
    UIButton *stop = [[UIButton alloc] initWithFrame:CGRectMake(width - offset - 100, 300, 100, 30)];
    [stop setBackgroundColor:[UIColor redColor]];
    [stop setTitle:@"停止" forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stopAnimate:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimate:(id)sender {
    [_waveView startWaveAnimation];
}

- (void)stopAnimate:(id)sender {
    [_waveView stopWaveAnimation];
}

@end
