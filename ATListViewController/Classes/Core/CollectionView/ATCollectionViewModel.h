//
//  ATCollectionViewModel.h
//  ATListViewController
//
//  Created by ablett on 2022/9/14.
//

#import <Foundation/Foundation.h>
#import "ATSectionProtocal.h"
#import "ATListViewControllerExtensions.h"
#import <ATDataLoader/ATDataLoader.h>


NS_ASSUME_NONNULL_BEGIN

@interface ATCollectionViewModel : NSObject<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

// 视图
@property (nonatomic, weak, nullable) UIView *view;

// 列表视图
@property (nonatomic, weak, nullable) __kindof UICollectionView *collectionView;

// 列表分组数据
@property (nonatomic, weak, nullable) NSMutableArray <id <ATSectionProtocal>> *sections;

// cell 点击代理
@property (nonatomic, weak) id <ATCellActionProtocal> cellAction;

// 根据分组标识取分组对象
- (id <ATSectionProtocal> _Nullable)sectionObjectWithIdentifier:(NSString * _Nonnull)identifier;

// 根据分组序号取分组对象
- (id <ATSectionProtocal> _Nullable)sectionObjectInSection:(NSUInteger)section;

// 根据 indexPath 取 cellModel
- (id <ATCellModelProtocol> _Nullable)cellModelAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

// 根据 indexPath 取 cell 标识
- (NSString * _Nonnull)cellIdentifierAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

// 根据 indexPath 取 viewModel
- (id <ATCellModelProtocol> _Nullable)viewModelForSupplementaryViewOfKind:(NSString * _Nonnull)kind inSection:(NSUInteger)section;

// 根据 indexPath 取 view 标识
- (NSString * _Nonnull)viewIdentifierForSupplementaryViewOfKind:(NSString * _Nonnull)elementKind inSection:(NSUInteger)section;

@end

NS_ASSUME_NONNULL_END
