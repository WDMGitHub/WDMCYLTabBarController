//
//  DMDetailsViewController.m
//  DMCYLTabBarController
//
//  Created by demin on 16/8/10.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "DMDetailsViewController.h"
#import "CYLTabBarController.h"
#import "DMMineViewController.h"

@interface DMDetailsViewController ()

@end

@implementation DMDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"详情页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"点击屏幕可以跳转到“我的”，执行testPush";
    label.frame = CGRectMake(20, 150, CGRectGetWidth(self.view.frame) - 2 * 20, 100);
    label.backgroundColor = [UIColor greenColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cyl_popSelectTabBarChildViewControllerAtIndex:3 completion:^(__kindof UIViewController *selectedTabBarChildViewController) {
        DMMineViewController *mineViewController = selectedTabBarChildViewController;
        [mineViewController testPush];
    }];
}






@end
