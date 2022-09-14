//
//  ATViewController.m
//  ATListViewController
//
//  Created by ablett on 09/09/2022.
//  Copyright (c) 2022 ablett. All rights reserved.
//

#import "ATViewController.h"
#import <Masonry/Masonry.h>
#import "ATExampleTableViewController.h"
#import "ATExampleCollectionViewController.h"

@interface ATViewController ()

@end

@implementation ATViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    
    UIButton *tableButton = [UIButton new];
    [tableButton setTitle:@"TableView" forState:UIControlStateNormal];
    [tableButton addTarget:self action:@selector(_tableButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    tableButton.backgroundColor = UIColor.blackColor;
    
    
    UIButton *collectionButton = [UIButton new];
    [collectionButton setTitle:@"CollectionView" forState:UIControlStateNormal];
    [collectionButton addTarget:self action:@selector(_collectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    collectionButton.backgroundColor = UIColor.blackColor;
    
    
    [self.view addSubview:tableButton];
    [tableButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).offset(-10);
        make.size.mas_equalTo(CGSizeMake(140, 60));
    }];
    
    [self.view addSubview:collectionButton];
    [collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_centerY).offset(10);
        make.size.mas_equalTo(CGSizeMake(140, 60));
    }];
    
}

- (void)_tableButtonAction:(UIButton *)sender {
    
    __kindof UIViewController *vc = ATExampleTableViewController.new;
    vc.navigationItem.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_collectionButtonAction:(UIButton *)sender {
    
    __kindof UIViewController *vc = ATExampleCollectionViewController.new;
    vc.navigationItem.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
