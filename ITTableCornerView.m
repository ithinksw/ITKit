#import "ITTableCornerView.h"

@interface ITTableCornerView (Private)

- (id)initWithFrame:(NSRect)frame cellClass:(Class)cellClass;

@end

@implementation ITTableCornerView

- (id)initWithFrame:(NSRect)frame {
	return [self initWithFrame:frame cellClass:[NSTableHeaderCell class]];
}

- (id)initWithFrame:(NSRect)frame cellClass:(Class)cellClass {
	if ((self = [super initWithFrame:frame])) {
		headerCell = [[cellClass alloc] init];
		[self setPullsDown:YES];
	}
	return self;
}

- (void)drawRect:(NSRect)rect {
	NSImage *drawImage;

	rect.origin.y = 0;
	rect.size.height = 17;
	rect.size.width += 1;

	[headerCell setState:([[self cell] isHighlighted] ? NSOnState : NSOffState)];
	[headerCell drawWithFrame:rect inView:nil];

	if ((drawImage = [self image])) {
		BOOL oldFlipped = [drawImage isFlipped];
		[drawImage setFlipped:YES];
		[drawImage drawAtPoint:rect.origin fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
		[drawImage setFlipped:oldFlipped];
	}
}

- (void)setImage:(NSImage *)anImage {
	[super setImage:anImage];
	[image autorelease];
	image = [anImage copy];
}

- (NSImage *)image {
	return (image ? image : [super image]);
}

- (void)dealloc {
	[image release];
	[headerCell release];
	[super dealloc];
}

@end