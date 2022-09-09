//
//  ATExampleTableViewCell.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/9.
//  Copyright © 2022 chenjungang. All rights reserved.
//

#import "ATExampleTableViewCell.h"
#import <Masonry/Masonry.h>

@interface ATExampleTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ATExampleTableViewCell

#pragma mark - override

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _prepareView];
    }
    return self;
}

- (UIColor *)seperatorColor {
    return UIColor.redColor;
}

#pragma mark - public

- (void)setCellModel:(id<ATCellModelProtocol>)cellModel {
    [super setCellModel:cellModel];
    
    if ([cellModel.cellData isKindOfClass:NSString.class]) {
        NSString *obj = cellModel.cellData;
        self.titleLabel.text = obj;
    }
}

+ (CGFloat)heightForCellModel:(id<ATCellModelProtocol>)cellModel {
    
    return 60;
}

#pragma mark - private

- (void)_prepareView {
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 16, 0, 16));
        make.centerY.equalTo(self.contentView);
    }];
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

#pragma mark - setter

@end
