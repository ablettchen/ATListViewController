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

@property (nonatomic, copy, nullable) NSString *identifier;     // 唯一标识
@property (nonatomic, copy, nullable) NSString *title;          // 标题
@property (nonatomic, copy, nullable) NSString *subTitle;       // 子标题
@property (nonatomic, strong, nonnull) NSMutableArray <id<ATCellModelProtocol>>*cellModels;   // 列表

@property (nonatomic, assign) BOOL isPageList;                  // 是否为分页列表（区别于本地Section）
@property (nonatomic, assign) NSUInteger section;               // section 序号

@property (nonatomic, strong) id <ATCellModelProtocol> headerModel;
@property (nonatomic, strong) id <ATCellModelProtocol> footerModel;

@end

NS_ASSUME_NONNULL_END
