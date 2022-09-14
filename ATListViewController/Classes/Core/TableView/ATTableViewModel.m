//
//  ATTableViewModel.m
//  ATListViewController
//
//  Created by ablett on 2022/9/14.
//

#import "ATTableViewModel.h"
#import <Masonry/Masonry.h>

@implementation ATTableViewModel

#pragma mark - private

- (__kindof UITableViewHeaderFooterView<ATCellProtocal> * _Nullable )_dequeueReusableHeaderFooterViewWithViewClass:(Class<ATCellProtocal> _Nonnull)viewClass {
    
    NSString *identifier = NSStringFromClass(viewClass);
    
    __kindof UITableViewHeaderFooterView<ATCellProtocal> *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!view) { [self.tableView registerClass:viewClass forHeaderFooterViewReuseIdentifier:identifier]; } else { return view; }
    view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
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
                NSUInteger rowCount = [self.tableView numberOfRowsInSection:indexPath.section];
                cell.seperator.hidden = rowCount - 1 == indexPath.row;
            }else {
                cell.seperator.hidden = NO;
            }
        }
    }
}

- (void)_showSeperatorIfNeededInView:(__kindof UITableViewHeaderFooterView <ATCellProtocal> *)view {
    
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

#pragma mark - public

- (id <ATSectionProtocal, ATCellModelProtocol> _Nullable)sectionObjectInSection:(NSUInteger)section {
    
    if (section < self.sections.count) {
        id<ATSectionProtocal, ATCellModelProtocol> sectionObj = [self.sections objectAtIndex:section];
        return sectionObj;
    }
    
    return nil;
}

- (id <ATSectionProtocal, ATCellModelProtocol> _Nullable)sectionObjectWithIdentifier:(NSString * _Nonnull)identifier {
    
    __block id<ATSectionProtocal, ATCellModelProtocol> sectionObj;
    [self.sections enumerateObjectsUsingBlock:^(id <ATSectionProtocal, ATCellModelProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:identifier]) {
            sectionObj = obj;
            *stop = YES;
        }
    }];
    
    return sectionObj;
}

- (id <ATCellModelProtocol> _Nullable)cellModelAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    
    if (indexPath.section < self.sections.count) {
        id <ATSectionProtocal> sectionObj = [self.sections objectAtIndex:indexPath.section];
        
        if (indexPath.row < sectionObj.cellModels.count) {
            
            id <ATCellModelProtocol> cellModel = [sectionObj.cellModels objectAtIndex:indexPath.row];
            return cellModel;
        }
    }
    
    return nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section < self.sections.count) {
        id <ATSectionProtocal> sectionObj = [self.sections objectAtIndex:section];
        return sectionObj.cellModels.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id <ATCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    
    if (cellModel) {
        Class<ATCellProtocal> cellClass = cellModel.cellClass;
        NSString *identifier = NSStringFromClass(cellClass);
        
        __kindof UITableViewCell<ATCellProtocal> *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        }
        
        [self _showSeperatorIfNeededInCell:cell atIndexPath:indexPath];
        if (cell.atDelegate == nil) { cell.atDelegate = self.cellAction; }
        cell.cellModel = cellModel;
        return cell;
    }
    
    UITableViewCell *blankCell = UITableViewCell.new;
    return blankCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id <ATCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    
    if (cellModel) {
        return cellModel.cellHeight;
    }
    
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    id <ATSectionProtocal, ATCellModelProtocol> sectionObj = [self sectionObjectInSection:section];
    
    if (sectionObj) {
        __kindof UITableViewHeaderFooterView<ATCellProtocal> *view = [self _dequeueReusableHeaderFooterViewWithViewClass:sectionObj.headerModel.cellClass];
        [self _showSeperatorIfNeededInView:view];
        if (view.atDelegate == nil) { view.atDelegate = self.cellAction; }
        view.cellModel = sectionObj.headerModel;
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    id <ATSectionProtocal, ATCellModelProtocol> sectionObj = [self sectionObjectInSection:section];
    
    if (sectionObj) {
        return sectionObj.headerModel.cellHeight;
    }
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    id <ATSectionProtocal, ATCellModelProtocol> sectionObj = [self sectionObjectInSection:section];
    
    if (sectionObj) {
        __kindof UITableViewHeaderFooterView<ATCellProtocal> *view = [self _dequeueReusableHeaderFooterViewWithViewClass:sectionObj.footerModel.cellClass];
        [self _showSeperatorIfNeededInView:view];
        if (view.atDelegate == nil) { view.atDelegate = self.cellAction; }
        view.cellModel = sectionObj.footerModel;
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    id <ATSectionProtocal, ATCellModelProtocol> sectionObj = [self sectionObjectInSection:section];
    
    if (sectionObj) {
        return sectionObj.footerModel.cellHeight;
    }
    
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id <ATCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    if ([self.cellAction respondsToSelector:@selector(didSelect:atCell:)]) {
        __kindof UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        if ([cell.class conformsToProtocol:@protocol(ATCellProtocal)]) {
            [self.cellAction didSelect:cellModel atCell:cell];
        }
    }
}

@end