//
//  ATNewsCollectionSectionHeaderView.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/14.
//  Copyright © 2022 ablett. All rights reserved.
//

#import "ATNewsCollectionSectionHeaderView.h"
#import <Masonry/Masonry.h>


@interface ATNewsCollectionSectionHeaderView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreButton;
@end
@implementation ATNewsCollectionSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor.greenColor colorWithAlphaComponent:0.1];
        [self _prepareView];
    }
    return self;
}

- (UIEdgeInsets)seperatorInsets {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UIColor *)seperatorColor {
    return UIColor.blueColor;
}

#pragma mark - public

- (void)setCellModel:(id <ATCellModelProtocol>)cellModel {
    [super setCellModel:cellModel];
    
    if ([cellModel.cellData isKindOfClass:NSString.class]) {
        NSString *obj = cellModel.cellData;
        self.titleLabel.text = obj;
    }
}

#pragma mark - private

- (void)_prepareView {
    
    [self addSubview:self.moreButton];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).inset(16);
        make.top.bottom.equalTo(self);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).inset(16);
        make.right.equalTo(self.moreButton.mas_left).offset(-8);
        make.centerY.equalTo(self);
    }];
}

- (void)_moreButtonAction:(UIButton *)sender {
    
    if ([self.atDelegate respondsToSelector:@selector(atCell:action:)]) {
        [self.atDelegate atCell:self action:2001];
    }
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:0.87];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_moreButton setTitle:@"more" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor.blueColor colorWithAlphaComponent:0.87] forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor.blueColor colorWithAlphaComponent:0.54] forState:UIControlStateHighlighted];
        [_moreButton addTarget:self action:@selector(_moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

#pragma mark - setter

@end


@interface ATNewsCollectionSectionFooterView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ATNewsCollectionSectionFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor.redColor colorWithAlphaComponent:0.1];
        [self _prepareView];
    }
    return self;
}

- (BOOL)isShowSeperator {
    return NO;
}

#pragma mark - public

- (void)setCellModel:(id <ATCellModelProtocol>)cellModel {
    [super setCellModel:cellModel];
    
    if ([cellModel.cellData isKindOfClass:NSString.class]) {
        NSString *obj = cellModel.cellData;
        self.titleLabel.text = obj;
    }
}

#pragma mark - private

- (void)_prepareView {
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 16, 0, 16));
        make.centerY.equalTo(self);
    }];
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:0.54];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

@end
