/*
 *	ITKit
 *	ITKeyCombo.h
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>

@interface ITKeyCombo : NSObject <NSCopying> {
	int mKeyCode;
	int mModifiers;
}

+ (id)clearKeyCombo;
+ (id)keyComboWithKeyCode:(int)keyCode modifiers:(int)modifiers;
+ (id)keyComboWithPlistRepresentation:(id)plist;
- (id)initWithKeyCode:(int)keyCode modifiers:(int)modifiers;

- (id)initWithPlistRepresentation:(id)plist;
- (id)plistRepresentation;

- (BOOL)isEqual:(ITKeyCombo *)combo;

- (int)keyCode;
- (int)modifiers;

- (BOOL)isClearCombo;
- (BOOL)isValidHotKeyCombo;

@end

@interface ITKeyCombo (UserDisplayAdditions)

- (NSString *)description;

@end