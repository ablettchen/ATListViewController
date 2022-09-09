//
//  ATCollectionViewCell.m
//  ATListViewController
//
//  Created by ablett on 2022/9/9.
//

#import "ATCollectionViewCell.h"

@implementation ATCollectionViewCell

@synthesize cellModel = _cellModel;

+ (CGFloat)heightForCellModel:(id<ATCellModelProtocol>)cellModel {
    return 0.f;
}

@end
