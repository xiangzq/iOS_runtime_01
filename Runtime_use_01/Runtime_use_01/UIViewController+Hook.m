//
//  UIViewController+Hook.m
//  Runtime_use_01
//
//  Created by 项正强 on 2018/11/9.
//  Copyright © 2018 项正强. All rights reserved.
//

#import "UIViewController+Hook.h"
#import <objc/runtime.h>
@implementation UIViewController (Hook)


/**
 本身只加载一次
 当类加载进内存的时候调用，而且不管有没有子类，都只会调用一次
 在main函数之前就调用了，不需要我们手动调用
 用途：可以新建类，在该类中实现一些配置
 runtime交换方法的时候，因为只需要交换一次方法，所以可以在该方法中实现交换方法的代码，用于只实现一次的代码
 */
+(void)load{
    
    //这里主要是防止该方法会被手动调用，所以再加一次保障
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        /**
         拿到自定义的方法
         参数一：获取哪个类的方法
         参数二：SEL 获取要交换的方法
         */
        Method m1 = class_getInstanceMethod(self, @selector(zq_viewWillAppear:));
        //拿到系统的方法
        Method m2 = class_getInstanceMethod(self, @selector(viewWillAppear:));
        //进行方法的交换，s其实质就是交换方法地址
        method_exchangeImplementations(m1, m2);
        
    });
}

/**
 可以在交换的方法里实现系统方法无法实现的功能
 例如：
 1.如果交换数据类型的方法（数组，字典，集合等），可以避免越界，元素为空等问题
 2.加载图片时可以判断是否加载成功等
 */

-(void)zq_viewWillAppear:(BOOL)animation{
    
    NSLog(@"交换方法：%s",__func__);
    
    [self zq_viewWillAppear:animation];
    
}

@end
