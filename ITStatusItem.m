#import "ITStatusItem.h"

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

@end