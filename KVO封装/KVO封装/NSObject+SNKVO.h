//
//  NSObject+SNKVO.h
//  KVO封装
//
//  Created by Snake on 2019/4/23.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^kvoBlock)(void);

@interface NSObject (SNKVO)

- (void)SNObserver:(NSObject *)observer keyPath:(NSString *)keyPath block:(kvoBlock)block;

@end

NS_ASSUME_NONNULL_END
