//
//  MainViewController.m
//  实用工具包
//
//  Created by Ghoul on 15/12/24.
//  Copyright © 2015年 Ghoul. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewDataSourceModel.h"
#import "MainViewCollectionViewCell.h"
#import "MainViewCollectionViewFlowLayout.h"

#import "OpaqueNavigationBar.h"

#define Block_Line_Width 0
#define Block_Num_For_W 3

#define NAVBAR_CHANGE_POINT 64

@interface MainViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) MainViewCollectionViewFlowLayout * mainViewCollectionFlowLayout;
@property (nonatomic, strong) OpaqueNavigationBar * navBar;

@end

@implementation MainViewController

#pragma mark- <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MainViewCollectionViewCell * cell = [MainViewCollectionViewCell cellForCollectionview:collectionView indexPath:indexPath];
    
    MainViewDataSourceModel * model = self.dataSource[indexPath.row];
    cell.labelText = model.title;
    cell.imageStr = @"625.jpg";
    
    return cell;
}
#pragma mark- <UICollectionViewDelegate>
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat W_Block = (_collectionView.frame.size.width- Block_Line_Width) / Block_Num_For_W - Block_Line_Width;
//    CGFloat H_Block = W_Block * 0.8 * 1.3;
//    
//    return CGSizeMake(W_Block, H_Block);
//}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark- UIScrollViewDelegate
/**滑动隐藏时候实现的方法*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64);
        [self.navBar setBackgroundAlpha:alpha];
    } else {
        [self.navBar setBackgroundAlpha:0];
    }
}

#pragma mark- 懒加载
- (NSArray *)dataSource {
    if (!_dataSource) {
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"MainViewMainDataSouce" ofType:@"plist"];
        _dataSource = [NSMutableArray arrayWithArray:[MainViewDataSourceModel objectArrayWithFile:filePath]];
    }
    return _dataSource;
}

- (MainViewCollectionViewFlowLayout *)mainViewCollectionFlowLayout {
    if (!_mainViewCollectionFlowLayout) {
        MainViewCollectionViewFlowLayout * flowLayout = [[MainViewCollectionViewFlowLayout alloc] init];
        _mainViewCollectionFlowLayout = flowLayout;
        _mainViewCollectionFlowLayout.minimumInteritemSpacing = Block_Line_Width; //横向线宽
        _mainViewCollectionFlowLayout.minimumLineSpacing = 0; //纵向线宽
    }
    return _mainViewCollectionFlowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:self.mainViewCollectionFlowLayout];
        
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[MainViewCollectionViewCell class] forCellWithReuseIdentifier:[MainViewCollectionViewCell cellIdentifier]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainViewDataSourceModel * model = self.dataSource[indexPath.row];
    NSString * str = model.jmpVC;
    Class className = NSClassFromString(str);
    UIViewController * VC = [className new];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (OpaqueNavigationBar *)navBar {
    if (!_navBar) {
        _navBar = [[OpaqueNavigationBar alloc] init];
        _navBar.barTintColor = self.navigationController.navigationBar.barTintColor;
    }
    return _navBar;
}

#pragma mark- Action
- (void)returnAction {
    
}

- (void)moreAction {
    
}

#pragma mark- layoutSubView 
- (void)layoutViewOfInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        MAS_MAKE_INSETS(self.view, 0, 0, 0, 0);
    }];
    CGFloat screenWidth ;
    if (_collectionView.frame.size.width == 0) {
        screenWidth = SCREEN_WIDTH;
    }else  {
        screenWidth = _collectionView.frame.size.width;
    }
    CGFloat W_Block = (screenWidth- Block_Line_Width) / Block_Num_For_W - Block_Line_Width;
    CGFloat H_Block = W_Block * 0.8 * 1.3;
    self.mainViewCollectionFlowLayout.itemSize = CGSizeMake(W_Block, H_Block);
}

#pragma mark lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.leftItem = [UIBarButtonItem itemWithIcon:@"fanhui_s" highlightedIcon:@"fanhui_n" target:self action:@selector(returnAction)];
    self.navBar.rightItem = [UIBarButtonItem itemWithTitle:@"more" target:self action:@selector(moreAction)];
    
    UIImageView * BGView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"625.jpg"]];
    [self.view insertSubview:BGView atIndex:0];
    
    [self.view insertSubview:self.collectionView atIndex:1];
    [self layoutViewOfInterfaceOrientation:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.view addSubview:self.navBar];
    [self.navBar setBackgroundAlpha:0];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return nil;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self layoutViewOfInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation];
}







@end







//- (NSArray *)dataSource {
//    if (!_dataSource) {
//        _dataSource = @[@"天气",@"万年历",@"快递",@"公交路线",@"火车",@"订酒店",@"地铁",@"长途汽车",@"路况交通",@"酒店",@"航班",@"小品相声",@"2048",@"看图猜字",@"拼图",@"菜谱",@"菜价",@"短信大全",@"百科全书",@"计算器",@"节日查询",@"万年历"];
//    }
//    return _dataSource;
//}

