//
//  ATCollectionReusableView.m
//  ATListViewController
//
//  Created by ablett on 2022/9/9.
//

#import "ATCollectionReusableView.h"

@implementation ATCollectionReusableView

@synthesize cellModel = _cellModel;

+ (CGFloat)heightForCellModel:(id<ATCellModelProtocol>)cellModel {
    return CGFLOAT_MIN;
}

@end