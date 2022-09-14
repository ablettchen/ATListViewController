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
@property (nonatomic, strong) __kindof ATTableViewModel *tableViewModel;
@property (nonatomic, strong) __kindof ATTableViewHandler *tableViewHandler;
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
        _atTableView.dataSource = self.dataSource;
        _atTableView.delegate = self.delegate;
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

- (id <UITableViewDataSource>)dataSource {
    return self.tableViewModel;
}

- (id <UITableViewDelegate>)delegate {
    return self.tableViewModel;
}

- (id <ATCellActionProtocal>)cellAction {
    return self.tableViewHandler;
}

- (NSMutableArray<id <ATSectionProtocal>> *)sections {
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (ATTableViewModel *)tableViewModel {
    if (!_tableViewModel) {
        _tableViewModel = ATTableViewModel.new;
        _tableViewModel.view = self.view;
        _tableViewModel.tableView = self.atTableView;
        _tableViewModel.cellAction = self.cellAction;
        _tableViewModel.sections = self.sections;
    }
    return _tableViewModel;
}

- (ATTableViewHandler *)tableViewHandler {
    if (!_tableViewHandler) {
        _tableViewHandler = ATTableViewHandler.new;
    }
    return _tableViewHandler;
}

- (void)finished:(NSError * _Nullable)error
         section:(NSArray <id <ATSectionProtocal>> *)sections
      nextPageId:(NSString * _Nullable)nextPageId {
    
    if (error == nil) {
        self.atTableView.atLoader.range.location = nextPageId;
        if (self.atTableView.atLoader.state == ATDataLoadStateRefresh) { [self.sections removeAllObjects]; }
        
        if (sections.count) {
            
            NSMutableArray <id <ATSectionProtocal>> *newSections = [NSMutableArray array];
            for (id <ATSectionProtocal> _Nonnull obj in sections) {
                id <ATSectionProtocal> _Nonnull targetObj = [self.tableViewModel sectionObjectWithIdentifier:obj.identifier];
                if (targetObj) { [targetObj.cellModels addObjectsFromArray:obj.cellModels]; } else { [newSections addObject:obj]; }
            }
            
            if (newSections.count) {
                [self.tableViewModel.sections addObjectsFromArray:newSections];
            }
        }
    }
    
    [self.atTableView.atLoader finished:error];
}


@end
