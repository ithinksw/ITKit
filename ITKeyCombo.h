/*
 *	ITKit
 *  ITKeyCombo
 *
 *  Original Author : Quentin Carnicelli <...>
 *   Responsibility : Kent Sutherland <kent.sutherland@ithinksw.com>
 *   Responsibility : Matthew Judy <mjudy@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */


#import <Foundation/Foundation.h>


@interface ITKeyCombo : NSObject <NSCopying>
{
	int	mKeyCode;
	int	mModifiers;
}

+ (id)clearKeyCombo;
+ (id)keyComboWithKeyCode: (int)keyCode modifiers: (int)modifiers;
+ (id)keyComboWithPlistRepresentation: (id)plist;
- (id)initWithKeyCode: (int)keyCode modifiers: (int)modifiers;

- (id)initWithPlistRepresentation: (id)plist;
- (id)plistRepresentation;

- (BOOL)isEqual: (ITKeyCombo*)combo;

- (int)keyCode;
- (int)modifiers;

- (BOOL)isClearCombo;
- (BOOL)isValidHotKeyCombo;


@end


@interface ITKeyCombo (UserDisplayAdditions)

- (NSString*)description;

@end