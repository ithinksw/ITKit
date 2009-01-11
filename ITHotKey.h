/*
 *	ITKit
 *	ITHotKey.h
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>

@class ITKeyCombo;

@interface ITHotKey : NSObject {
	NSString *mName;
	ITKeyCombo *mKeyCombo;
	id mTarget;
	SEL mAction;
}

- (id)init;

- (void)setName:(NSString *)name;
- (NSString *)name;

- (void)setKeyCombo:(ITKeyCombo *)combo;
- (ITKeyCombo *)keyCombo;

- (void)setTarget:(id)target;
- (id)target;
- (void)setAction:(SEL)action;
- (SEL)action;

- (void)invoke;

@end