//
//  ATExampleTableViewController.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/9.
//  Copyright © 2022 chenjungang. All rights reserved.
//

#import "ATExampleTableViewController.h"
#import "ATExampleViewModel.h"


@interface ATExampleTableViewController ()
@property (nonatomic, strong) ATExampleViewModel *viewModel;
@end

@implementation ATExampleTableViewController

#pragma mark - override

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    __weak typeof(self) wSelf = self;
    
    [self.atTableView atUpdateLoadConf:^(ATDataLoadConf * _Nonnull conf) {
        conf.component = ATDataLoadComponentRefresh;
    }];
    
    [self.atTableView atLoadData:^(ATDataLoader * _Nonnull loader) {
        
        [wSelf.viewModel requestData:loader.rangeDic
                          completion:^(NSError * _Nullable error, NSArray<id<ATSectionProtocal,ATCellModelProtocol>> * _Nullable datas) {
            [wSelf finished:error section:datas nextPageId:nil];
        }];
        
    }];
}

#pragma mark - public

#pragma mark - private

#pragma mark - getter

#pragma mark - setter

- (ATExampleViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = ATExampleViewModel.new;
    }
    return _viewModel;
}

@end
