/*
 *	ITKit
 *	ITCategory-NSView.h
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>

@interface NSView (ITKitCategory)

- (void)removeAllSubviews;
- (void)removeSubview:(NSView *)subview;

@end