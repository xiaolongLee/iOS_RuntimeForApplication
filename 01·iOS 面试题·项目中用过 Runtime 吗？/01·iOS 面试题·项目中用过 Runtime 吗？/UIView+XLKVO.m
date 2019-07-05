//
//  UIView+XLKVO.m
//  01·iOS 面试题·项目中用过 Runtime 吗？
//
//  Created by Mac-Qke on 2019/7/5.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "UIView+XLKVO.h"
#import <objc/runtime.h>

#define XLKVOClassPrefix @"XLKVONotifying"


// 字典的 Key
#define XLKVODic_Observer @"XLKVODic_Observer"
#define XLKVODic_Key @"XLKVODic_Key"
#define XLKVODic_Block @"XLKVODic_Block"

//存放 观察者数据的 数组
const void * XLKVODictArrayKey = @"XLKVODictArrayKey";

@implementation UIView (XLKVO)
/**
 添加 KVO Block
 */

- (void)xl_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath completeBlock:(XLKVOCompleteBlock)completeBlock{
    //1.检查原始类，是否存在 KeyPath 对应的 Setter 方法
    //1.1 获取属性的 setter 方法名
   
}


#pragma mark - Private Methods
/**
 将 key 转成 setter 方法
 */
- (NSString *)x_fetchSetterSelNameWithKey:(NSString *)key {
    if (key == nil) {
        return nil;
    
    }
    
    //1.首字母转换成大写
    NSString *firstUpStr = [NSString stringWithFormat:@"%c",[[key uppercaseString] characterAtIndex:0]];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstUpStr];
    
    //2.前面加set
    NSString *setterMethodName = [NSString stringWithFormat:@"set%@:",key];
    
    //3.返回setter方法名
    return setterMethodName;
    
}

/**
 根据setter方法名,获取getter方法名
 */

- (NSString *)x_fetchGetterSELNameWithSetterSELName:(NSString *)setterSELName {
    ////1.去掉set
    NSRange range = [setterSELName rangeOfString:@"set"];
    NSString *subStr = [setterSELName substringFromIndex:range.length];
    
    //2.首字母转换成小写
    NSString *firstDownStr = [NSString stringWithFormat:@"%c",[[subStr lowercaseString] characterAtIndex:0]];
    NSString *getterSELName = [subStr stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstDownStr];
    
     //3.去掉最后的:
    getterSELName = [getterSELName substringToIndex:subStr.length -1];
    return getterSELName;
}
@end
