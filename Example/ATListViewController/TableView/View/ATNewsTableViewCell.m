//
//  ATNewsTableViewCell.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/9.
//  Copyright © 2022 ablett. All rights reserved.
//

#import "ATNewsTableViewCell.h"
#import <Masonry/Masonry.h>
#import "ATNews.h"

@interface ATNewsTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ATNewsTableViewCell

#pragma mark - override

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _prepareView];
        [self _bindMethod];
    }
    return self;
}

- (UIColor *)seperatorColor {
    return UIColor.redColor;
}

#pragma mark - public

- (void)setCellModel:(id<ATCellModelProtocol>)model {
    [super setCellModel:model];
    
    if ([model isKindOfClass:ATNewsCellModel.class]) {
        
        ATNewsCellModel *cellModel = model;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView).insets(cellModel.cellStyle.titleInsets);
            make.height.mas_equalTo(cellModel.cellHeight);
        }];
        
        self.titleLabel.font = cellModel.cellStyle.titleFont;
        self.titleLabel.text = cellModel.cellData.title;
    }
}

#pragma mark - private

- (void)_prepareView {
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 16, 0, 16));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)_bindMethod {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void)_tapAction:(UITapGestureRecognizer *)sender {
    
    if ([self.atDelegate respondsToSelector:@selector(atCell:action:)]) {
        [self.atDelegate atCell:self action:1001];
    }
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        _titleLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:0.87];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

#pragma mark - setter

@end
