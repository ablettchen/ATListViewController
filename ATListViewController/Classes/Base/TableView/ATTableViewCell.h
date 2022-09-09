//
//  ATTableViewCell.h
//  ATListViewController
//
//  Created by ablett on 2022/9/9.
//

#import <UIKit/UIKit.h>
#import "ATCellProtocal.h"

NS_ASSUME_NONNULL_BEGIN

@interface ATTableViewCell : UITableViewCell<ATCellProtocal>

- (UIEdgeInsets)seperatorInsets;
- (UIColor *)seperatorColor;
- (BOOL)isShowSeperator;

@end

NS_ASSUME_NONNULL_END
