//
//  VarTableCellHeightViewController.m
//  实用工具包
//
//  Created by Ghoul on 16/3/8.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "VarTableCellHeightViewController.h"
#import "VarTableHeightViewCell.h"

@interface VarTableCellHeightViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * tableData;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) VarTableHeightViewCell * cell;

@end

@implementation VarTableCellHeightViewController

- (void)viewDidLoad {
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        MAS_MAKE_INSETS(self.view, 0, 0, 0, 0);
    }];
    self.tableView.backgroundColor = [UIColor navBGColor];
//iOS8以后如果要动态计算cell高度，这个估算高度必须要设置，不设置的话自动计算就失效。
//    self.tableView.estimatedRowHeight = 200;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.tableView.allowsSelection = NO;
    [self.tableView registerClass:[VarTableHeightViewCell class] forCellReuseIdentifier:[VarTableHeightViewCell cellIdentifier]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
#pragma mark- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"aaaaa";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VarTableHeightViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VarTableHeightViewCell cellIdentifier]];
//    VarTableHeightViewCell * cell = [VarTableHeightViewCell cellForTableView:tableView];
    cell.text = self.tableData[indexPath.row];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

/**ios7 必须实现的方法*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = (VarTableHeightViewCell *)[tableView dequeueReusableCellWithIdentifier:[VarTableHeightViewCell cellIdentifier]];
    
    //其他代码
    VarTableHeightViewCell * cell = self.cell;
    cell.text = [self.tableData objectAtIndex:indexPath.row];
    CGFloat labelWidth = CGRectGetWidth(self.tableView.frame);
    [cell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(labelWidth));
    }];
    
    //重新加载约束
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    //自动算高度，+1的原因是因为contentView的高度要比cell的高度小1
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    
    return height;
}

#pragma mark- `
- (NSMutableArray *)tableData {
    if (!_tableData) {
        _tableData = [NSMutableArray array];
        NSArray * arr =  @[@"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3",@"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3"@"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3"@"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3"@"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3"@"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3"];
        [_tableData addObjectsFromArray:arr];
    }
    return _tableData;
}



@end
