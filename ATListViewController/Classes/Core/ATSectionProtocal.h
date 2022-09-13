//
//  ATSectionProtocal.h
//  ATTableViewController
//
//  Created by ablett on 2022/9/9.
//

#import <Foundation/Foundation.h>
#import "ATCellProtocal.h"


NS_ASSUME_NONNULL_BEGIN

@protocol ATSectionProtocal <NSObject>

// 唯一标识
@property (nonatomic, copy, nullable) NSString *identifier;

// 列表
@property (nonatomic, strong, nonnull) NSMutableArray <id<ATCellModelProtocol>>*cellModels;

// 是否为分页列表（区别于本地Section）
@property (nonatomic, assign) BOOL isPageList;

// section 序号
@property (nonatomic, assign) NSUInteger section;

// header model
@property (nonatomic, strong) id <ATCellModelProtocol> headerModel;

// footer model
@property (nonatomic, strong) id <ATCellModelProtocol> footerModel;

@end

NS_ASSUME_NONNULL_END
