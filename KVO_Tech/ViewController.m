//
//  ViewController.m
//  KVO_Tech
//
//  Created by 何振 on 2020/2/29.
//  Copyright © 2020 李龙辉. All rights reserved.
//

#import "ViewController.h"
#import "KVOObject_A.h"
#import "KVOObserver_M.h"
#import "KVOObserver_N.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /// Test
//    NSObject *object = [[NSObject alloc] init];
//    NSArray *propertiesObj = getProperties([object class]);
//    NSArray *methodsObj = getMethods([object class]);
//    NSArray *ivarsObj = getIvars([object class]);
    
    KVOObject_A *object_A = [[KVOObject_A alloc] init];
    /// object_A 被观察前
    Class class_A_before = object_getClass(object_A);
    NSLog(@"before object_A: %@", class_A_before);
    /// 属性集合
    NSArray *properties_A_before = getProperties(class_A_before);
    /// 成员变量集合
    NSArray *ivars_A_before = getIvars(class_A_before);
    /// 方法集合
    NSArray *methods_A_before = getMethods(class_A_before);
    ///
    IMP iMP_A_before = object_A.imp;
    IMP classIMP_A_before = object_A.classImp;
    
    /// ---------观察者M
    KVOObserver_M *observer_M = [[KVOObserver_M alloc] init];
    /// ---------观察者N
    KVOObserver_N *observer_N = [[KVOObserver_N alloc] init];
    
    /// --------- 执行观察 #*注意执行观察的顺序 +M +N *#
    [object_A addObserver:observer_M
               forKeyPath:@"value"
                  options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew
                  context:nil];
    [object_A addObserver:observer_N
               forKeyPath:@"value"
                  options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew
                  context:nil];
    
    /// object_A 被观察后
    Class class_A_after = object_getClass(object_A);
    NSLog(@"after object_A: %@", class_A_after);
    /// 属性集合
    NSArray *properties_A_after = getProperties(class_A_after);
    /// 成员变量集合
    NSArray *ivars_A_after = getIvars(class_A_after);
    /// 方法集合
    NSArray *methods_A_after = getMethods(class_A_after);
    ///
    IMP iMP_A_after = object_A.imp;
    IMP classIMP_A_after = object_A.classImp;
    
    BOOL isSame = [object_A isEqual:[object_A self]];
    /// object_A 被观察前后 是否指向同一个class
    BOOL isSameClass = [class_A_before isEqual:class_A_after];
    BOOL isSubClass = [class_A_after isSubclassOfClass:class_A_before];

    /// 1、通过setter方法来改变被观察者的值
    object_A.value = 10;
    
    /// 2、通过KVC设置value能否生效？ yes
    [object_A setValue:@25 forKey:@"value"];
    
    /// 3、通过成员变量直接赋值value能否生效？ no
    [object_A testMethod];  /// 需要手动添加KVO的
    
    
    /// --------- 移除观察
    [object_A removeObserver:observer_M forKeyPath:@"value"];
    [object_A removeObserver:observer_N forKeyPath:@"value"];
    
}

NSArray<NSString *> *getProperties(Class aClass) {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(aClass, &count);
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    return mArray.copy;
}

NSArray<NSString *> *getIvars(Class aClass) {
    unsigned int count;
    Ivar *ivars = class_copyIvarList(aClass, &count);
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *cName = ivar_getName(ivar);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    return mArray.copy;
}

NSArray<NSString *> *getMethods(Class aClass) {
    unsigned int count;
    Method *methods = class_copyMethodList(aClass, &count);
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *selectorName = NSStringFromSelector(selector);
        [mArray addObject:selectorName];
    }
    return mArray.copy;
}


@end
