/*
 *	ITKit
 *  ITHotKey
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
#import "ITKeyCombo.h"


@interface ITHotKey : NSObject
{
	NSString*		mName;
	ITKeyCombo*		mKeyCombo;
	id				mTarget;
	SEL				mAction;
}

- (id)init;

- (void)setName: (NSString*)name;
- (NSString*)name;

- (void)setKeyCombo: (ITKeyCombo*)combo;
- (ITKeyCombo*)keyCombo;

- (void)setTarget: (id)target;
- (id)target;
- (void)setAction: (SEL)action;
- (SEL)action;

- (void)invoke;

@end
