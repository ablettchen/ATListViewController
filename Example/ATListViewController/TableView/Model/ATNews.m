//
//  ATNews.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/9.
//  Copyright © 2022 ablett. All rights reserved.
//

#import "ATNews.h"


@implementation ATNews

@end


@implementation ATNewsCellModel

@synthesize cellData = _cellData;
@synthesize cellStyle = _cellStyle;

@end

@implementation ATNewsStyle

- (CGFloat)cellWidth {
    return UIScreen.mainScreen.bounds.size.width;
}

- (UIFont *)titleFont {
    return [UIFont systemFontOfSize:16];
}

- (UIEdgeInsets)titleInsets {
    return UIEdgeInsetsMake(16, 16, 16, 16);
}

@end
