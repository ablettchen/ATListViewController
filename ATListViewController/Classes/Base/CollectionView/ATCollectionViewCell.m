//
//  ATCollectionViewCell.m
//  ATListViewController
//
//  Created by ablett on 2022/9/9.
//

#import "ATCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface ATCollectionViewCell ()
@property (nonatomic, strong) UIView *seperator;
@end

@implementation ATCollectionViewCell

@synthesize cellModel = _cellModel;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _atPrepareViews];
    }
    return self;
}

#pragma mark - public

- (void)setCellModel:(id <ATCellModelProtocol>)cellModel {
    _cellModel = cellModel;
}

- (UIView *)seperator {
    if (!_seperator) {
        _seperator = UIView.new;
        _seperator.backgroundColor = self.seperatorColor;
    }
    return _seperator;
}

- (UIEdgeInsets)seperatorInsets {
    return UIEdgeInsetsMake(0, 16, 0, 16);
}

- (UIColor *)seperatorColor {
    return [UIColor.blackColor colorWithAlphaComponent:0.1];
}

- (BOOL)isShowSeperator {
    return NO;
}

- (BOOL)isHideLastSeperator {
    return YES;
}

#pragma mark - private

- (void)_atPrepareViews {
    
    if (self.isShowSeperator) {
        [self.contentView addSubview:self.seperator];
        [self.seperator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.contentView).insets(self.seperatorInsets);
            make.height.mas_equalTo(0.5);
        }];
    }
}

#pragma mark - getter

#pragma mark - setter

@end
