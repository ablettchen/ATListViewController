//
//  ATTableViewController.h
//  ATListViewController
//
//  Created by ablett on 2022/9/9.
//

#import <UIKit/UIKit.h>
#import "ATSectionProtocal.h"
#import "ATListViewControllerExtensions.h"
#import <ATDataLoader/ATDataLoader.h>


NS_ASSUME_NONNULL_BEGIN

@interface ATTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ATCellActionProtocal>

// 列表视图
@property (nonatomic, strong, readonly, nonnull) __kindof UITableView *atTableView;

// 列表样式
@property (nonatomic, assign, readonly) enum UITableViewStyle style;

// 列表分组数据
@property (nonatomic, strong, nonnull) NSMutableArray <id<ATSectionProtocal, ATCellModelProtocol>> *sections;

// 根据分组标识取分组对象
- (id<ATSectionProtocal, ATCellModelProtocol> _Nullable)sectionObjectWithIdentifier:(NSString * _Nonnull)identifier;

// 根据分组序号取分组对象
- (id<ATSectionProtocal, ATCellModelProtocol> _Nullable)sectionObjectInSection:(NSUInteger)section;

// 根据 indexPath 取 cellModel
- (id<ATCellModelProtocol> _Nullable)cellModelAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

// cell 点击代理
- (id<ATCellActionProtocal> _Nullable)cellDelegate;

// 结束加载
- (void)finished:(NSError * _Nullable)error
         section:(NSArray <id<ATSectionProtocal, ATCellModelProtocol>> *)sections
      nextPageId:(NSString * _Nullable)nextPageId;

@end

NS_ASSUME_NONNULL_END
