#import "ITCategory-NSView.h"


@implementation NSView (ITCategory)

- (void)removeAllSubviews {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)removeSubview:(NSView *)subview {
	if ([subview superview] == self) {
		[subview removeFromSuperview];
	}
}

@end
