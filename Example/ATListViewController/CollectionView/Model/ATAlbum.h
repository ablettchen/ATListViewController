//
//  ATAlbum.h
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/15.
//  Copyright © 2022 chenjungang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ATListViewController/ATListViewController.h>


NS_ASSUME_NONNULL_BEGIN

@interface ATAlbum : NSObject

@property (nonatomic, assign) NSInteger photoId;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *text;

@end


@class ATAlbumStyle;
@interface ATAlbumCellModel : ATCellModel

@property (nonatomic, strong, nonnull) ATAlbum *cellData;
@property (nonatomic, strong) ATAlbumStyle *cellStyle;

@end

@interface ATAlbumStyle : ATCellStyle

@property (nonatomic, assign) NSUInteger colum;
@property (nonatomic, assign) CGFloat spacing;

+ (CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
