//
//  NSArray+Crash.m
//  Runtime_use_01
//
//  Created by 项正强 on 2018/11/10.
//  Copyright © 2018 项正强. All rights reserved.
//

#import "NSArray+Crash.h"
#import <objc/runtime.h>
@implementation NSArray (Crash)

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method m1 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        
        Method m2 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(xzq_objectAtIndex:));
        
        method_exchangeImplementations(m1, m2);
        
    });
    
}

-(id)xzq_objectAtIndex:(NSUInteger)index{
        
    if (self.count -1 < index) {
        
        @try {
            return [self xzq_objectAtIndex:index];
            
        } @catch (NSException *exception) {
            
            NSLog(@"【 数组崩溃：%s Crash Because Method %s 】",class_getName(self.class),__func__);
            
            NSLog(@"【 %@ 】",[exception callStackSymbols]);
            
        } @finally {
            
            NSLog(@"数组运行正常");
            
        }
    }else{
        
        return [self xzq_objectAtIndex:index];
        
    }
    
}

@end
