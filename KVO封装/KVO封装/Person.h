//
//  Person.h
//  KVO封装
//
//  Created by Snake on 2019/4/23.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSMutableArray *arr;

@end

NS_ASSUME_NONNULL_END
