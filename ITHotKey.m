//
//  ITHotKey.m
//
//  Created by Quentin Carnicelli on Sat Aug 02 2003.
//  Copyright (c) 2003 iThink Software. All rights reserved.
//

#import "ITHotKey.h"

#import "ITHotKeyCenter.h"
#import "ITKeyCombo.h"

@implementation ITHotKey

- (id)init
{
	if ( (self = [super init]) )
	{
		[self setKeyCombo: [ITKeyCombo clearKeyCombo]];
	}
	
	return self;
}

- (void)dealloc
{
	[mName release];
	[mKeyCombo release];
	
	[super dealloc];
}

- (NSString*)description
{
	return [NSString stringWithFormat: @"<%@: %@>",
        NSStringFromClass( [self class] ),
        [self keyCombo]];
}

#pragma mark -

- (void)setKeyCombo: (ITKeyCombo*)combo
{
	[combo retain];
	[mKeyCombo release];
	mKeyCombo = combo;
}

- (ITKeyCombo*)keyCombo
{
	return mKeyCombo;
}

- (void)setName: (NSString*)name
{
	[name retain];
	[mName release];
	mName = name;
}

- (NSString*)name
{
	return mName;
}

- (void)setTarget: (id)target
{
	mTarget = target;
}

- (id)target
{
	return mTarget;
}

- (void)setAction: (SEL)action
{
	mAction = action;
}

- (SEL)action
{
	return mAction;
}

- (void)invoke
{
	[mTarget performSelector: mAction withObject: self];
}

@end
