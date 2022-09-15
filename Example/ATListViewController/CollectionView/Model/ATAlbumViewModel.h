//
//  ATAlbumViewModel.h
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/15.
//  Copyright © 2022 ablett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ATListViewController/ATListViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATAlbumViewModel : NSObject

- (void)requesAlbumData:(NSDictionary * _Nonnull)params
             completion:(void(^ _Nonnull)(NSError * _Nullable error, NSArray <id <ATSectionProtocal>> * _Nullable datas, NSString * _Nullable nextId))completion;

@end

NS_ASSUME_NONNULL_END
