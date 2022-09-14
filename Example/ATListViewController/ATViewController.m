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

@interface ATViewController ()

@end

@implementation ATViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    
    UIButton *buttton = [UIButton new];
    [buttton setTitle:@"TableView" forState:UIControlStateNormal];
    [buttton addTarget:self action:@selector(_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    buttton.backgroundColor = UIColor.blackColor;
    
    
    [self.view addSubview:buttton];
    [buttton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    
}

- (void)_buttonAction:(UIButton *)sender {
    
    __kindof UIViewController *vc = ATExampleTableViewController.new;
    vc.navigationItem.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
