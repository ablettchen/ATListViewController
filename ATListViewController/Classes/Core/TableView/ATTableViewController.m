//
//  ATTableViewController.m
//  ATListViewController
//
//  Created by ablett on 2022/9/9.
//

#import "ATTableViewController.h"
#import <Masonry/Masonry.h>


@interface ATTableViewController ()
@property (nonatomic, strong) __kindof UITableView *atTableView;
@end

@implementation ATTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.atTableView];
    [self.atTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - public

- (__kindof UITableView *)atTableView {
    if (!_atTableView) {
        _atTableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
        _atTableView.dataSource = self;
        _atTableView.delegate = self;
        _atTableView.backgroundColor = UIColor.atFromHex(0xf4f4f4);
        _atTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _atTableView.estimatedRowHeight = 0;
        _atTableView.estimatedSectionHeaderHeight = 0;
        _atTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 15.0, *)) {
            [UITableView appearance].sectionHeaderTopPadding = 0.f;
        }
    }
    return _atTableView;
}

- (enum UITableViewStyle)style {
    return UITableViewStylePlain;
}

- (NSMutableArray<id<ATSectionProtocal, ATCellModelProtocol>> *)sections {
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (id<ATSectionProtocal, ATCellModelProtocol> _Nullable)sectionObjectInSection:(NSUInteger)section {
    
    if (section < self.sections.count) {
        id<ATSectionProtocal, ATCellModelProtocol> sectionObj = [self.sections objectAtIndex:section];
        return sectionObj;
    }
    
    return nil;
}

- (id<ATSectionProtocal, ATCellModelProtocol> _Nullable)sectionObjectWithIdentifier:(NSString * _Nonnull)identifier {
    
    __block id<ATSectionProtocal, ATCellModelProtocol> sectionObj;
    [self.sections enumerateObjectsUsingBlock:^(id<ATSectionProtocal, ATCellModelProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:identifier]) {
            sectionObj = obj;
            *stop = YES;
        }
    }];
    
    return sectionObj;
}

- (id<ATCellModelProtocol> _Nullable)cellModelAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    
    if (indexPath.section < self.sections.count) {
        id<ATSectionProtocal> sectionObj = [self.sections objectAtIndex:indexPath.section];
        
        if (indexPath.row < sectionObj.cellModels.count) {
            
            id<ATCellModelProtocol>cellModel = [sectionObj.cellModels objectAtIndex:indexPath.row];
            return cellModel;
        }
    }
    
    return nil;
}

- (id<ATCellActionProtocal>)cellDelegate {
    return self;
}

- (void)finished:(NSError * _Nullable)error
         section:(NSArray <id<ATSectionProtocal, ATCellModelProtocol>> *)sections
      nextPageId:(NSString * _Nullable)nextPageId {
    
    if (error == nil) {
        self.atTableView.atLoader.range.location = nextPageId;
        if (self.atTableView.atLoader.state == ATDataLoadStateRefresh) { [self.sections removeAllObjects]; }
        
        if (sections.count) {
            
            NSMutableArray <id<ATSectionProtocal,ATCellModelProtocol>> *newSections = [NSMutableArray array];
            for (id<ATSectionProtocal,ATCellModelProtocol>  _Nonnull obj in sections) {
                id<ATSectionProtocal,ATCellModelProtocol>  _Nonnull targetObj = [self sectionObjectWithIdentifier:obj.identifier];
                if (targetObj) { [targetObj.cellModels addObjectsFromArray:obj.cellModels]; }else { [newSections addObject:obj]; }
            }
            
            if (newSections.count) {
                [self.sections addObjectsFromArray:newSections];
            }
        }
    }
    
    [self.atTableView.atLoader finished:error];
    
}

#pragma mark - private

- (__kindof UITableViewHeaderFooterView<ATCellProtocal> * _Nullable )_dequeueReusableHeaderFooterViewWithViewClass:(Class<ATCellProtocal> _Nonnull)viewClass {
    
    NSString *identifier = NSStringFromClass(viewClass);
    
    __kindof UITableViewHeaderFooterView<ATCellProtocal> *view = [self.atTableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!view) { [self.atTableView registerClass:viewClass forHeaderFooterViewReuseIdentifier:identifier]; } else { return view; }
    view = [self.atTableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    return view;
}

- (void)_showSeperatorIfNeededInCell:(__kindof UITableViewCell<ATCellProtocal> *)cell
                         atIndexPath:(NSIndexPath *)indexPath {
    
    if (cell.isShowSeperator) {
        if (cell.seperator) {
            if (cell.seperator.superview == nil) {
                [cell.contentView addSubview:cell.seperator];
                [cell.seperator mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.bottom.right.equalTo(cell.contentView).insets(cell.seperatorInsets);
                    make.height.mas_equalTo(0.5);
                }];
            }
            if (cell.isHideLastSeperator) {
                NSUInteger rowCount = [self.atTableView numberOfRowsInSection:indexPath.section];
                cell.seperator.hidden = rowCount - 1 == indexPath.row;
            }else {
                cell.seperator.hidden = NO;
            }
        }
    }
}

- (void)_showSeperatorIfNeededInView:(__kindof UITableViewHeaderFooterView<ATCellProtocal> *)view {
    
    if (view.isShowSeperator) {
        if (view.seperator) {
            if (view.seperator.superview == nil) {
                [view.contentView addSubview:view.seperator];
                [view.seperator mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.bottom.right.equalTo(view.contentView).insets(view.seperatorInsets);
                    make.height.mas_equalTo(0.5);
                }];
            }
        }
    }
}

#pragma mark - getter

#pragma mark - delegate

#pragma mark - ATCellActionProtocal

- (void)atCell:(__kindof UITableViewCell<ATCellProtocal> *)cell action:(NSUInteger)action {}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section < self.sections.count) {
        id<ATSectionProtocal> sectionObj = [self.sections objectAtIndex:section];
        return sectionObj.cellModels.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<ATCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    
    if (cellModel) {
        Class<ATCellProtocal> cellClass = cellModel.cellClass;
        NSString *identifier = NSStringFromClass(cellClass);
        
        __kindof UITableViewCell<ATCellProtocal> *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        }
        
        [self _showSeperatorIfNeededInCell:cell atIndexPath:indexPath];
        if (cell.atDelegate == nil) { cell.atDelegate = self.cellDelegate; }
        cell.cellModel = cellModel;
        return cell;
    }
    
    UITableViewCell *blankCell = UITableViewCell.new;
    return blankCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<ATCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    
    if (cellModel) {
        return cellModel.cellHeight;
    }
    
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    id<ATSectionProtocal, ATCellModelProtocol> sectionObj = [self sectionObjectInSection:section];
    
    if (sectionObj) {
        __kindof UITableViewHeaderFooterView<ATCellProtocal> *view = [self _dequeueReusableHeaderFooterViewWithViewClass:sectionObj.headerModel.cellClass];
        [self _showSeperatorIfNeededInView:view];
        if (view.atDelegate == nil) { view.atDelegate = self.cellDelegate; }
        view.cellModel = sectionObj.headerModel;
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    id<ATSectionProtocal, ATCellModelProtocol> sectionObj = [self sectionObjectInSection:section];
    
    if (sectionObj) {
        return sectionObj.headerModel.cellHeight;
    }
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    id<ATSectionProtocal, ATCellModelProtocol> sectionObj = [self sectionObjectInSection:section];
    
    if (sectionObj) {
        __kindof UITableViewHeaderFooterView<ATCellProtocal> *view = [self _dequeueReusableHeaderFooterViewWithViewClass:sectionObj.footerModel.cellClass];
        [self _showSeperatorIfNeededInView:view];
        if (view.atDelegate == nil) { view.atDelegate = self.cellDelegate; }
        view.cellModel = sectionObj.footerModel;
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    id<ATSectionProtocal, ATCellModelProtocol> sectionObj = [self sectionObjectInSection:section];
    
    if (sectionObj) {
        return sectionObj.footerModel.cellHeight;
    }
    
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
