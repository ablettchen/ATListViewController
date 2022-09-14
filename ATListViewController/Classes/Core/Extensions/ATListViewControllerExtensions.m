//
//  UITableViewCell+ATListViewController.m
//  ATListViewController
//
//  Created by ablett on 2022/9/13.
//

#import "ATListViewControllerExtensions.h"
#import <objc/runtime.h>


@implementation UITableViewCell (ATListViewController)

- (void)setAtDelegate:(id <ATCellActionProtocal>)atDelegate {
    objc_setAssociatedObject(self, @selector(atDelegate), atDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id <ATCellActionProtocal>)atDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

@end


@implementation UITableViewHeaderFooterView (ATListViewController)

- (void)setAtDelegate:(id <ATCellActionProtocal>)atDelegate {
    objc_setAssociatedObject(self, @selector(atDelegate), atDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id <ATCellActionProtocal>)atDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

@end


@implementation UICollectionViewCell (ATListViewController)

- (void)setAtDelegate:(id <ATCellActionProtocal>)atDelegate {
    objc_setAssociatedObject(self, @selector(atDelegate), atDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id <ATCellActionProtocal>)atDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

@end


@implementation UICollectionReusableView (ATListViewController)

- (void)setAtDelegate:(id <ATCellActionProtocal>)atDelegate {
    objc_setAssociatedObject(self, @selector(atDelegate), atDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id <ATCellActionProtocal>)atDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

@end
