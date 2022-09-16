//
//  ATCollectionViewModel.m
//  ATListViewController
//
//  Created by ablett on 2022/9/14.
//

#import "ATCollectionViewModel.h"
#import <Masonry/Masonry.h>


@interface ATCollectionViewModel ()
@property (nonatomic, strong) NSMutableDictionary <NSString *, Class> *registerPool;
@end

@implementation ATCollectionViewModel

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

#pragma mark - private

- (void)_registerClass:(Class _Nonnull)cellClass {
    
    NSString *identifier = NSStringFromClass(cellClass);
    [self _registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (void)_registerClass:(Class _Nonnull)cellClass forCellWithReuseIdentifier:(NSString * _Nonnull)identifier {
    
    id obj = [self.registerPool objectForKey:identifier];
    if (obj == nil) {
        [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
        [self.registerPool setValue:cellClass forKey:identifier];
    }
}

- (void)_registerClass:(Class _Nonnull)viewClass forSupplementaryViewOfKind:(NSString * _Nonnull)elementKind {
    
    NSString *identifier = NSStringFromClass(viewClass);
    [self _registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier];
}

- (void)    _registerClass:(Class _Nonnull)viewClass
forSupplementaryViewOfKind:(NSString * _Nonnull)elementKind
       withReuseIdentifier:(NSString * _Nonnull)identifier {
    
    id obj = [self.registerPool objectForKey:identifier];
    if (obj == nil) {
        [self.collectionView registerClass:viewClass
                forSupplementaryViewOfKind:elementKind
                       withReuseIdentifier:identifier];
        [self.registerPool setValue:viewClass forKey:identifier];
    }
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

#pragma mark - getter

- (NSMutableDictionary<NSString *,Class> *)registerPool {
    if (!_registerPool) {
        _registerPool = [NSMutableDictionary dictionary];
    }
    return _registerPool;
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
        [self _registerClass:cellClass];
        
        __kindof UICollectionViewCell <ATCellProtocal> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
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
        
        id <ATCellModelProtocol> viewModel;
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            viewModel = sectionObj.headerModel;
        }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            viewModel = sectionObj.footerModel;
        }
        
        if (viewModel) {
            Class viewClass = viewModel.cellClass;
            NSString *identifier = NSStringFromClass(viewClass);
            [self _registerClass:viewClass forSupplementaryViewOfKind:kind];
            
            __kindof UICollectionReusableView <ATCellProtocal> *view = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
            view = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
            
            [self _showSeperatorIfNeededInView:view];
            if (view.atDelegate == nil) { view.atDelegate = self.cellAction; }
            view.cellModel = viewModel;
            return view;
        }
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    id <ATCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    if ([self.cellAction respondsToSelector:@selector(atCell:didSelect:)]) {
        __kindof UICollectionViewCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
        if ([cell.class conformsToProtocol:@protocol(ATCellProtocal)]) {
            [self.cellAction atCell:cell didSelect:cellModel];
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
