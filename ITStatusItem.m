#import "ITStatusItem.h"
#import <CoreServices/CoreServices.h>

@interface ITStatusItemMenuProxy : NSProxy {
	id <ITStatusItemMenuProvider> menuProvider;
	ITStatusItem *statusItem;
	AbsoluteTime cachedTime;
	NSMenu *menu;
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
	cachedTime = UpTime();
	menu = nil;
	return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	AbsoluteTime diff = SubAbsoluteFromAbsolute(UpTime(),cachedTime);
	
	if (!menu || diff.lo > 1000000) {
		[menu release];
		menu = [[menuProvider menuForStatusItem:statusItem] retain];
		cachedTime = UpTime();
	}
	
	[anInvocation setTarget:menu];
	[anInvocation invoke];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	return [NSMenu instanceMethodSignatureForSelector:aSelector];
}

- (void)dealloc {
	[menu release];
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

@protocol _ITStatusItemNSStatusBarButtonMethods
- (NSMenu *)statusMenu;
- (void)setStatusMenu:(NSMenu *)menu;
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
		_menuProvider = nil;
		_menuProxy = nil;
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
	[_menuProxy autorelease];
	_menuProxy = nil;
	_menuProvider = provider;
	if (_menuProvider) {
		_menuProxy = [[ITStatusItemMenuProxy alloc] initWithMenuProvider:_menuProvider statusItem:self];
		[(id <_ITStatusItemNSStatusBarButtonMethods>)[self _button] setStatusMenu:_menuProxy];
	} else {
		[self setMenu:[self menu]];
	}
}

- (void)dealloc {
	[_menuProxy release];
	[super dealloc];
}

@end