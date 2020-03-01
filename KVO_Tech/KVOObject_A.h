//
//  KVOObject_A.h
//  KVO_Tech
//
//  Created by 何振 on 2020/2/29.
//  Copyright © 2020 李龙辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVOObject_A : NSObject

@property (nonatomic, assign) NSUInteger value;

@property (nonatomic, assign) IMP imp;

@property (nonatomic, assign) IMP classImp;

- (void)testMethod;

@end

NS_ASSUME_NONNULL_END
