#import "ITTabView.h"

@implementation ITTabView

- (id)initWithFrame:(NSRect)frame
{
    if ( (self = [super initWithFrame:frame]) ) {
        _draggedTab = nil;
    }
    return self;
}

- (void)mouseDown:(NSEvent *)event
{
    NSPoint clickedPoint = [self convertPoint:[event locationInWindow] fromView:[[self window] contentView]];
    NSTabViewItem *clickedTab = [self tabViewItemAtPoint:clickedPoint];
    _draggedTab = clickedTab;
    [super mouseDown:event];
}

- (void)mouseUp:(NSEvent *)event
{
    NSPoint releasedPoint = [self convertPoint:[event locationInWindow] fromView:[[self window] contentView]];
    NSTabViewItem *releasedTab = [self tabViewItemAtPoint:releasedPoint];
    if (releasedTab && ![releasedTab isEqualTo:_draggedTab]) {
        int releasedTabIndex = [self indexOfTabViewItem:releasedTab];
        [_draggedTab retain];
        [self removeTabViewItem:_draggedTab];
        [self insertTabViewItem:_draggedTab atIndex:releasedTabIndex];
        [self selectTabViewItem:_draggedTab];
    }
    _draggedTab = nil;
    [super mouseUp:event];
}

- (void)mouseDragged:(NSEvent *)event
{
    NSPoint currentPoint = [self convertPoint:[event locationInWindow] fromView:[[self window] contentView]];
    NSTabViewItem *curTab = [self tabViewItemAtPoint:currentPoint];
    if (curTab && ![curTab isEqualTo:_draggedTab]) {
        int curTabIndex = [self indexOfTabViewItem:curTab];
        [_draggedTab retain];
        [self removeTabViewItem:_draggedTab];
        [self insertTabViewItem:_draggedTab atIndex:curTabIndex];
        [self selectTabViewItem:_draggedTab];
    }
    [super mouseDragged:event];
}

@end
