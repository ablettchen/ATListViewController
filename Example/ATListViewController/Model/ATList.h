//
//  ATList.h
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/15.
//  Copyright © 2022 ablett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATList : NSObject

@property (nonatomic, copy) NSString *nextId;
@property (nonatomic, assign) BOOL lastPage;
@property (nonatomic, strong) NSArray *data;

@end








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



NS_ASSUME_NONNULL_END
