//
//  ATNewsViewModel.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/9.
//  Copyright © 2022 ablett. All rights reserved.
//

#import "ATNewsViewModel.h"
#import "ATNewsTableViewCell.h"
#import "ATNewsTableSectionHeaderView.h"
#import "ATNews.h"


NS_INLINE id fetchFakeData(NSString *resource) {
    
    if (!resource) return nil;
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:resource ofType:@"JSON"];
    if (!jsonPath || jsonPath.length == 0) {
        return nil;
    }
    NSURL *jsonURL = [NSURL fileURLWithPath:jsonPath];
    if (!jsonURL) {
        return nil;
    }
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL];
    if (!jsonData) {
        return nil;
    }
    NSError *error;
    id response = [NSJSONSerialization JSONObjectWithData:jsonData
                                                  options:NSJSONReadingFragmentsAllowed
                                                    error:&error];
    if (error) {
        return nil;
    }
    return response;
}


@implementation ATNewsViewModel

- (void)requestData:(NSDictionary * _Nonnull)params
         completion:(void(^ _Nonnull)(NSError * _Nullable error, NSArray <id <ATSectionProtocal>> * _Nullable datas, NSString * _Nullable nextId))completion {
    
    [self _requestNewsData:params
                completion:^(NSError * _Nullable error, ATList * _Nullable list) {
        
        NSString *nextId = [params valueForKey:@"nextId"];
        BOOL isFirstPage = nextId == nil || nextId.length == 0;
        
        ATSection *sectionObj = [ATSection new];
        sectionObj.identifier = isFirstPage ? @"1" : @"2";
        sectionObj.section = isFirstPage ? 0 : 1;
        sectionObj.isPageList = list.lastPage;
        
        NSMutableArray<id <ATCellModelProtocol>> *cellModels = [NSMutableArray array];
        
        [list.data enumerateObjectsUsingBlock:^(ATNews * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            
            ATNewsCellModel *cellModel = ATNewsCellModel.new;
            cellModel.cellClass = ATNewsTableViewCell.class;
            cellModel.cellData = obj;
            
            ATNewsStyle *style = ATNewsStyle.new;
            
            CGFloat titleWidth = style.cellWidth = style.cellWidth - style.titleInsets.left - style.titleInsets.right;
            CGFloat titleHeight = [obj.title boundingRectWithSize:CGSizeMake(titleWidth, HUGE)
                                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                       attributes:@{NSFontAttributeName: style.titleFont} context:nil].size.height;
            
            CGFloat cellHeight = 0;
            cellHeight += style.titleInsets.top;
            cellHeight += ceil(titleHeight);
            cellHeight += style.titleInsets.bottom;
            
            cellModel.cellStyle = style;
            cellModel.cellHeight = cellHeight;
            
            [cellModels addObject:cellModel];
        }];
        
        sectionObj.cellModels = cellModels;
        
        
        {
            ATCellStyle *style = ATCellStyle.new;
            style.cellWidth = UIScreen.mainScreen.bounds.size.width;
            
            ATCellModel *cellModel = ATCellModel.new;
            cellModel.cellData = isFirstPage? @"section header 0" : @"section header 1";
            cellModel.cellClass = ATNewsTableSectionHeaderView.class;
            cellModel.cellStyle = style;
            cellModel.cellHeight = 60.f;
            sectionObj.headerModel = cellModel;
        }
        
        {
            ATCellStyle *style = ATCellStyle.new;
            style.cellWidth = UIScreen.mainScreen.bounds.size.width;
            
            ATCellModel *cellModel = ATCellModel.new;
            cellModel.cellData = isFirstPage ? @"section footer 0" : @"section footer 1";
            cellModel.cellClass = ATExampleTableSectionFooterView.class;
            cellModel.cellStyle = style;
            cellModel.cellHeight = 30.f;
            sectionObj.footerModel = cellModel;
        }
        
        completion(nil, @[sectionObj], list.lastPage ? nil : list.nextId);
        
    }];
}


- (void)_requestNewsData:(NSDictionary * _Nonnull)params
         completion:(void(^ _Nonnull)(NSError * _Nullable error, ATList * _Nullable list))completion {
    
    [self __requestNewsData:params
                 completion:^(NSError * _Nullable error, id  _Nullable response) {
        
        ATList *list = [ATList yy_modelWithJSON:response];
        list.data = [NSArray yy_modelArrayWithClass:ATNews.class json:list.data];
        completion(error, list);
    }];
}

- (void)__requestNewsData:(NSDictionary * _Nonnull)params
         completion:(void(^ _Nonnull)(NSError * _Nullable error, id _Nullable response))completion {

    NSString *nextId = [params valueForKey:@"nextId"];
    
    NSError *error = [NSError errorWithDomain:@"" code:400 userInfo:@{NSLocalizedDescriptionKey: @"请求失败"}];
    id resp = fetchFakeData(@"NewsP1");
    if ([nextId isEqualToString:@"2;1663043649731"]) {
        resp = fetchFakeData(@"NewsP2");
    }else if ([nextId isEqualToString:@"3;1663043649731"]) {
        resp = fetchFakeData(@"NewsP3");
    }
    
    completion(resp?nil:error, resp);
}

@end
