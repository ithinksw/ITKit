//
//  ITKeyCombo.h
//
//  Created by Quentin Carnicelli on Sat Aug 02 2003.
//  Copyright (c) 2003 iThink Software. All rights reserved.
//

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