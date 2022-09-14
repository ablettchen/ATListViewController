//
//  UITableViewCell+ATListViewController.h
//  ATListViewController
//
//  Created by ablett on 2022/9/13.
//

#import <UIKit/UIKit.h>
#import "ATCellProtocal.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (ATListViewController)
@property (nonatomic, weak, nullable) id <ATCellActionProtocal> atDelegate;
@end

@interface UITableViewHeaderFooterView (ATListViewController)
@property (nonatomic, weak, nullable) id <ATCellActionProtocal> atDelegate;
@end

@interface UICollectionViewCell (ATListViewController)
@property (nonatomic, weak, nullable) id <ATCellActionProtocal> atDelegate;
@end

@interface UICollectionReusableView (ATListViewController)
@property (nonatomic, weak, nullable) id <ATCellActionProtocal> atDelegate;
@end

NS_ASSUME_NONNULL_END
