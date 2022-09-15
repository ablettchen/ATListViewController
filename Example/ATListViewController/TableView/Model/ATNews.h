//
//  ATNews.h
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/9.
//  Copyright © 2022 ablett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ATListViewController/ATListViewController.h>


NS_ASSUME_NONNULL_BEGIN


@interface ATNews : NSObject

@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *srcUrl;
@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, copy) NSString *coverLarge;

@end


@class ATNewsStyle;
@interface ATNewsCellModel : ATCellModel
@property (nonatomic, strong, nonnull) ATNews *cellData;
@property (nonatomic, strong) ATNewsStyle *cellStyle;
@end


@interface ATNewsStyle : ATCellStyle

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) UIEdgeInsets titleInsets;

@end

NS_ASSUME_NONNULL_END
