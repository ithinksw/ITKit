//
//  ITHotKey.h
//
//  Created by Quentin Carnicelli on Sat Aug 02 2003.
//  Copyright (c) 2003 iThink Software. All rights reserved.
//

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
