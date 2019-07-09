//
//  XLMulticastDelegate.m
//  01·iOS 面试题·项目中用过 Runtime 吗？
//
//  Created by Mac-Qke on 2019/7/5.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "XLMulticastDelegate.h"
#import "NSObject+XLKVO.h"

@interface XLMulticastDelegateNode : NSObject

@property (nonatomic, weak) id delegate;

@property (nonatomic, strong) dispatch_queue_t delegateQueue;

- (instancetype)initNodeWithDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

@end

@implementation XLMulticastDelegateNode

- (instancetype)initNodeWithDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.delegateQueue = delegateQueue;
    }
    
    return self;
    
}

@end

@interface XLMulticastDelegate ()

@property (nonatomic, strong) NSMutableArray *observers;

@end




@implementation XLMulticastDelegate

#pragma mark -- Life Cycle
- (instancetype)init {
    _observers  = [NSMutableArray array];
    return self;
}

#pragma mark -- PublicMethods
- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue {
    if (delegate == nil) {
        return;
    }
    
    if (delegateQueue == nil) {
        delegateQueue = dispatch_get_main_queue();
    }
    
    XLMulticastDelegateNode *node = [[XLMulticastDelegateNode alloc] initNodeWithDelegate:delegate delegateQueue:delegateQueue];
    [_observers addObject:node];
}

- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue {
    if (delegate == nil) {
        return;
    }
    
    if (delegateQueue == nil) {
        delegateQueue = dispatch_get_main_queue();
    }
    
    XLMulticastDelegateNode *node = [[XLMulticastDelegateNode alloc] initNodeWithDelegate:delegate delegateQueue:delegateQueue];
    
    [_observers removeObject:node];
}


- (void)removeDelegate:(id)delegate {
    [self removeDelegate:delegate delegateQueue:nil];
}

- (void)removeAllDelegate {
    [_observers removeAllObjects];
}

#pragma mark - Private Methods

- (void)doNothing {
    NSLog(@"%s",__func__);
}

#pragma mark - 蹦床模式 消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    for (XLMulticastDelegateNode *node in _observers) {
        id nodeDelegate = node.delegate;
        NSMethodSignature *result = [nodeDelegate methodSignatureForSelector:sel];
        if (result != nil) {
            return result;
        }
    }
    
    //    return [super methodSignatureForSelector:aSelector];
    return [[self class] methodSignatureForSelector:@selector(doNothing)];
}


- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL selector = [invocation selector];
    
    for (XLMulticastDelegateNode *node in _observers) {
        id nodeDelegate = node.delegate;
        dispatch_queue_t delegateQueue = node.delegateQueue;
        if ([nodeDelegate respondsToSelector:selector]) {
            [invocation invokeWithTarget:nodeDelegate];
        }
        
    }
}


@end
