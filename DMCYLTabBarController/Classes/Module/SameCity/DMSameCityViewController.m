//
//  DMSameCityViewController.m
//  DMCYLTabBarController
//
//  Created by demin on 16/8/10.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "DMSameCityViewController.h"
#import "DMDetailsViewController.h"

@interface DMSameCityViewController ()

@end

@implementation DMSameCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.title = @"同城";
    self.tabBarItem.title = @"同城1314";
}

#pragma mark - Methods
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller Cell %@", self.tabBarItem.title, @(indexPath.row)]];
}

#pragma mark - Table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController = [[DMDetailsViewController alloc] init];
    //    viewController.hidesBottomBarWhenPushed = YES;  // This property needs to be set before pushing viewController to the navigationController's stack. Meanwhile as it is all base on CYLBaseNavigationController, there is no need to do this.
    [self.navigationController pushViewController:viewController animated:YES];
}









@end
