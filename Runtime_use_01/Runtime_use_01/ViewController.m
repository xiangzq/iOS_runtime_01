//
//  ViewController.m
//  Runtime_use_01
//
//  Created by 项正强 on 2018/11/9.
//  Copyright © 2018 项正强. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"执行方法：%s",__func__);

    NSArray *array = @[@"1",@"2",@"3"];
    [array objectAtIndex:2];
    //注意：如果是简写 array[3] ,这种是不会走到交换方法的，还是会crash
    [array objectAtIndex:3];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}




@end
