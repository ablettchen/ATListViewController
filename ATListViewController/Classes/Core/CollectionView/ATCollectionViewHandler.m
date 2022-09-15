//
//  ATCollectionViewHandler.m
//  ATListViewController
//
//  Created by ablett on 2022/9/14.
//

#import "ATCollectionViewHandler.h"

@implementation ATCollectionViewHandler

#pragma mark - ATCellActionProtocal

- (void)atCell:(__kindof id <ATCellProtocal>)cell action:(NSUInteger)action {}

- (void)atCell:(__kindof id <ATCellProtocal>)cell didSelect:(id <ATCellModelProtocol>)cellModel {}

@end
