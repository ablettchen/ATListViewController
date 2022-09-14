//
//  ATCollectionViewModel.m
//  ATListViewController
//
//  Created by ablett on 2022/9/14.
//

#import "ATCollectionViewModel.h"
#import <Masonry/Masonry.h>

@implementation ATCollectionViewModel

#pragma mark - private


- (__kindof UICollectionReusableView <ATCellProtocal> * _Nullable)_dequeueReusableSupplementaryViewWithKind:(NSString * _Nullable)kind atIndexPath:(NSIndexPath *)indexPath {
    
    id <ATSectionProtocal> sectionObj = [self sectionObjectInSection:indexPath.section];
    
    if (sectionObj) {
        Class viewClass;
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            viewClass = sectionObj.headerModel.cellClass;
        }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            viewClass = sectionObj.footerModel.cellClass;
        }
        
        if (viewClass) {
            NSString *identifier = NSStringFromClass(viewClass);
            __kindof UICollectionReusableView <ATCellProtocal> *view = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
            if (!view) { [self.collectionView registerClass:viewClass forSupplementaryViewOfKind:kind withReuseIdentifier:identifier]; }
            view = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
            return view;
        }
    }
    
    return nil;
}

- (void)_showSeperatorIfNeededInView:(__kindof UICollectionReusableView <ATCellProtocal> *)view {
    
    if (view.isShowSeperator) {
        if (view.seperator) {
            if (view.seperator.superview == nil) {
                [view addSubview:view.seperator];
                [view.seperator mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.bottom.right.equalTo(view).insets(view.seperatorInsets);
                    make.height.mas_equalTo(0.5);
                }];
            }
        }
    }
}


#pragma mark - public

- (id <ATSectionProtocal> _Nullable)sectionObjectInSection:(NSUInteger)section {
    
    if (section < self.sections.count) {
        id <ATSectionProtocal> sectionObj = [self.sections objectAtIndex:section];
        return sectionObj;
    }
    
    return nil;
}

- (id <ATSectionProtocal> _Nullable)sectionObjectWithIdentifier:(NSString * _Nonnull)identifier {
    
    __block id <ATSectionProtocal> sectionObj;
    [self.sections enumerateObjectsUsingBlock:^(id <ATSectionProtocal>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section < self.sections.count) {
        id <ATSectionProtocal> sectionObj = [self.sections objectAtIndex:section];
        return sectionObj.cellModels.count;
    }
    
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id <ATCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    
    if (cellModel) {
        Class <ATCellProtocal> cellClass = cellModel.cellClass;
        NSString *identifier = NSStringFromClass(cellClass);
        
        __kindof UICollectionViewCell <ATCellProtocal> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if (!cell) {
            [collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        }
        
        if (cell.atDelegate == nil) { cell.atDelegate = self.cellAction; }
        cell.cellModel = cellModel;
        return cell;
    }
    
    UICollectionViewCell *blankCell = UICollectionViewCell.new;
    return blankCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    id <ATSectionProtocal> sectionObj = [self sectionObjectInSection:indexPath.section];
    
    if (sectionObj) {
        __kindof UICollectionReusableView <ATCellProtocal> *view = [self _dequeueReusableSupplementaryViewWithKind:kind atIndexPath:indexPath];
        if (view) {
            [self _showSeperatorIfNeededInView:view];
            if (view.atDelegate == nil) { view.atDelegate = self.cellAction; }
            view.cellModel = sectionObj.headerModel;
        }
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    id <ATCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    if ([self.cellAction respondsToSelector:@selector(didSelect:atCell:)]) {
        __kindof UICollectionViewCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
        if ([cell.class conformsToProtocol:@protocol(ATCellProtocal)]) {
            [self.cellAction didSelect:cellModel atCell:cell];
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id <ATCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    
    if (cellModel) {
        return CGSizeMake(cellModel.cellStyle.cellWidth, cellModel.cellHeight);
    }
    
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    id <ATSectionProtocal> sectionObj = [self sectionObjectInSection:section];

    if (sectionObj) {
        return CGSizeMake(sectionObj.headerModel.cellStyle.cellWidth, sectionObj.headerModel.cellHeight);
    }
    
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    id <ATSectionProtocal> sectionObj = [self sectionObjectInSection:section];
    
    if (sectionObj) {
        return CGSizeMake(sectionObj.footerModel.cellStyle.cellWidth, sectionObj.footerModel.cellHeight);
    }
    
    return CGSizeZero;
}

@end
