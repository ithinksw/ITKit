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

/*************************************************************************/
#pragma mark -
#pragma mark PRIVATE METHOD DECLARATIONS
/*************************************************************************/

@interface ITStatusItem (Private)
- (void) setSmallTitle:(NSString*)title;
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

- (void) setImage:(NSImage*)image {
    [super setImage:image];
    if ([self title]) {
        [self setSmallTitle:[self title]];
    }
}

- (NSString*) title {
    if ([self image]) {
        return [[self attributedTitle] string];
    } else {
        [super title];
    }
}

- (void) setTitle:(NSString*)title {
    [super setTitle:title];
    if ([self image]) {
        [self setSmallTitle:[self title]];
    }
}

/*************************************************************************/
#pragma mark -
#pragma mark PRIVATE METHODS
/*************************************************************************/

- (void) setSmallTitle:(NSString*)title {
    NSAttributedString *attrTitle = [[NSAttributedString alloc] initWithString:title attributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Lucida Grande" size:12.0] forKey:NSFontAttributeName]];
    [self setAttributedTitle:attrTitle];
    [attrTitle release];
}

@end
