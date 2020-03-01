# KVO_Tech
 KVO小知识

####一、运行Demo，断点并po打印出
分析以上结果 我们通过抓取 object_A 在被 observer_M, observer_N 观察前和观察后的 
类的类型(object_getClass)，属性列表(Properties)，变量列表(Ivars)，方法列表(Methods)，得出：

被观察后 动态的新建了一个 NSKVONotifying_KVOObject_A 类 这个类是 KVOObject_A类型的子类； 此时改变isa的指向，使它指向 NSKVONotifying_KVOObject_A
1、class: 被观察前，object_A 为 KVOObject_A 类型， 被观察后，变为了 NSKVONotifying_KVOObject_A 类型。
(通过isa指向改变，事实上，object_getClass(object_A) 和 object_A->isa方法等价)。
2、属性，实例变量：NSKVONotifying_KVOObject_A 没有属性和实例变量。 
3、方法列表：NSKVONotifying_KVOObject_A 有4个方法（①setValue:,②class, ③dealloc, ④_isKVOA）
我们可以注意到，
①被观察的值setValue:方法的实现由 ([KVOObject_A setValue:] at KVOObject_A.m)变为了(Foundation_NSSetUnsignedLongLongValueAndNotify)。这个被重写的setter方法在原有的实现变成了[self willChangeValueForKey:@“name”]; 调用存取方法之前总调[super setValue:newName forKey:@”name”]; [self didChangeValueForKey:@”name”]; 等，以触发观察者的响应。 

②class方法由(libobjc.A.dylib -[NSObject class]) 变为了(Foundation_NSKVOClass),#######这也解释了我们在被观察前 被观察后执行[objectA class]方法得到结果不同的原因，-(Class)class方法的实现本来就是object_getClass，但在被观察后class方法和 object_getClass结果却不一样，事实是class方法被重写了，class方法总能得到KVOObject_A

③dealloc方法: 观察移除后使class变回去KVOObject_A(通过isa指向), 

④_isKVO: 判断被观察者自己是否同时也观察了其他对象。

#事实上 简而言之，苹果使用了一种isa交换的技术，当objectA被观察后，objectA对象的isa指针被指向了一个新建的KVOObject_A的子类NSKVONotifying_KVOObject_A，且这个子类重写了被观察值的setter方法和class方法，dealloc和_isKVO方法，然后使objectA对象的isa指针指向这个新建的类，然后事实上objectA变为了NSKVONotifying_KVOObject_A的实例对象，执行方法要从这个类的方法列表里找。(同时苹果警告我们，通过isa获取类的类型是不可靠的，通过class方法总是能得到正确的类=_=!!)

####二、看图

![image](https://github.com/hzz2020/KVO_Tech/blob/master/follow1.png)

####欢迎大家指出文中的错误！
