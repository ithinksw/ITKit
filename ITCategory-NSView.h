/*
 *	ITKit
 *  ITCategory-NSView.h
 *    Category which extends NSView
 *
 *  Original Author : Joseph Spiros <joseph.spiros@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2004 iThink Software.
 *  All Rights Reserved
 *
 */
 
 
#import <AppKit/AppKit.h>


@interface NSView (ITCategory)

- (void)removeAllSubviews;
- (void)removeSubview:(NSView *)subview;

@end
