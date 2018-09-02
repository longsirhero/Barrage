//
//  BluletView.h
//  CommentDemo
//
//  Created by WingChing Yip on 2018/9/1.
//  Copyright © 2018年 WingChing Yip. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MoveStatus) {
    Start,
    Enter,
    End
};

@interface BluletView : UIView

// 弹道
@property (nonatomic , assign) int trajectory;
// 弹道转态回调
@property (nonatomic , copy) void(^moveStatusBlock)(MoveStatus status);

// 初始化弹幕
- (instancetype)initWithComment:(NSString *)comment;

// 开始动画
- (void)startAnimation;

// 结束动画
- (void)stopAnimation;

@end
