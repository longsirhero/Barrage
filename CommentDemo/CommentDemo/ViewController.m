//
//  ViewController.m
//  CommentDemo
//
//  Created by WingChing Yip on 2018/9/1.
//  Copyright © 2018年 WingChing Yip. All rights reserved.
//

// MARK: - iOS弹幕 ： https://www.imooc.com/learn/689


#import "ViewController.h"
#import "BluletView.h"
#import "BlulletManager.h"

@interface ViewController ()

@property (nonatomic , strong , readwrite) BlulletManager *manager;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [[BlulletManager alloc] init];
    __weak typeof (self) mySelf = self;
    self.manager.generateViewBlock = ^(BluletView *viwe){
        [mySelf addBulletView:viwe];
    };
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [stopBtn setTitle:@"stop" forState:UIControlStateNormal];
    stopBtn.frame = CGRectMake(250, 100, 100, 40);
    [stopBtn addTarget:self action:@selector(clickStopBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    
}

- (void)clickBtn {
    [self.manager start];
}

- (void)clickStopBtn {
    [self.manager stop];
}

- (void)addBulletView: (BluletView *)view {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 300 + view.trajectory * 40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startAnimation];
}


@end
