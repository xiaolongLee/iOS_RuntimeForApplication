//
//  NSObject+XLKVO.h
//  01·iOS 面试题·项目中用过 Runtime 吗？
//
//  Created by Mac-Qke on 2019/7/8.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^XLKVOCompleteBlock)(id observer, NSString *keyPath, id oldValue, id newValue);
@interface NSObject (XLKVO)
//利用 objc_allocateClassPair、object_setClass 等 API 来实现 KVO Block

/**
 添加 KVO Block
 */

- (void)xl_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath completeBlock:(XLKVOCompleteBlock)completeBlock;

/**
 移除 KVO Block
 */

- (void)xl_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
