//
//  ATExampleViewModel.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/9.
//  Copyright © 2022 chenjungang. All rights reserved.
//

#import "ATExampleViewModel.h"
#import "ATExampleTableViewCell.h"
#import "ATExampleTableSectionHeaderView.h"


@implementation ATExampleViewModel

- (void)requestData:(NSDictionary * _Nonnull)params
         completion:(void(^ _Nonnull)(NSError * _Nullable error, NSArray <id<ATSectionProtocal, ATCellModelProtocol>> * _Nullable datas))completion {
    
    
    ATSection *sectionObj = [ATSection new];
    sectionObj.identifier = @"1";
    sectionObj.title = @"section 1";
    sectionObj.subTitle = @"more";
    
    
    sectionObj.isPageList = YES;
    sectionObj.section = 0;
    
    
    NSMutableArray<id<ATCellModelProtocol>> *cellModels = [NSMutableArray array];

    {
        ATCellStyle *style = ATCellStyle.new;
        style.cellWidth = UIScreen.mainScreen.bounds.size.width;
        
        ATCellModel *obj = ATCellModel.new;
        obj.cellClass = ATExampleTableViewCell.class;
        obj.cellData = @"xxx1";
        obj.cellStyle = style;
        
        [cellModels addObject:obj];
    }
    
    {
        ATCellStyle *style = ATCellStyle.new;
        style.cellWidth = UIScreen.mainScreen.bounds.size.width;
        
        ATCellModel *obj = ATCellModel.new;
        obj.cellClass = ATExampleTableViewCell.class;
        obj.cellData = @"xxx2";
        obj.cellStyle = style;
        
        [cellModels addObject:obj];
    }
    
    {
        ATCellStyle *style = ATCellStyle.new;
        style.cellWidth = UIScreen.mainScreen.bounds.size.width;
        
        ATCellModel *obj = ATCellModel.new;
        obj.cellClass = ATExampleTableViewCell.class;
        obj.cellData = @"xxx3";
        obj.cellStyle = style;
        
        [cellModels addObject:obj];
    }
    
    {
        ATCellStyle *style = ATCellStyle.new;
        style.cellWidth = UIScreen.mainScreen.bounds.size.width;
        
        ATCellModel *obj = ATCellModel.new;
        obj.cellClass = ATExampleTableViewCell.class;
        obj.cellData = @"xxx4";
        obj.cellStyle = style;
        
        [cellModels addObject:obj];
    }
    
    
    sectionObj.cellModels = cellModels;
    
    {
        ATCellStyle *style = ATCellStyle.new;
        style.cellWidth = UIScreen.mainScreen.bounds.size.width;
        
        ATCellModel *obj = ATCellModel.new;
        obj.cellData = @"section header 0";
        obj.cellClass = ATExampleTableSectionHeaderView.class;
        obj.cellStyle = style;
        
        sectionObj.headerModel = obj;
    }
    
    {
        ATCellStyle *style = ATCellStyle.new;
        style.cellWidth = UIScreen.mainScreen.bounds.size.width;
        
        ATCellModel *obj = ATCellModel.new;
        obj.cellData = @"section footer 0";
        obj.cellClass = ATExampleTableSectionFooterView.class;
        obj.cellStyle = style;
        
        sectionObj.footerModel = obj;
    }

    completion(nil, @[sectionObj]);
   
}

@end
