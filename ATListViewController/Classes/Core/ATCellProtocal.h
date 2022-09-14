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

// cell Model
@property (nonatomic, strong, nullable) id <ATCellModelProtocol> cellModel;


@optional

// 分隔线
- (UIView *)seperator;

// 分割线边距，默认16
- (UIEdgeInsets)seperatorInsets;

// 分隔线颜色，默认黑色0.1
- (UIColor *)seperatorColor;

// 是否显示分隔线，默认 YES
- (BOOL)isShowSeperator;

// 是否隐藏最后一个分隔线，默认 YES（仅对cell有效）
- (BOOL)isHideLastSeperator;

@end



#pragma mark - Data

@protocol ATCellStyleProtocal <NSObject>

// cell宽
@property (nonatomic, assign) CGFloat cellWidth;

@end

@protocol ATCellModelProtocol <NSObject>

@required

// cell 类
@property (nonatomic, strong, nonnull) Class <ATCellProtocal> cellClass;

// cell 数据
@property (nonatomic, strong, nonnull) id cellData;

// cell 样式
@property (nonatomic, strong) id <ATCellStyleProtocal> cellStyle;

// cell 高度
@property (nonatomic, assign) CGFloat cellHeight;

@end



#pragma mark - Action

@protocol ATCellActionProtocal <NSObject>

@optional

// 点击事件 action:事件类型
- (void)atCell:(__kindof id <ATCellProtocal>)cell action:(NSUInteger)action;

// 点击cell
- (void)didSelect:(id <ATCellModelProtocol>)cellModel atCell:(__kindof id <ATCellProtocal>)cell;

@end

NS_ASSUME_NONNULL_END
