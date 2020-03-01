//
//  KVOObserver_M.m
//  KVO_Tech
//
//  Created by 何振 on 2020/2/29.
//  Copyright © 2020 李龙辉. All rights reserved.
//

#import "KVOObserver_M.h"
#import "KVOObject_A.h"

@implementation KVOObserver_M

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"KVOObserver_M 接收到了 KVOObject_A的变化");  /// #* 注意这里的 M N 谁先收到变化 *#
    
    /// 处理
    if ([keyPath isEqualToString:@"value"] &&
        [object isKindOfClass:[KVOObject_A class]]) {
        
        NSNumber *oldValue = [change valueForKey:NSKeyValueChangeOldKey];
        NSNumber *newValue = [change valueForKey:NSKeyValueChangeNewKey];
        NSLog(@"oldValue = %@, newValue = %@", oldValue, newValue);
    }
}

@end
