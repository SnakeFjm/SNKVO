//
//  NSObject+SNKVO.m
//  KVO封装
//
//  Created by Snake on 2019/4/23.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "NSObject+SNKVO.h"

#import <objc/runtime.h>

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, kvoBlock> *dict;

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray *> *kvoDict;

@end

@implementation NSObject (SNKVO)

- (void)SNObserver:(NSObject *)observer keyPath:(NSString *)keyPath block:(kvoBlock)block {
    //
    observer.dict[keyPath] = block;
    
    // 一个keyPath对应多个observer，一个observer对应多个keyPath
    NSMutableArray *arr = self.kvoDict[keyPath];
    if (!arr) {
        arr = [NSMutableArray array];
        self.kvoDict[keyPath] = arr;
    }
    //
    [arr addObject:observer];
    
    //
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //
        method_exchangeImplementations(class_getInstanceMethod([self class], @selector(SNDealloc)), class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc")));
    });
    
    // self是person observer是nextViewController
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // 执行block
    kvoBlock block = self.dict[keyPath];
    if (block) {
        block();
    }
}

- (void)SNDealloc {
    //
    NSLog(@"SNDealloc");
    
    // 执行removeObserver
    if ([self isKVO]) {
        [self.kvoDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableArray * _Nonnull obj, BOOL * _Nonnull stop) {
            //
            NSMutableArray *arr = self.kvoDict[key];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //
                [self removeObserver:obj forKeyPath:key];
            }];
        }];
    }
    //
    [self SNDealloc];
}

- (BOOL)isKVO {
    //
    if (objc_getAssociatedObject(self, @selector(kvoDict))) {
        return YES;
    } else {
        return NO;
    }
}

/** getter 和 setter */
- (NSMutableDictionary<NSString *,kvoBlock> *)dict {
    //
    NSMutableDictionary *tmpDict = objc_getAssociatedObject(self, @selector(dict));
    if (!tmpDict) {
        tmpDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(dict), tmpDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tmpDict;
}

- (NSMutableDictionary<NSString *,NSMutableArray *> *)kvoDict {
    //
    NSMutableDictionary *tmpDict = objc_getAssociatedObject(self, @selector(kvoDict));
    if (!tmpDict) {
        tmpDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(kvoDict), tmpDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tmpDict;
}

@end
