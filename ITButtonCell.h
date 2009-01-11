/*
 *	ITKit
 *	ITButtonCell.h
 *
 *	Custom NSButtonCell subclass that provides a stylized bezel style for use
 *		with ITStatusWindows.
 *
 *	Copyright (c) 2005 iThink Software
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