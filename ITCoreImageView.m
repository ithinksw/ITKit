/*
 *	ITKit
 *	ITCoreImageView.m
 *
 *	View subclass that provides the view for the masking window of a Core Image effect
 *
 *	Copyright (c) 2006 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import "ITCoreImageView.h"

@implementation ITCoreImageView

-(void)drawRect:(NSRect)rect
{
	[[NSColor clearColor] set];
    NSRectFill(rect);
}

@end
