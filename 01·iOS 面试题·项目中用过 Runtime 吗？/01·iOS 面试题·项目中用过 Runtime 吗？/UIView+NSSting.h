//
//  UIView+NSSting.h
//  01·iOS 面试题·项目中用过 Runtime 吗？
//
//  Created by Mac-Qke on 2019/7/5.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NSSting)
@property (nonatomic, copy) NSString *title;
/**
 交换方法
 */
+ (void)xl_swizzleMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end

NS_ASSUME_NONNULL_END
