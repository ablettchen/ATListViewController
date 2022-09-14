//
//  ATTableViewController.h
//  ATListViewController
//
//  Created by ablett on 2022/9/9.
//

#import <UIKit/UIKit.h>
#import "ATTableViewModel.h"
#import "ATTableViewHandler.h"


NS_ASSUME_NONNULL_BEGIN

@interface ATTableViewController : UIViewController

// 列表视图
@property (nonatomic, strong, readonly, nonnull) __kindof UITableView *atTableView;

// 列表样式
@property (nonatomic, assign, readonly) enum UITableViewStyle style;

// 列表数据源
@property (nonatomic, weak, nullable) id <UITableViewDataSource> dataSource;

// 列表代理
@property (nonatomic, weak, nullable) id <UITableViewDelegate> delegate;

// cell 点击代理
- (id<ATCellActionProtocal> _Nullable)cellAction;

// 列表分组数据
@property (nonatomic, strong, nonnull) NSMutableArray <id<ATSectionProtocal, ATCellModelProtocol>> *sections;

// 列表数据处理
@property (nonatomic, strong, readonly, nonnull) __kindof ATTableViewModel *tableViewModel;

// 列表事件处理
@property (nonatomic, strong, readonly, nonnull) __kindof ATTableViewHandler *tableViewHandler;


// 结束加载
- (void)finished:(NSError * _Nullable)error
         section:(NSArray <id<ATSectionProtocal, ATCellModelProtocol>> *)sections
      nextPageId:(NSString * _Nullable)nextPageId;

@end

NS_ASSUME_NONNULL_END
