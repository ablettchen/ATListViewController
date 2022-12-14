//
//  ATCollectionViewController.m
//  ATListViewController
//
//  Created by ablett on 2022/9/9.
//

#import "ATCollectionViewController.h"
#import <Masonry/Masonry.h>


@interface ATCollectionViewController ()
@property (nonatomic, strong) __kindof UICollectionView *atCollectionView;
@property (nonatomic, strong) __kindof UICollectionViewFlowLayout *atCollectionViewLayout;
@property (nonatomic, strong) __kindof ATCollectionViewModel *collectionViewModel;
@property (nonatomic, strong) __kindof ATCollectionViewHandler *collectionViewHandler;
@end

@implementation ATCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.atCollectionView];
    [self.atCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - public

- (__kindof UICollectionView *)atCollectionView {
    if (!_atCollectionView) {
        _atCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                               collectionViewLayout:self.atCollectionViewLayout];
        _atCollectionView.backgroundColor = UIColor.atFromHex(0xf4f4f4);
        CGFloat bottonInset = 0;
        if (@available(iOS 11.0, *)) {
            bottonInset = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.bottom;
        }
        _atCollectionView.contentInset = UIEdgeInsetsMake(0, 0, bottonInset, 0);
        _atCollectionView.dataSource = self.dataSource;
        _atCollectionView.delegate = self.delegate;
        
    }
    return _atCollectionView;
}

- (enum UICollectionViewScrollDirection)scrollDirection {
    return UICollectionViewScrollDirectionVertical;
}

- (__kindof UICollectionViewFlowLayout *)atCollectionViewLayout {
    if (!_atCollectionViewLayout) {
        _atCollectionViewLayout = UICollectionViewFlowLayout.new;
        _atCollectionViewLayout.scrollDirection = self.scrollDirection;
    }
    return _atCollectionViewLayout;
}

- (id <UICollectionViewDataSource>)dataSource {
    return self.collectionViewModel;
}

- (id <UICollectionViewDelegate>)delegate {
    return self.collectionViewModel;
}

- (id <ATCellActionProtocal>)cellAction {
    return self.collectionViewHandler;
}

- (NSMutableArray<id <ATSectionProtocal>> *)sections {
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (__kindof ATCollectionViewModel *)collectionViewModel {
    if (!_collectionViewModel) {
        _collectionViewModel = ATCollectionViewModel.new;
        _collectionViewModel.view = self.view;
        _collectionViewModel.collectionView = self.atCollectionView;
        _collectionViewModel.cellAction = self.cellAction;
        _collectionViewModel.sections = self.sections;
    }
    return _collectionViewModel;
}

- (__kindof ATCollectionViewHandler *)collectionViewHandler {
    if (!_collectionViewHandler) {
        _collectionViewHandler = ATCollectionViewHandler.new;
    }
    return _collectionViewHandler;
}

- (void)finished:(NSError * _Nullable)error
         section:(NSArray <id <ATSectionProtocal>> *)sections
      nextPageId:(NSString * _Nullable)nextPageId {
    
    if (error == nil) {
        self.atCollectionView.atLoader.range.location = nextPageId;
        if (self.atCollectionView.atLoader.state == ATDataLoadStateRefresh) { [self.sections removeAllObjects]; }
        
        if (sections.count) {
            
            NSMutableArray <id <ATSectionProtocal>> *newSections = [NSMutableArray array];
            for (id <ATSectionProtocal> _Nonnull obj in sections) {
                id <ATSectionProtocal> _Nonnull targetObj = [self.collectionViewModel sectionObjectWithIdentifier:obj.identifier];
                if (targetObj) { [targetObj.cellModels addObjectsFromArray:obj.cellModels]; }else { [newSections addObject:obj]; }
            }
            
            if (newSections.count) {
                [self.collectionViewModel.sections addObjectsFromArray:newSections];
            }
        }
    }
    
    [self.atCollectionView.atLoader finished:error];
}


@end
