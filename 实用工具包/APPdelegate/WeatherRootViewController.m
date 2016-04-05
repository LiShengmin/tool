//
//  WeatherRootViewController.m
//  实用工具包
//
//  Created by Ghoul on 16/1/6.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "WeatherRootViewController.h"
#import "QDDSmallScrollerView.h"
#import "NSString+Weather.h"
#import "XmlDataSourceModel.h"
#import "CoordinateCLLocationManager.h"

#import "WeatherIndexModel.h"
#import "WeatherForecastModel.h"

#import "WeatherIndexModelTableViewCell.h"

@interface WeatherRootViewController ()<UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) CLGeocoder * geocoder;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSString * modelIdentifire;

@end

@implementation WeatherRootViewController

- (void)viewDidLoad {
    /**获取地址，通过定位方式*/
    CoordinateCLLocationManager * location = [CoordinateCLLocationManager sharedCoordinateCLLocationManager] ;
    //获取定位城市数据
//    [location latitudeAndLongitudeWithCLLocationFromDesiredAccuracy:kCLLocationAccuracyBest distanceFilter:1000];
    
//    [location success:^(NSString * success)];
//    location CoorSuccess
    /**分析URL 传入type， 和城市编码*/
    
    //    /**WEBView*/
    //    [self.view addSubview:self.webView];
    //    //Document路径下
    //    //  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    //  NSString *documentsDirectory = [paths objectAtIndex:0];
    //    //项目路径下
    //    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"areaid_v.xlsx"];
    //    NSURL *url = [NSURL fileURLWithPath:path];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    [self.webView loadRequest:request];
    
    /***/
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    /**网络请求*/
    NSString * areaId = @"朝阳";
    WeatherType type = index_v;
    NSString * url = [[NSString alloc] weatherURL:areaId type:type];
//
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 200, 200)];
    [self.view addSubview:view];
    
    [GHONetWorking GHO_GET:url parameters:nil progress:^(NSProgress *downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        RootModel * model;
        if (type == index_f || type == forecast_f) {
            model = [WeatherForecastModel objectWithKeyValues:responseObject];
            self.modelIdentifire = @"index_f | forecast_f";
        }else {
            model = [WeatherIndexModel objectWithKeyValues:responseObject];
            self.modelIdentifire = @"index_v | forecast_v";
        }
        DLog(@"model ============== %@", model);
        /**显示到视图*/
        switch (type) {
            case index_v:
                [self LabelWithIndex_vFromModel:(WeatherIndexModel *)model];
                break;
            case index_f:
                
                break;
            case forecast_v:
                [self LabelWithIndex_vFromModel:(WeatherIndexModel *)model];
                break;
            case forecast_f:
                
                break;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
    
    
    
    
    
}
#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.modelIdentifire isEqualToString:@"index_v | forecast_v"]) {
        WeatherIndexModelTableViewCell * cell = [WeatherIndexModelTableViewCell cellForTableView:tableView];
        WeatherIndexModelI * model = self.dataSource[indexPath.row];
        cell.model = model;
        return cell;
    }else {
//        WeatherForecastModel * model = self.dataSource[indexPath.row];
    }
    return nil;
}

#pragma mark- View
- (UIView *)LabelWithIndex_vFromModel:(WeatherIndexModel *)model {
    
    for (int i = 0; i < model.i.count; i++) {
        WeatherIndexModelI * modeli = model.i[i];
        [self.dataSource addObject:modeli];
    }
    [self.tableView reloadData];
    return nil;
}

#pragma mark- 懒加载
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        [_tableView setBackgroundColor:[UIColor blueColor]];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 100.0F;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[WeatherIndexModelTableViewCell class] forCellReuseIdentifier:[WeatherIndexModelTableViewCell cellIdentifier]];
    }
    return _tableView;
}


#pragma mark- WebView
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _webView.backgroundColor = [UIColor lightGrayColor];
        _webView.delegate = self;
        [self.webView setClipsToBounds:YES];
        [self.webView setScalesPageToFit:YES];
    }
    return _webView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    /**取出XML内容的方法*/
    NSString *lJs = @"document.documentElement.innerHTML";//获取当前网页的html
    NSString * innerHtmlStr = [webView stringByEvaluatingJavaScriptFromString:lJs];
    NSMutableArray * arr1 = [[NSMutableArray alloc] init];
    /**第一次匹配*/
    NSRegularExpression * regular = [NSRegularExpression regularExpressionWithPattern:@"<td class.+?</td>" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    [regular enumerateMatchesInString:innerHtmlStr options:NSMatchingReportCompletion range:NSMakeRange(0, innerHtmlStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        /**过滤*/
        NSString * tbStr = [innerHtmlStr substringWithRange:result.range];
        NSRegularExpression * regular1 = [NSRegularExpression regularExpressionWithPattern:@">.*?<" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
        [regular1 enumerateMatchesInString:tbStr options:NSMatchingReportCompletion range:NSMakeRange(0, tbStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result.range.length < 4) {
                
            }else {
                NSRange range = NSMakeRange(result.range.location + 1, result.range.length - 2);
                NSString * overStr = [tbStr substringWithRange:range];
                overStr = [overStr stringByReplacingOccurrencesOfString:@" " withString:@""];/*过滤空格*/
                [arr1 addObject:overStr];
            }
        }];
    }];
    [self AfterDataSourceDidSth:arr1];
    
    /**定义加载方式*/
}

- (void)AfterDataSourceDidSth:(NSArray *)dataSource {
    DLog(@"%@", dataSource);
}
/**
 lenth 表格的列数 
 indexArr 表格索引，表示列表头， 表示索引优先级 从高到低
 dataSource 从表格中取出的数据源
 isIndex 表示数据源中是否有索引值
 如果isIndex ＝ no 使用priorityArr 来初始化数组 如果priorityArr＝nil
 如果priorityArr ＝ nil 使用
 */
- (NSArray <XmlDataSourceModel *> *)analysisDataSourceFor:(NSInteger)lenth indexDic:(NSArray <NSString *>*)indexs dataSource:(NSArray *)dataSource Bool:(BOOL)isIndex {

    NSMutableArray * indexArr = [NSMutableArray array];
    if (indexs.count < 1) {
        for (int i = 0; i< lenth; i++) {
            [indexArr addObject:[NSString stringWithFormat:@"%2d", i]];
        }
    }else {
        if (isIndex) {
            for (int i = 0; i< lenth; i++) {
                [indexArr addObject:dataSource[i]];
            }
            NSMutableArray * muDataSource = [NSMutableArray arrayWithArray:dataSource];
            [muDataSource removeObjectsInRange:NSMakeRange(0, lenth)];
            dataSource = muDataSource;
        }else {
            [indexArr addObjectsFromArray:indexs];
        }
    }

    /*
     indexArr 目录顺序索引
     dataSource 不带目录的（顺序索引）的数据源
     */
    NSMutableArray * modelsTemp = [NSMutableArray array];
    NSMutableArray * dataSourceTemp = [NSMutableArray array];
    for (int i = 0; i < dataSource.count/lenth; i++) {
        [dataSourceTemp removeAllObjects];
        for (int j = 0; j < lenth; j++) {
            [dataSourceTemp addObject:dataSource[i * lenth + j]];
        }
        XmlDataSourceModel * model = [[XmlDataSourceModel alloc] init];
        [model initDataSourceOfIndexPath:indexArr dataSource:dataSourceTemp];
        [modelsTemp addObject:model];
    }
    return modelsTemp;
}



@end
