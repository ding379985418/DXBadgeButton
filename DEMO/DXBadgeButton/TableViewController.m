//
//  TableViewController.m
//  DXBadgeButton
//
//  Created by simon on 16/6/22.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import "TableViewController.h"
#import "DXBadgeButton.h"

@interface TableViewController ()<UIGestureRecognizerDelegate>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"tableView中DXBadgeButton的使用";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id" forIndexPath:indexPath];
    NSString *str = [NSString stringWithFormat:@"%zd",indexPath.row];
    cell.textLabel.text = str;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        DXBadgeButton *badge = [[DXBadgeButton alloc] initWithFrame:CGRectMake(cell.frame.size.width -35, 43.5, 20, 20)];
    badge.badgeString = str;
    [cell.contentView addSubview:badge];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}


@end
