/*
 *	ITKit
 *  ITImageCell
 *    Cell used by the ITImageView control.
 *
 *  Original Author : Matthew Judy <mjudy@ithinksw.com>
 *   Responsibility : Matthew Judy <mjudy@ithinksw.com>
 *
 *  Copyright (c) 2003 iThink Software.
 *  All Rights Reserved
 *
 */
 
 
#import <Cocoa/Cocoa.h>


@interface ITImageCell : NSImageCell {

    BOOL _scalesSmoothly;

}

- (BOOL)scalesSmoothly;
- (void)setScalesSmoothly:(BOOL)flag;


@end
