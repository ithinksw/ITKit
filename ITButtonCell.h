/*
 *	ITKit
 *	ITButtonCell.h
 *
 *	Custom NSButtonCell subclass that provides a stylized bezel style for use
 *		with ITStatusWindows.
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>

typedef enum _ITBezelStyle {
	ITGrayRoundedBezelStyle = 1001
} ITBezelStyle;

@interface ITButtonCell : NSButtonCell {
	ITBezelStyle _subStyle;
}

@end