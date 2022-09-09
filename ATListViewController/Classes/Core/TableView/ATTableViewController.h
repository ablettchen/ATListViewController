//
//  ATTableViewController.h
//  ATTableViewController
//
//  Created by ablett on 2022/9/9.
//

#import <UIKit/UIKit.h>
#import "ATSectionProtocal.h"
#import <ATDataLoader/ATDataLoader.h>


NS_ASSUME_NONNULL_BEGIN

@interface ATTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly, nonnull) __kindof UITableView *atTableView;
@property (nonatomic, assign, readonly) enum UITableViewStyle style;
@property (nonatomic, strong, nonnull) NSMutableArray <id<ATSectionProtocal, ATCellModelProtocol>> *sections;

- (id<ATSectionProtocal, ATCellModelProtocol> _Nullable)sectionObjectWithIdentifier:(NSString * _Nonnull)identifier;
- (id<ATSectionProtocal, ATCellModelProtocol> _Nullable)sectionObjectInSection:(NSUInteger)section;
- (id<ATCellModelProtocol> _Nullable)cellModelAtIndexPath:(NSIndexPath * _Nonnull)indexPath;


- (void)finished:(NSError * _Nullable)error
         section:(NSArray <id<ATSectionProtocal, ATCellModelProtocol>> *)sections
      nextPageId:(NSString * _Nullable)nextPageId;

@end

NS_ASSUME_NONNULL_END
