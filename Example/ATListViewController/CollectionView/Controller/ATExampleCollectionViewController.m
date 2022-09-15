//
//  ATExampleCollectionViewController.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/14.
//  Copyright © 2022 ablett. All rights reserved.
//

#import "ATExampleCollectionViewController.h"
#import "ATAlbumViewModel.h"
#import "ATAlbum.h"


@interface ATExampleCollectionViewController ()<ATCellActionProtocal>
@property (nonatomic, strong) ATAlbumViewModel *viewModel;
@end

@implementation ATExampleCollectionViewController

#pragma mark - override

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _prepareView];
    [self _prepareData];
}

- (id <ATCellActionProtocal>)cellAction {
    return self;
}

#pragma mark - public

#pragma mark - private

- (void)_prepareView {
    
    self.view.backgroundColor = UIColor.whiteColor;
    CGFloat spacing = ATAlbumStyle.spacing;
    self.atCollectionView.contentInset = UIEdgeInsetsMake(0, spacing, 0, spacing);
}

- (void)_prepareData {
    
    __weak typeof(self) wSelf = self;
    
    [self.atCollectionView atUpdateLoadConf:^(ATDataLoadConf * _Nonnull conf) {
        conf.component = ATDataLoadComponentRefresh | ATDataLoadComponentLoadMore;
    }];
    
    [self.atCollectionView atLoadData:^(ATDataLoader * _Nonnull loader) {
        
        [wSelf.viewModel requesAlbumData:loader.rangeDic
                              completion:^(NSError * _Nullable error, NSArray<id <ATSectionProtocal>> * _Nullable datas, NSString * _Nullable nextId) {
            [wSelf finished:error section:datas nextPageId:nextId];
        }];
    }];
}

#pragma mark - getter

- (ATAlbumViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = ATAlbumViewModel.new;
    }
    return _viewModel;
}

#pragma mark - setter

#pragma mark - ATCellActionProtocal

- (void)atCell:(__kindof id <ATCellProtocal>)cell action:(NSUInteger)action {
    
    if ([cell.cellModel isKindOfClass:ATAlbumCellModel.class]) {
        ATAlbumCellModel *cellModel = cell.cellModel;
        NSLog(@"%tu - %@", action, cellModel.cellData.url);
    }else if ([cell.cellModel isKindOfClass:ATCellModel.class]) {
        ATCellModel *cellModel = cell.cellModel;
        NSLog(@"%tu - %@", action, cellModel.cellData);
    }
}

@end
