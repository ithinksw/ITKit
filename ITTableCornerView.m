#import "ITTableCornerView.h"

@implementation ITTableCornerView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        headerCell = [[NSTableHeaderCell alloc] init];
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    rect.origin.y = 0;
    rect.size.height = 17;
    rect.size.width += 1;
    
    [headerCell setState: ([[self cell] isHighlighted]) ? NSOnState : NSOffState];
    [headerCell drawWithFrame:rect inView:nil];
    
    if ([self image]) {
        [[self image] drawAtPoint:rect.origin fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
    }
}

- (void)dealloc {
    [headerCell release];
    [super dealloc];
}

@end