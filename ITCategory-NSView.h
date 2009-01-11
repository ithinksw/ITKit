/*
 *	ITKit
 *	ITCategory-NSView.h
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>

@interface NSView (ITKitCategory)

- (void)removeAllSubviews;
- (void)removeSubview:(NSView *)subview;

@end