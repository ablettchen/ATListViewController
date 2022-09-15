//
//  ATAlbumCollectionViewCell.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/14.
//  Copyright © 2022 ablett. All rights reserved.
//

#import "ATAlbumCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import "ATAlbum.h"

@interface ATAlbumCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ATAlbumCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _prepareView];
        [self _bindMethod];
    }
    return self;
}

- (UIColor *)seperatorColor {
    return UIColor.blueColor;
}

#pragma mark - public

- (void)setCellModel:(id <ATCellModelProtocol>)model {
    [super setCellModel:model];
    
    if ([model isKindOfClass:ATAlbumCellModel.class]) {
        
        ATAlbumCellModel *cellModel = model;
        
        NSURL *imageUrl = [NSURL URLWithString:cellModel.cellData.url];
        [self.imageView sd_setImageWithURL:imageUrl];
    }
}

#pragma mark - private

- (void)_prepareView {
    
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
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

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = [UIColor.blueColor colorWithAlphaComponent:0.1];
    }
    return _imageView;
}

#pragma mark - setter


@end
