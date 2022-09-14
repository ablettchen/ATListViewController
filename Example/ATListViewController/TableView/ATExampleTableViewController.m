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

- (enum UITableViewStyle)style {
    return UITableViewStyleGrouped;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    __weak typeof(self) wSelf = self;
    
    [self.atTableView atUpdateLoadConf:^(ATDataLoadConf * _Nonnull conf) {
        conf.component = ATDataLoadComponentRefresh | ATDataLoadComponentLoadMore;
    }];
    
    [self.atTableView atLoadData:^(ATDataLoader * _Nonnull loader) {
        
        [wSelf.viewModel requestData:loader.rangeDic
                          completion:^(NSError * _Nullable error, NSArray<id<ATSectionProtocal, ATCellModelProtocol>> * _Nullable datas, NSString * _Nullable nextId) {
            [wSelf finished:error section:datas nextPageId:nextId];
        }];
        
    }];
}

- (id <ATCellActionProtocal>)cellAction {
    return self;
}

- (void)atCell:(__kindof id <ATCellProtocal>)cell action:(NSUInteger)action {
    
    if ([cell.cellModel isKindOfClass:ATNewsCellModel.class]) {
        ATNewsCellModel *cellModel = cell.cellModel;
        NSLog(@"%tu - %@", action, cellModel.cellData.title);
    }else if ([cell.cellModel isKindOfClass:ATCellModel.class]) {
        ATCellModel *cellModel = cell.cellModel;
        NSLog(@"%tu - %@", action, cellModel.cellData);
    }
}

#pragma mark - public

#pragma mark - private

#pragma mark - getter

#pragma mark - setter

- (ATNewsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = ATNewsViewModel.new;
    }
    return _viewModel;
}

@end
