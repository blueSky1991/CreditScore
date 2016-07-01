//
//  ViewController.m
//  CreditScore
//
//  Created by 张东东 on 16/6/29.
//  Copyright © 2016年 张东东. All rights reserved.
//

#import "ViewController.h"
#import "DDCreditScoreView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (nonatomic,strong)DDCreditScoreView *circleView;
@property (nonatomic,assign)double percentage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.circleView = [[DDCreditScoreView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.circleView.backgroundColor = [UIColor whiteColor];
    self.circleView.percentage  = 50;
    
    [self.view addSubview:self.circleView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame  = CGRectMake(self.view.center.x-50, self.view.center.y+200, 100, 30);
    
    [btn setTitle:@"请点击测试" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)test{

    self.circleView.percentage  = arc4random_uniform(100);
}


@end
