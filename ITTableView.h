/*
 *	ITKit
 *	ITTableCornerView.h
 *
 *	NSTableView subclass that uses an ITTableCornerView as its default
 *		cornerView and provides easy to use accessors to the features
 *		provided by ITTableCornerView when it is being used.
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>

@interface ITTableView : NSTableView {

}

- (void)setCornerImage:(NSImage*)image;
- (NSImage*)cornerImage;
- (void)setCornerMenu:(NSMenu*)menu;
- (NSMenu*)cornerMenu;

@end