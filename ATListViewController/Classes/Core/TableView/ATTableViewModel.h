//
//  ATTableViewModel.h
//  ATListViewController
//
//  Created by ablett on 2022/9/14.
//

#import <Foundation/Foundation.h>
#import "ATSectionProtocal.h"
#import "ATListViewControllerExtensions.h"
#import <ATDataLoader/ATDataLoader.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATTableViewModel : NSObject<UITableViewDataSource, UITableViewDelegate>

// 视图
@property (nonatomic, weak, nullable) UIView *view;

// 列表视图
@property (nonatomic, weak, nullable) __kindof UITableView *tableView;

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


@end

NS_ASSUME_NONNULL_END
