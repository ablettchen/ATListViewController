//
//  ATCollectionViewController.h
//  ATListViewController
//
//  Created by ablett on 2022/9/9.
//

#import <UIKit/UIKit.h>
#import "ATCollectionViewModel.h"
#import "ATCollectionViewHandler.h"


NS_ASSUME_NONNULL_BEGIN

@interface ATCollectionViewController : UIViewController

// 列表视图
@property (nonatomic, strong, readonly, nonnull) __kindof UICollectionView *atCollectionView;

// 列表布局
@property (nonatomic, strong, readonly, nonnull) __kindof UICollectionViewFlowLayout *atCollectionViewLayout;

// 列表数据源
@property (nonatomic, weak, nullable) id <UICollectionViewDataSource> dataSource;

// 列表代理
@property (nonatomic, weak, nullable) id <UICollectionViewDelegate> delegate;

// cell 点击代理
- (id<ATCellActionProtocal> _Nullable)cellAction;

// 列表分组数据
@property (nonatomic, strong, nonnull) NSMutableArray <id<ATSectionProtocal, ATCellModelProtocol>> *sections;

// 列表数据处理
@property (nonatomic, strong, readonly, nonnull) __kindof ATCollectionViewModel *collectionViewModel;

// 列表事件处理
@property (nonatomic, strong, readonly, nonnull) __kindof ATCollectionViewHandler *collectionViewHandler;

// 结束加载
- (void)finished:(NSError * _Nullable)error
         section:(NSArray <id<ATSectionProtocal, ATCellModelProtocol>> *)sections
      nextPageId:(NSString * _Nullable)nextPageId;


@end

NS_ASSUME_NONNULL_END
