//
//  BluletView.m
//  CommentDemo
//
//  Created by WingChing Yip on 2018/9/1.
//  Copyright © 2018年 WingChing Yip. All rights reserved.
//

// MARK: - iOS弹幕 ： https://www.imooc.com/learn/689


#import "BluletView.h"

#define Padding 10

@interface BluletView()

@property (nonatomic , strong , readwrite) UILabel *lbComment;

@end

@implementation BluletView

// 初始化弹幕
- (instancetype)initWithComment:(NSString *)comment {
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        
        // 计算弹幕的实际宽度
        NSDictionary *att = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0]};
        CGFloat width = [comment sizeWithAttributes:att].width;
        self.bounds = CGRectMake(0, 0, width + 2 * Padding, 30);
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(Padding, 0, width, 30);
    }
    return self;
}

// 开始动画
- (void)startAnimation {
    // 根据弹幕长度执行动画效果
    // 根据 V = S/T ,时间相同的情况下，距离越长，速度就越快
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0f;
    CGFloat wholeWidth = screenWidth + CGRectGetWidth(self.bounds);
    
    // 弹幕开始
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Start);
    }
    
    // 弹幕进入
    CGFloat speed = wholeWidth/duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;
    
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(enterDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (self.moveStatusBlock) {
//            self.moveStatusBlock(Enter);
//        }
//    });
    
    __block CGRect frame = self.frame;
    [UIView animateWithDuration: duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (self.moveStatusBlock) {
            self.moveStatusBlock(End);
        }
    }];
}

- (void)enterScreen {
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Enter);
    }
}

// 结束动画
- (void)stopAnimation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (UILabel *)lbComment {
    if (!_lbComment) {
        _lbComment = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textColor = [UIColor whiteColor];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbComment];
    }
    return _lbComment;
}


@end