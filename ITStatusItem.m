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
- (id)_initInStatusBar:(NSStatusBar*)statusBar
             withLength:(float)length
           withPriority:(int)priority;
- (NSStatusBarButton*)_button;
@end


/*************************************************************************/
#pragma mark -
#pragma mark PRIVATE METHOD DECLARATIONS
/*************************************************************************/

@interface ITStatusItem (Private)
- (void)setImage:(NSImage*)image;
- (NSString*) title;
- (void)setTitle:(NSString*)title;
- (void)setSmallTitle:(NSString*)title;
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

- (NSImage*)alternateImage {
    return [[self _button] alternateImage];
}

- (void)setAlternateImage:(NSImage*)image {
    [[self _button] setAlternateImage:image];
}

- (void)setImage:(NSImage*)image {
    [super setImage:image];
    if ( [self title] ) {
        [self setTitle:[self title]];
    } 
}

- (void)setTitle:(NSString*)title {
    if ( [self image] && (title != nil) ) {
        [self setSmallTitle:title];
    } else {
        [super setTitle:title];
    }
}


/*************************************************************************/
#pragma mark -
#pragma mark PRIVATE METHODS
/*************************************************************************/



- (void)setSmallTitle:(NSString*)title {
    NSAttributedString *attrTitle = [[[NSAttributedString alloc] initWithString:title attributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Lucida Grande" size:12.0] forKey:NSFontAttributeName]] autorelease];
    [self setAttributedTitle:attrTitle];
}


@end
