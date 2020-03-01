//
//  KVOObject_A.m
//  KVO_Tech
//
//  Created by 何振 on 2020/2/29.
//  Copyright © 2020 李龙辉. All rights reserved.
//

#import "KVOObject_A.h"

@implementation KVOObject_A

- (void)setValue:(NSUInteger)value {
    _value = value;
}

- (IMP)imp {
    return [self methodForSelector:@selector(setValue:)];
}

- (IMP)classImp {
    return [self methodForSelector:@selector(class)];
}

- (void)testMethod {
//    [self willChangeValueForKey:@"value"];  /// 手动add
    _value += 30;
//    [self didChangeValueForKey:@"value"];   /// 手动add 
}

@end
