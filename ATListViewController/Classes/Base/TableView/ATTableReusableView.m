//
//  ATTableReusableView.m
//  ATListViewController
//
//  Created by ablett on 2022/9/9.
//

#import "ATTableReusableView.h"
#import <Masonry/Masonry.h>

@interface ATTableReusableView ()
@property (nonatomic, strong) UIView *seperator;
@end

@implementation ATTableReusableView

@synthesize cellModel = _cellModel;

#pragma mark - override

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
    return YES;
}

#pragma mark - private

- (void)_atPrepareViews {
    
}

#pragma mark - getter

#pragma mark - setter


@end
