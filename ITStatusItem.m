#import "ITStatusItem.h"

/*************************************************************************/
#pragma mark -
#pragma mark EVIL HACKERY
/*************************************************************************/

// This stuff is actually implemented by the AppKit.
// We declare it here to cancel out warnings.

@interface NSStatusBarButton : NSButton
@end

@interface NSStatusItem (HACKHACKHACKHACK)
- (id) _initInStatusBar:(NSStatusBar*)statusBar
             withLength:(float)length
           withPriority:(int)priority;
- (NSStatusBarButton*) _button;
@end


@implementation ITStatusItem

/*************************************************************************/
#pragma mark -
#pragma mark INITIALIZATION METHODS
/*************************************************************************/

- (id)initWithStatusBar:(NSStatusBar*)statusBar withLength:(float)length
{
    if ( ( self = [super _initInStatusBar:statusBar
                               withLength:length
                             withPriority:1000] ) ) {
                             
        //Eliminate the fucking shadow...
        [[[self _button] cell] setType:NSNullCellType];
        
        //Be something other than a dumbshit about highlighting...
        [self setHighlightMode:YES];
    }
    return self;
}


/*************************************************************************/
#pragma mark -
#pragma mark ACCESSOR METHODS
/*************************************************************************/

- (NSImage*) alternateImage {
    return [[self _button] alternateImage];
}

- (void) setAlternateImage:(NSImage*)image {
    [[self _button] setAlternateImage:image];
}

@end
