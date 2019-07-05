//
//  UIView+NSSting.m
//  01·iOS 面试题·项目中用过 Runtime 吗？
//
//  Created by Mac-Qke on 2019/7/5.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//


//利用 Method Swizzling 交换方法
#import "UIView+NSSting.h"
#import <objc/runtime.h>
@implementation UIView (NSSting)
- (NSString *)title {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTitle:(NSString *)title{
    objc_setAssociatedObject(self, @selector(title), title, OBJC_ASSOCIATION_RETAIN);
}

+ (void)xl_swizzleMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    Class class = [self class];
    
    SEL originalSel = originalSelector;
    
    SEL swizzledSel = swizzledSelector;
    
    Method originMethod = class_getInstanceMethod(class, originalSel);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSel);
    
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class, swizzledSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else {
         //添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
    

}


@end
