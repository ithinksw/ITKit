#import "ITCategory-NSView.h"

@implementation NSView (ITKitCategory)

- (void)removeAllSubviews {
	[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)removeSubview:(NSView *)subview {
	if ([subview superview] == self) {
		[subview removeFromSuperview];
	}
}

@end