/*
 *	ITKit
 *  ITImageView
 *    NSImageView subclass which adds new features, such as smooth scaling.
 *
 *  Original Author : Matthew Judy <mjudy@ithinksw.com>
 *   Responsibility : Matthew Judy <mjudy@ithinksw.com>
 *
 *  Copyright (c) 2003 iThink Software.
 *  All Rights Reserved
 *
 */


#import <Cocoa/Cocoa.h>


@interface ITImageView : NSImageView {

}

- (BOOL)scalesSmoothly;
- (void)setScalesSmoothly:(BOOL)flag;

@end
