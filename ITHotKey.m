#import "ITHotKey.h"
#import "ITKeyCombo.h"

@implementation ITHotKey

- (id)init {
	if ((self = [super init])) {
		[self setKeyCombo:[ITKeyCombo clearKeyCombo]];
	}
	return self;
}

- (void)dealloc {
	[mName release];
	[mKeyCombo release];
	[super dealloc];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), [self keyCombo]];
}

- (void)setKeyCombo:(ITKeyCombo *)combo {
	[mKeyCombo autorelease];
	mKeyCombo = [combo retain];
}

- (ITKeyCombo *)keyCombo {
	return mKeyCombo;
}

- (void)setName:(NSString *)name {
	[mName autorelease];
	mName = [name retain];
}

- (NSString *)name {
	return mName;
}

- (void)setTarget:(id)target {
	mTarget = target;
}

- (id)target {
	return mTarget;
}

- (void)setAction:(SEL)action {
	mAction = action;
}

- (SEL)action {
	return mAction;
}

- (void)invoke {
	[mTarget performSelector:mAction withObject:self];
}

@end