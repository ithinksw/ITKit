/*
 *	ITKit
 *  ITImageView
 *    NSImageView subclass which adds new features.
 *
 *  Original Author : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
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
