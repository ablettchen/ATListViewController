//
//  ATExampleTableViewController.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/9.
//  Copyright © 2022 ablett. All rights reserved.
//

#import "ATExampleTableViewController.h"
#import "ATNewsViewModel.h"
#import "ATNews.h"


@interface ATExampleTableViewController ()<ATCellActionProtocal>
@property (nonatomic, strong) ATNewsViewModel *viewModel;
@end

@implementation ATExampleTableViewController

#pragma mark - override

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _prepareView];
    [self _prepareData];
}

- (enum UITableViewStyle)style {
    return UITableViewStyleGrouped;
}

- (id <ATCellActionProtocal>)cellAction {
    return self;
}

#pragma mark - public

#pragma mark - private

- (void)_prepareView {
    
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)_prepareData {
    
    __weak typeof(self) wSelf = self;
    
    [self.atTableView atUpdateLoadConf:^(ATDataLoadConf * _Nonnull conf) {
        conf.component = ATDataLoadComponentRefresh | ATDataLoadComponentLoadMore;
    }];
    
    [self.atTableView atLoadData:^(ATDataLoader * _Nonnull loader) {
        
        [wSelf.viewModel requesTabletData:loader.rangeDic
                               completion:^(NSError * _Nullable error, NSArray<id <ATSectionProtocal>> * _Nullable datas, NSString * _Nullable nextId) {
            [wSelf finished:error section:datas nextPageId:nextId];
        }];
        
    }];
}

#pragma mark - getter

#pragma mark - setter

- (ATNewsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = ATNewsViewModel.new;
    }
    return _viewModel;
}

#pragma mark - ATCellActionProtocal

- (void)atCell:(__kindof id <ATCellProtocal>)cell action:(NSUInteger)action {
    
    if ([cell.cellModel isKindOfClass:ATNewsCellModel.class]) {
        ATNewsCellModel *cellModel = cell.cellModel;
        NSLog(@"%tu - %@", action, cellModel.cellData.title);
    }else if ([cell.cellModel isKindOfClass:ATCellModel.class]) {
        ATCellModel *cellModel = cell.cellModel;
        NSLog(@"%tu - %@", action, cellModel.cellData);
    }
}

@end
