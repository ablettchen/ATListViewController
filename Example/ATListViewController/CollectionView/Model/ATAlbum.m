//
//  ATAlbum.m
//  ATListViewController_Example
//
//  Created by ablett on 2022/9/15.
//  Copyright © 2022 ablett. All rights reserved.
//

#import "ATAlbum.h"

@implementation ATAlbum

@end

@implementation ATAlbumCellModel

@synthesize cellData = _cellData;
@synthesize cellStyle = _cellStyle;

@end

@implementation ATAlbumStyle

- (CGFloat)cellWidth {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    return (screenWidth - self.spacing * (self.colum + 1)) / self.colum;
}

- (NSUInteger)colum {
    return 3;
}

- (CGFloat)spacing {
    return self.class.spacing;
}

+ (CGFloat)spacing {
    return 16;
}

@end
