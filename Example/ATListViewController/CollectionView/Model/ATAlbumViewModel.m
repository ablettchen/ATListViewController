//
//  ATAlbumViewModel.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/15.
//  Copyright © 2022 ablett. All rights reserved.
//

#import "ATAlbumViewModel.h"
#import <YYModel/YYModel.h>
#import "ATList.h"
#import "ATAlbum.h"

#import "ATAlbumCollectionViewCell.h"
#import "ATAlbumCollectionSectionHeaderView.h"

@implementation ATAlbumViewModel

#pragma mark - public


- (void)requesAlbumData:(NSDictionary * _Nonnull)params
             completion:(void(^ _Nonnull)(NSError * _Nullable error, NSArray <id <ATSectionProtocal>> * _Nullable datas, NSString * _Nullable nextId))completion {
    
    [self _requestAlbumData:params
                 completion:^(NSError * _Nullable error, ATList * _Nullable list) {
        
        NSString *nextId = [params valueForKey:@"nextId"];
        BOOL isFirstPage = nextId == nil || nextId.length == 0;
        
        ATSection *sectionObj = [ATSection new];
        sectionObj.identifier = isFirstPage ? @"1" : @"2";
        sectionObj.section = isFirstPage ? 0 : 1;
        sectionObj.isPageList = list.lastPage;
        
        NSMutableArray<id <ATCellModelProtocol>> *cellModels = [NSMutableArray array];
        
        [list.data enumerateObjectsUsingBlock:^(ATAlbum * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            ATAlbumCellModel *cellModel = ATAlbumCellModel.new;
            cellModel.cellClass = ATAlbumCollectionViewCell.class;
            cellModel.cellData = obj;
            
            ATAlbumStyle *style = ATAlbumStyle.new;
            
            cellModel.cellStyle = style;
            cellModel.cellHeight = cellModel.cellStyle.cellWidth;
            
            [cellModels addObject:cellModel];
        }];
        
        sectionObj.cellModels = cellModels;
        
        {
            ATCellStyle *style = ATCellStyle.new;
            style.cellWidth = UIScreen.mainScreen.bounds.size.width;
            
            ATCellModel *cellModel = ATCellModel.new;
            cellModel.cellData = isFirstPage? @"section header 0" : @"section header 1";
            cellModel.cellClass = ATAlbumCollectionSectionHeaderView.class;
            cellModel.cellStyle = style;
            cellModel.cellHeight = 60.f;
            sectionObj.headerModel = cellModel;
        }
        
        {
            ATCellStyle *style = ATCellStyle.new;
            style.cellWidth = UIScreen.mainScreen.bounds.size.width;
            
            ATCellModel *cellModel = ATCellModel.new;
            cellModel.cellData = isFirstPage ? @"section footer 0" : @"section footer 1";
            cellModel.cellClass = ATAlbumCollectionSectionFooterView.class;
            cellModel.cellStyle = style;
            cellModel.cellHeight = 30.f;
            sectionObj.footerModel = cellModel;
        }
        
        completion(nil, @[sectionObj], list.lastPage ? nil : list.nextId);
        
    }];
    
}

#pragma mark - private

- (void)_requestAlbumData:(NSDictionary * _Nonnull)params
               completion:(void(^ _Nonnull)(NSError * _Nullable error, ATList * _Nullable list))completion {
    
    [self __requestAlbumData:params
                  completion:^(NSError * _Nullable error, id  _Nullable response) {
        
        ATList *list = [ATList yy_modelWithJSON:response];
        list.data = [NSArray yy_modelArrayWithClass:ATAlbum.class json:list.data];
        completion(error, list);
    }];
}

- (void)__requestAlbumData:(NSDictionary * _Nonnull)params
                completion:(void(^ _Nonnull)(NSError * _Nullable error, id _Nullable response))completion {
    
    NSString *nextId = [params valueForKey:@"nextId"];
    
    NSError *error = [NSError errorWithDomain:@"" code:400 userInfo:@{NSLocalizedDescriptionKey: @"请求失败"}];
    id resp = fetchFakeData(@"AlbumP1");
    if ([nextId isEqualToString:@"1972"]) {
        resp = fetchFakeData(@"AlbumP2");
    }else if ([nextId isEqualToString:@"1962"]) {
        resp = fetchFakeData(@"AlbumP3");
    }
    
    completion(resp?nil:error, resp);
}

@end
