#import "ITTabView.h"

/*************************************************************************/
#pragma mark -
#pragma mark EVIL HACKERY
/*************************************************************************/

@interface NSTabViewItem (HACKHACKHACKHACK)
- (NSRect)_tabRect;
@end


@implementation ITTabView

- (id)initWithFrame:(NSRect)frame
{
    if ( (self = [super initWithFrame:frame]) ) {
        _draggedTab = nil;
        _allowsDragging = NO;
        _requiredModifiers = NSCommandKeyMask;
    }
    return self;
}

- (void)setAllowsDragging:(bool)flag
{
    _allowsDragging = flag;
    _requiredModifiers = NSCommandKeyMask;
}

- (bool)allowsDragging
{
    return _allowsDragging;
}

- (void)setRequiredModifiers:(unsigned int)modifiers
{
    _requiredModifiers = modifiers;
}

- (unsigned int)requiredModifiers
{
    return _requiredModifiers;
}

- (void)moveTab:(NSTabViewItem *)tab toIndex:(int)index
{
    if ([self indexOfTabViewItem:tab] != index)
    {
        [tab retain];
        [self removeTabViewItem:tab];
        [self insertTabViewItem:tab atIndex:index];
        [self selectTabViewItem:tab];
    }
}

- (void)mouseDown:(NSEvent *)event
{
    if ((_requiredModifiers == 0 || ([[NSApp currentEvent] modifierFlags] & _requiredModifiers)) && [self allowsDragging]) {
        NSPoint clickedPoint;
        clickedPoint = [self convertPoint:[event locationInWindow] fromView:[[self window] contentView]];
        NSTabViewItem *clickedTab = [self tabViewItemAtPoint:clickedPoint];
        _draggedTab = clickedTab;
    }
    [super mouseDown:event];
}

- (void)mouseUp:(NSEvent *)event
{
    if (_draggedTab && [self allowsDragging]) {
        NSPoint releasedPoint = [self convertPoint:[event locationInWindow] fromView:[[self window] contentView]];
        NSTabViewItem *releasedTab = [self tabViewItemAtPoint:releasedPoint];
        if (releasedTab && ![releasedTab isEqualTo:_draggedTab]) {
            [self moveTab:_draggedTab toIndex:[self indexOfTabViewItem:releasedTab]];
        }
        _draggedTab = nil;
    }
    [super mouseUp:event];
}

- (void)mouseDragged:(NSEvent *)event
{
    if (_draggedTab && [self allowsDragging]) {
        NSPoint currentPoint = [self convertPoint:[event locationInWindow] fromView:[[self window] contentView]];
        NSTabViewItem *curTab = [self tabViewItemAtPoint:currentPoint];
        if (curTab && ![curTab isEqualTo:_draggedTab]) {
            [self moveTab:_draggedTab toIndex:[self indexOfTabViewItem:curTab]];
            [self selectTabViewItem:_draggedTab];
        }
    }
    [super mouseDragged:event];
}


@end
