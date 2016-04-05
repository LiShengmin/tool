//
//  MainDemoTableViewController.m
//  实用工具包
//
//  Created by Ghoul on 16/3/18.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "MainDemoTableViewController.h"
#import "MainDemoTableViewCell.h"
#import "MainDemoTableViewModel.h"

@interface MainDemoTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation MainDemoTableViewController

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainDemoTableViewCell * cell = [MainDemoTableViewCell cellForTableView:tableView];
    
    MainDemoTableViewModel * model = self.dataSource[indexPath.row];
    cell.name = model.name;
    return cell;
}

#pragma mark- UITableViewDelegat
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainDemoTableViewModel * model = self.dataSource[indexPath.row];
    NSString * str = model.jmpVC;
    Class className = NSClassFromString(str);
    UIViewController * VC = [className new];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark- CycleLife
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        MAS_MAKE_ZERO(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MainDemoTableViewCell class] forCellReuseIdentifier:[MainDemoTableViewCell cellIdentifier]];
    self.tableView.estimatedRowHeight = 100.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"MainDemoTabDataSource" ofType:@"plist"];
        _dataSource = [NSMutableArray arrayWithArray:[MainDemoTableViewModel objectArrayWithFile:filePath]];
        DLog(@"DataSource == %@", _dataSource);
    }
    return _dataSource;
}











@end
