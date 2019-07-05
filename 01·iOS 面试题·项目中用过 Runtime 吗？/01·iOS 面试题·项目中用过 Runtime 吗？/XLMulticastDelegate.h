//
//  XLMulticastDelegate.h
//  01·iOS 面试题·项目中用过 Runtime 吗？
//
//  Created by Mac-Qke on 2019/7/5.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 Multicast Delegate 多播委托
 */
@interface XLMulticastDelegate : NSProxy
/**
 初始化
 */
- (instancetype)init;

/**
 增加一个观察者
 */

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

/**
 移除一个观察者
 */
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

/**
 移除一个观察者
 */
- (void)removeDelegate:(id)delegate;

/**
 移除所有的观察者
 */
- (void)removeAllDelegate;



@end

NS_ASSUME_NONNULL_END
