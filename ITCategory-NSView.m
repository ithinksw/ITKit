#import "ITCategory-NSView.h"


@implementation NSView (ITCategory)

- (void)removeAllSubviews {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
