//
//  DMMessageViewController.m
//  DMCYLTabBarController
//
//  Created by demin on 16/8/10.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "DMMessageViewController.h"

@interface DMMessageViewController ()

@end

@implementation DMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"消息";    //✅sets navigation bar title.The right way to set the title of the navigation
    self.tabBarItem.title = @"消息1314";   //❌sets tab bar title. Even the `tabBarItem.title` changed, this will be ignored in tabbar.
    //self.title = @"消息1";                //❌sets both of these. Do not do this‼️‼️ This may cause something strange like this : http://i68.tinypic.com/282l3x4.jpg .
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
    return 15;
}














@end
