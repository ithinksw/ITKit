#import "ITTableView.h"
#import "ITTableCornerView.h"

@implementation ITTableView

- (id)initWithFrame:(NSRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self setCornerView:[[ITTableCornerView alloc] initWithFrame:[[self cornerView] frame]]];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)coder {
	if ((self = [super initWithCoder:coder])) {
		[self setCornerView:[[ITTableCornerView alloc] initWithFrame:[[self cornerView] frame]]];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[super encodeWithCoder:coder];
}

- (void)setCornerImage:(NSImage *)image {
	if ([_cornerView isKindOfClass:[ITTableCornerView class]]) {
		[(ITTableCornerView *)_cornerView setImage:image];
	}
}

- (NSImage *)cornerImage {
	if ([_cornerView isKindOfClass:[ITTableCornerView class]]) {
		return [(ITTableCornerView *)_cornerView image];
	}
	return nil;
}

- (void)setCornerMenu:(NSMenu *)menu {
	if ([_cornerView isKindOfClass:[ITTableCornerView class]]) {
		[(ITTableCornerView *)_cornerView setMenu:menu];
	}
}

- (NSMenu *)cornerMenu {
	if ([_cornerView isKindOfClass:[ITTableCornerView class]]) {
		return [(ITTableCornerView *)_cornerView menu];
	}
	return nil;
}

@end