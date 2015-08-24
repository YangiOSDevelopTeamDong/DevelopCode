//
//  ViewController.m
//  手势解锁
//
//  Created by 杨立荣 on 15/8/13.
//  Copyright (c) 2015年 杨立荣. All rights reserved.
//

#import "ViewController.h"
#import "YLockView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    self.view.backgroundColor = [UIColor redColor];
    //1 默认排版
    
    //1.1 自定义一个 view 并添加按钮
    YLockView *lockView = [[YLockView alloc] init];
    CGFloat lockViewWidth = self.view.bounds.size.width;
    lockView.bounds = CGRectMake(0, 0, lockViewWidth, lockViewWidth);
    lockView.backgroundColor = [UIColor clearColor];
    lockView.center = self.view.center;
    
    [self.view addSubview:lockView];
    
    
    //2 设置选中的按钮

    
    
    //3 设置按钮间的连线 使用 UIBezierPath 方法
    
    //4 添加背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    
}



@end















