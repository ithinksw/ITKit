#import "Controller.h"
#import "ITTransientStatusWindow.h"
#import "ITTextField.h"
#import "ITPivotWindowEffect.h"

#define SW_PAD    24.0
#define SW_SPACE  24.0
#define SW_MINW   211.0
#define SW_BORDER 32.0
#define SW_IMAGE  @"Library"

@interface Controller (ITStatusItemSupport)
- (void)createStatusItem;
- (void)removeStatusItem;
@end


@implementation Controller

- (void)awakeFromNib
{
    [self createStatusItem];
    [testTextField setCastsShadow:YES];
    [tabView setAllowsDragging:YES];
    statusWindow = [ITTransientStatusWindow sharedWindow];
//  [tabView setAllowsDragging:YES];
}

/*************************************************************************/
#pragma mark -
#pragma mark ITStatusItem SUPPORT
/*************************************************************************/

- (void)createStatusItem
{
    statusItem = [[ITStatusItem alloc] initWithStatusBar:[NSStatusBar systemStatusBar]
                                              withLength:NSVariableStatusItemLength];

    if ( [showImageCheckBox state] == NSOnState ) {
        [statusItem setImage:[NSImage imageNamed:@"ITStatusItem"]];
    }

    if ( [useInvertedCheckBox state] == NSOnState ) {
        [statusItem setAlternateImage:[NSImage imageNamed:@"ITStatusItemInv"]];
    }

    if ( [showTitleCheckBox state] == NSOnState ) {
        [statusItem setTitle:@"ITStatusItem"];
    }

    [statusItem setMenu:statusItemMenu];
}

- (void)removeStatusItem
{
    [[statusItem statusBar] removeStatusItem:statusItem];
    [statusItem autorelease];
    statusItem = nil;
}

- (IBAction)toggleStatusItem:(id)sender
{
    if ( [sender state] == NSOnState ) {
        [self createStatusItem];
        [showImageCheckBox   setEnabled:YES];
        [showTitleCheckBox   setEnabled:YES];
        [useInvertedCheckBox setEnabled:YES];
    } else {
        [self removeStatusItem];
        [showImageCheckBox   setEnabled:NO];
        [useInvertedCheckBox setEnabled:NO];
        [showTitleCheckBox   setEnabled:NO];
    }
}

- (IBAction)toggleImage:(id)sender
{
    if ( [sender state] == NSOnState ) {
        [statusItem setImage:[NSImage imageNamed:@"ITStatusItem"]];
        [statusItem setAlternateImage:[NSImage imageNamed:@"ITStatusItemInv"]];
        [useInvertedCheckBox setEnabled:YES];
        [useInvertedCheckBox setState:NSOnState];
    } else {
        [statusItem setImage:nil];
        [statusItem setAlternateImage:nil];
        [useInvertedCheckBox setEnabled:NO];
        [useInvertedCheckBox setState:NSOffState];
    }
}

- (IBAction)toggleInvertedImage:(id)sender
{
    if ( [sender state] == NSOnState ) {
        [statusItem setAlternateImage:[NSImage imageNamed:@"ITStatusItemInv"]];
    } else {
        [statusItem setAlternateImage:nil];
    }
}

- (IBAction)toggleTitle:(id)sender
{
    if ( [sender state] == NSOnState ) {
        [statusItem setTitle:@"ITStatusItem"];
    } else {
        [statusItem setTitle:nil];
    }
}


/*************************************************************************/
#pragma mark -
#pragma mark ITTextView SUPPORT
/*************************************************************************/

- (IBAction)toggleCastsShadow:(id)sender
{
    [testTextField setCastsShadow:([sender state] == NSOnState)];
}


/*************************************************************************/
#pragma mark -
#pragma mark ITTransientStatusWindow SUPPORT
/*************************************************************************/

- (IBAction)buildStatusWindow:(id)sender
{
    NSImageView *imageView    = nil;
    ITTextField *textField    = nil;
    NSImage     *image        = [NSImage imageNamed:SW_IMAGE];
    NSRect       imageRect;
    NSRect       textRect;   

    float imageWidth    = 0.0;
    float imageHeight   = 0.0;
    float textWidth     = 0.0;
    float textHeight    = 0.0;
    float contentHeight = 0.0;
    float windowWidth   = 0.0;
    float windowHeight  = 0.0;

    NSString     *text     = [swSampleTextView string];
    NSArray      *lines    = [text componentsSeparatedByString:@"\n"];
    id			  oneLine  = nil;
    NSEnumerator *lineEnum = [lines objectEnumerator];

    NSFont *font           = [NSFont fontWithName:@"Lucida Grande Bold" size:18];
    NSDictionary *attr     = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    // Get image width and height.
    imageWidth  = [image size].width;
    imageHeight = [image size].height;
    
    // Iterate over each line to get text width and height
    while ( oneLine = [lineEnum nextObject] ) {
        // Get the width of one line, adding 8.0 because Apple sucks donkey rectum.
        float oneLineWidth = ( [oneLine sizeWithAttributes:attr].width + 8.0 );
        // Add the height of this line to the total text height
        textHeight += [oneLine sizeWithAttributes:attr].height;
        // If this line wider than the last one, set it as the text width.
        textWidth = ( ( textWidth > oneLineWidth ) ? textWidth : oneLineWidth );
    }
    
    // Add 4.0 to the final textHeight to accomodate the shadow.
    textHeight += 4.0;
    
    // Set the content height to the greater of the text and image heights.
    contentHeight = ( ( imageHeight > textHeight ) ? imageHeight : textHeight );
    
    // Setup the Window, and remove all its contentview's subviews.
    windowWidth  = ( SW_PAD + imageWidth + SW_SPACE + textWidth + SW_PAD );
    windowHeight = ( SW_PAD + contentHeight + SW_PAD );
    [statusWindow setFrame:NSMakeRect(SW_BORDER, SW_BORDER, windowWidth, windowHeight) display:YES];
    [[[statusWindow contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Setup, position, fill, and add the image view to the content view.
    imageRect = NSMakeRect( SW_PAD,
                            (SW_PAD + ((contentHeight - imageHeight) / 2)),
                            imageWidth,
                            imageHeight );
    imageView = [[[NSImageView alloc] initWithFrame:imageRect] autorelease];
    [imageView setImage:image];
    [[statusWindow contentView] addSubview:imageView];
    
    // Setup, position, fill, and add the text view to the content view.
    textRect = NSMakeRect( (SW_PAD + imageWidth + SW_SPACE),
                           (SW_PAD + ((contentHeight - textHeight) / 2)),
                           textWidth,
                           textHeight);
    textField = [[[ITTextField alloc] initWithFrame:textRect] autorelease];
    [textField setEditable:NO];
    [textField setSelectable:NO];
    [textField setBordered:NO];
    [textField setDrawsBackground:NO];
    [textField setFont:[NSFont fontWithName:@"Lucida Grande Bold" size:18]];
    [textField setTextColor:[NSColor whiteColor]];
    [textField setCastsShadow:YES];
    [textField setStringValue:text];
    [[statusWindow contentView] addSubview:textField];

    [[statusWindow contentView] setNeedsDisplay:YES];

    [statusWindow setEntryEffect:[[ITPivotWindowEffect alloc] initWithWindow:statusWindow]];
    [statusWindow setExitEffect:[[ITPivotWindowEffect alloc] initWithWindow:statusWindow]];
}

- (IBAction)showStatusWindow:(id)sender
{
    [[statusWindow contentView] setNeedsDisplay:YES];
    [statusWindow appear:self];
}

- (IBAction)hideStatusWindow:(id)sender
{
    [statusWindow vanish:self];
}

- (IBAction)changeWindowSetting:(id)sender
{
    switch ( [sender tag] )
    {
        case 3010:  // Not yet supported.
            break;
        case 3020:  // Not yet supported.
            break;
        case 3030:  // Change vanish delay
            [statusWindow setExitDelay:[sender floatValue]];
            break;
        case 3040:  // Change vertical position
            [statusWindow setVerticalPosition:[sender indexOfSelectedItem]];
            break;
        case 3050:  // Change horizontal position
            [statusWindow setHorizontalPosition:[sender indexOfSelectedItem]];
            break;
        case 3060:  // Change effect speed
            [[statusWindow entryEffect] setEffectTime:[sender floatValue]];
            [[statusWindow exitEffect]  setEffectTime:[sender floatValue]];
            break;
        case 3070:  // Change entry effect
            break;
        case 3080:  // Change exit effect
            break;
    }
}


/*************************************************************************/
#pragma mark -
#pragma mark ITTabView SUPPORT
/*************************************************************************/

- (IBAction)toggleTabDragging:(id)sender
{
    if ([sender state] == NSOnState) {
        [tabView setAllowsDragging:YES];
    } else {
        [tabView setAllowsDragging:NO];
    }
}

- (IBAction)toggleCommandDragging:(id)sender
{
    if ([sender state] == NSOnState) {
        [tabView setRequiredModifiers:NSCommandKeyMask];
    } else {
        [tabView setRequiredModifiers:0];
    }
}

- (IBAction)toggleControlDragging:(id)sender
{
}

- (IBAction)toggleOptionDragging:(id)sender
{
}

- (IBAction)toggleShiftDragging:(id)sender
{
}

/*************************************************************************/
#pragma mark -
#pragma mark NSWindow DELEGATE METHODS
/*************************************************************************/

- (void)windowWillMiniaturize:(NSNotification *)note
{
    [[note object] setMiniwindowImage:[NSImage imageNamed:@"ITStatusItem"]];
}


@end
