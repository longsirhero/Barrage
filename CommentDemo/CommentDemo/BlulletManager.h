//
//  BlulletManager.h
//  CommentDemo
//
//  Created by WingChing Yip on 2018/9/1.
//  Copyright © 2018年 WingChing Yip. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BluletView;
@interface BlulletManager : NSObject

@property (nonatomic , copy , readwrite) void(^generateViewBlock)(BluletView *view);


// 弹幕开始执行
- (void)start;

// 弹幕停止
- (void)stop;

@end
