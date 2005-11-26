#import "ITKeyCombo.h"
#import <Carbon/Carbon.h>

@implementation ITKeyCombo

+ (id)clearKeyCombo {
	return [self keyComboWithKeyCode:-1 modifiers:-1];
}

+ (id)keyComboWithKeyCode:(int)keyCode modifiers:(int)modifiers {
	return [[[self alloc] initWithKeyCode:keyCode modifiers:modifiers] autorelease];
}

+ (id)keyComboWithPlistRepresentation:(id)plist {
	return [[[self alloc] initWithPlistRepresentation:plist] autorelease];
}

- (id)initWithKeyCode:(int)keyCode modifiers:(int)modifiers {
	if ((self = [super init])) {
		mKeyCode = keyCode;
		mModifiers = modifiers;
	}
	return self;
}

- (id)initWithPlistRepresentation:(id)plist {
	int keyCode, modifiers;
	
	keyCode = [[plist objectForKey:@"keyCode"] intValue];
	if (keyCode <= 0) {
		keyCode = -1;
	}
	
	modifiers = [[plist objectForKey:@"modifiers"] intValue];
	if (modifiers <= 0) {
		modifiers = -1;
	}
	
	return [self initWithKeyCode:keyCode modifiers:modifiers];
}

- (id)plistRepresentation {
	return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[self keyCode]], @"keyCode", [NSNumber numberWithInt:[self modifiers]], @"modifiers", nil];
}

- (id)copyWithZone:(NSZone *)zone {
	return [self retain];
}

- (BOOL)isEqual:(ITKeyCombo *)combo {
	return (([self keyCode] == [combo keyCode]) && ([self modifiers] == [combo modifiers]));
}

- (int)keyCode {
	return mKeyCode;
}

- (int)modifiers {
	return mModifiers;
}

- (BOOL)isValidHotKeyCombo {
	return ((mKeyCode >= 0) && (mModifiers > 0));
}

- (BOOL)isClearCombo {
	return ((mKeyCode == -1) && (mModifiers == -1));
}

@end

@implementation ITKeyCombo (UserDisplayAdditions)

+ (NSDictionary *)_keyCodesDictionary {
	static NSDictionary *keyCodes = nil;
	
	if (!keyCodes) {
		NSString *path;
		NSString *contents;
		
		path = [[NSBundle bundleForClass:self] pathForResource:@"ITKeyCodes" ofType:@"plist"];
		contents = [NSString stringWithContentsOfFile:path];
		keyCodes = [[contents propertyList] retain];
	}
	
	return keyCodes;
}

+ (NSString *)_stringForModifiers:(long)modifiers {
	static long modToChar[4][2] = {
		{ cmdKey, 0x23180000 },
		{ optionKey, 0x23250000 },
		{ controlKey, 0x23030000 },
		{ shiftKey, 0x21e70000 }
	};
	
	NSString *str = @"";
	NSString *charStr;
	long i;
	
	for (i = 0;i < 4;i++) {
		if (modifiers & modToChar[i][0]) {
			charStr = [NSString stringWithCharacters:(const unichar *)&modToChar[i][1] length:1];
			str = [str stringByAppendingString:charStr];
		}
	}
	
	return str;
}

+ (NSString *)_stringForKeyCode:(short)keyCode {
	NSDictionary *dict = [self _keyCodesDictionary];
	NSString *key = [NSString stringWithFormat:@"%d", keyCode];
	NSString *str = [dict objectForKey:key];
	
	if (!str) {
		str = [NSString stringWithFormat:@"%X", keyCode];
	}
	
	return str;
}

- (NSString *)description {
	if ([self isValidHotKeyCombo]) { //This might have to change
		return [NSString stringWithFormat:@"%@%@", [[self class] _stringForModifiers:[self modifiers]], [[self class] _stringForKeyCode:[self keyCode]]];
	}
	
	return NSLocalizedString(@"(None)", @"Hot Keys: Key Combo text for 'empty' combo");
}

@end