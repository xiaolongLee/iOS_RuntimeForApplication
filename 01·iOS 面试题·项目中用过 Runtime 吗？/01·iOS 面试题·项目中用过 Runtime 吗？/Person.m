//
//  Person.m
//  01·iOS 面试题·项目中用过 Runtime 吗？
//
//  Created by Mac-Qke on 2019/7/5.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//


//利用 class_copyIvarList 实现 NSCoding 的自动归档解档
#import "Person.h"
#import <objc/runtime.h>
#define XLNSCodingRuntime_EncodeWithCoder(Class) \
unsigned int outCount = 0; \
Ivar *ivars = class_copyIvarList([Class class], &outCount); \
for (int i = 0; i < outCount; i++) { \
    Ivar ivar = ivars[i]; \
    NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)]; \
    [aCoder encodeObject:[self valueForKey:key] forKey:key]; \
}\
free(ivars);\
\


#define XLNSCodingRuntime_InitWithCoder(Class) \
if (self = [super init]) { \
    unsigned int outCount = 0; \
    Ivar *ivars = class_copyIvarList([Class class], &outCount); \
    for (int i = 0; i < outCount; i++) { \
        Ivar ivar = ivars[i]; \
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)]; \
        id value = [aDecoder decodeObjectForKey:key]; \
        if (value) { \
            [self setValue:value forKey:key]; \
        } \
    } \
    free(ivars); \
} \
return self; \



@implementation Person
// 对应调用
- (void)encodeWithCoder:(NSCoder *)aCoder {
    XLNSCodingRuntime_EncodeWithCoder(Person);
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    XLNSCodingRuntime_InitWithCoder(Person);
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    
    return self;
}


- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@ 对象的 %@ 属性改变了: %@",object,keyPath,change);
}



@end
