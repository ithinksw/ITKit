#import "ITStatusItem.h"

@interface ITStatusItemMenuProxy : NSProxy {
	id <ITStatusItemMenuProvider> menuProvider;
	ITStatusItem *statusItem;
}

- (id)initWithMenuProvider:(id <ITStatusItemMenuProvider>)provider statusItem:(ITStatusItem *)item;

@end

@implementation ITStatusItemMenuProxy

+ (BOOL)respondsToSelector:(SEL)aSelector {
	if (![super respondsToSelector:aSelector]) {
		return [NSMenu respondsToSelector:aSelector];
	}
	return YES;
}

- (id)initWithMenuProvider:(id <ITStatusItemMenuProvider>)provider statusItem:(ITStatusItem *)item {
	menuProvider = [provider retain];
	statusItem = [item retain];
	return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	NSMenu *temporaryMenu = [[menuProvider menuForStatusItem:statusItem] retain];
	[anInvocation setTarget:temporaryMenu];
	[anInvocation invoke];
	[temporaryMenu release];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	NSMenu *temporaryMenu = [[menuProvider menuForStatusItem:statusItem] retain];
	NSMethodSignature *signature = [temporaryMenu methodSignatureForSelector:aSelector];
	[temporaryMenu release];
	return signature;
}

- (void)dealloc {
	[statusItem release];
	[menuProvider release];
	[super dealloc];
}

@end

@class NSStatusBarButton;

@interface NSStatusItem (ITStatusItemHacks)
- (id)_initInStatusBar:(NSStatusBar *)statusBar withLength:(float)length withPriority:(int)priority;
- (NSStatusBarButton *)_button;
@end

@protocol _ITStatusItemNSStatusItemPantherCompatability
- (void)setAlternateImage:(NSImage *)image;
- (NSImage *)alternateImage;
@end

@implementation ITStatusItem

static BOOL _ITStatusItemShouldKillShadow = NO;

+ (void)initialize {
	if ((floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_1) && (floor(NSAppKitVersionNumber) <= 663.6)) {
		_ITStatusItemShouldKillShadow = YES;
	}
}

- (id)initWithStatusBar:(NSStatusBar *)statusBar withLength:(float)length {
	return [self _initInStatusBar:statusBar withLength:length withPriority:1000];
}

- (id)_initInStatusBar:(NSStatusBar *)statusBar withLength:(float)length withPriority:(int)priority {
	if ((self = [super _initInStatusBar:statusBar withLength:length withPriority:priority])) {
		if (_ITStatusItemShouldKillShadow) {
			[[(NSButton *)[self _button] cell] setType:NSNullCellType];
		}
	    [self setHighlightMode:YES];
	}
	return self;
}

- (NSImage *)alternateImage {
	if ([super respondsToSelector:@selector(alternateImage)]) {
		return [(id <_ITStatusItemNSStatusItemPantherCompatability>)super alternateImage];
	}
	return [(NSButton *)[self _button] alternateImage];
}

- (void)setAlternateImage:(NSImage*)image {
	if ([super respondsToSelector:@selector(setAlternateImage:)]) {
		[(id <_ITStatusItemNSStatusItemPantherCompatability>)super setAlternateImage:image];
		return;
	}
	[(NSButton *)[self _button] setAlternateImage:image];
}

- (id <ITStatusItemMenuProvider>)menuProvider {
	return _menuProvider;
}

- (void)setMenuProvider:(id <ITStatusItemMenuProvider>)provider {
	[_menuProvider autorelease];
	_menuProvider = [provider retain];
	if (provider) {
		[self setMenu:[[ITStatusItemMenuProxy alloc] initWithMenuProvider:_menuProvider statusItem:self]];
	} else {
		[self setMenu:nil];
	}
}

@end