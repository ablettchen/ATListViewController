//
//  ATCellProtocal.h
//  ATTableViewController
//
//  Created by ablett on 2022/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - View

@protocol ATCellModelProtocol;
@protocol ATCellProtocal <NSObject>

@required
@property (nonatomic, strong, nullable) id<ATCellModelProtocol> cellModel;
+ (CGFloat)heightForCellModel:(id<ATCellModelProtocol> _Nullable)cellModel;

@end



#pragma mark - Data

@protocol ATCellStyleProtocal <NSObject>

@property (nonatomic, assign) CGFloat cellWidth;

@end

@protocol ATCellModelProtocol <NSObject>

@required
@property (nonatomic, strong, nonnull) Class<ATCellProtocal> cellClass;
@property (nonatomic, strong, nonnull) id cellData;
@property (nonatomic, strong) id<ATCellStyleProtocal> cellStyle;

#warning TODO
@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
