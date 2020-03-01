//
//  KVOObserver_N.m
//  KVO_Tech
//
//  Created by 何振 on 2020/2/29.
//  Copyright © 2020 李龙辉. All rights reserved.
//

#import "KVOObserver_N.h"

@implementation KVOObserver_N

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"KVOObserver_N 接收到了 KVOObject_A的变化");  /// #* 注意这里的 M N 谁先收到变化 *#
    
}

@end
