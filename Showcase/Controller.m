#import "Controller.h"
#import "ITTransientStatusWindow.h"
#import "ITTextField.h"
#import "ITBevelView.h"
#import "ITCutWindowEffect.h"
#import "ITDissolveWindowEffect.h"
#import "ITSlideHorizontallyWindowEffect.h"
#import "ITSlideVerticallyWindowEffect.h"
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
    [button setBezelStyle:1001];
    [button setFont:[NSFont fontWithName:@"Lucida Grande Bold" size:14]];
    [button setTitle:@"Launch Manually"];
    [button sizeToFit];
    [button setFrameSize:NSMakeSize([button frame].size.width + 8, 24)];
    [testTextField setCastsShadow:YES];
    [tabView setAllowsDragging:YES];
    [bevelView setBevelDepth:10];
    statusWindow = [ITTransientStatusWindow sharedWindow];
    [statusWindow setEntryEffect:[[ITCutWindowEffect alloc] initWithWindow:statusWindow]];
    [statusWindow setExitEffect:[[ITDissolveWindowEffect alloc] initWithWindow:statusWindow]];
    [[statusWindow entryEffect] setEffectTime:[swSpeedSlider floatValue]];
    [[statusWindow exitEffect]  setEffectTime:[swSpeedSlider floatValue]];
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

    [statusItemMenu addItemWithTitle:[NSString stringWithUTF8String:"★★★★★"]
                              action:nil
                       keyEquivalent:@""];
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
    NSLog(@"%f", textHeight);
    // Set the content height to the greater of the text and image heights.
    contentHeight = ( ( imageHeight > textHeight ) ? imageHeight : textHeight );
    
    // Setup the Window, and remove all its contentview's subviews.
    windowWidth  = ( SW_PAD + imageWidth + SW_SPACE + textWidth + SW_PAD );
    windowHeight = ( SW_PAD + contentHeight + SW_PAD );
    [statusWindow setFrame:NSMakeRect(SW_BORDER, SW_BORDER, windowWidth, windowHeight) display:YES animate:YES];
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
    [textField setShadowSaturation:[swShadowSaturation floatValue]];
    [[statusWindow contentView] addSubview:textField];

    [[statusWindow contentView] setNeedsDisplay:YES];
}

- (IBAction)toggleStatusWindow:(id)sender
{
    if ( ([statusWindow visibilityState] == ITWindowHiddenState) ||
         ([statusWindow visibilityState] == ITWindowVanishingState) ) {
        [[statusWindow contentView] setNeedsDisplay:YES];
        [statusWindow appear:self];
    } else {
        [statusWindow vanish:self];
    }
}

- (IBAction)changeWindowSetting:(id)sender
{
    if ( [sender tag] == 3010 ) {

        if ( [sender indexOfSelectedItem] == 0) {
            [statusWindow setExitMode:ITTransientStatusWindowExitAfterDelay];
        } else if ( [sender indexOfSelectedItem] == 1) {
            [statusWindow setExitMode:ITTransientStatusWindowExitOnCommand];
        }

    } else if ( [sender tag] == 3020 ) {
        // Not yet supported
    } else if ( [sender tag] == 3030 ) {
        [statusWindow setExitDelay:[sender floatValue]];
    } else if ( [sender tag] == 3040 ) {
        [statusWindow setVerticalPosition:[sender indexOfSelectedItem]];
    } else if ( [sender tag] == 3050 ) {
        [statusWindow setHorizontalPosition:[sender indexOfSelectedItem]];
    } else if ( [sender tag] == 3060 ) {
        [[statusWindow entryEffect] setEffectTime:[sender floatValue]];
        [[statusWindow exitEffect]  setEffectTime:[sender floatValue]];
    } else if ( [sender tag] == 3070 ) {
    
        if ( [sender indexOfSelectedItem] == 0 ) {
            [statusWindow setEntryEffect:[[[ITCutWindowEffect alloc] initWithWindow:statusWindow] autorelease]];
        } else if ( [sender indexOfSelectedItem] == 1 ) {
            [statusWindow setEntryEffect:[[[ITDissolveWindowEffect alloc] initWithWindow:statusWindow] autorelease]];
        } else if ( [sender indexOfSelectedItem] == 2 ) {
            [statusWindow setEntryEffect:[[[ITSlideVerticallyWindowEffect alloc] initWithWindow:statusWindow] autorelease]];
        } else if ( [sender indexOfSelectedItem] == 3 ) {
            [statusWindow setEntryEffect:[[[ITSlideHorizontallyWindowEffect alloc] initWithWindow:statusWindow] autorelease]];
        } else if ( [sender indexOfSelectedItem] == 4 ) {
            [statusWindow setEntryEffect:[[[ITPivotWindowEffect alloc] initWithWindow:statusWindow] autorelease]];
        }

        [[statusWindow entryEffect] setEffectTime:[swSpeedSlider floatValue]];
        
    } else if ( [sender tag] == 3080 ) {

        if ( [sender indexOfSelectedItem] == 0 ) {
            [statusWindow setExitEffect:[[ITCutWindowEffect alloc] initWithWindow:statusWindow]];
        } else if ( [sender indexOfSelectedItem] == 1 ) {
            [statusWindow setExitEffect:[[ITDissolveWindowEffect alloc] initWithWindow:statusWindow]];
        } else if ( [sender indexOfSelectedItem] == 2 ) {
            [statusWindow setExitEffect:[[ITSlideVerticallyWindowEffect alloc] initWithWindow:statusWindow]];
        } else if ( [sender indexOfSelectedItem] == 3 ) {
            [statusWindow setExitEffect:[[ITSlideHorizontallyWindowEffect alloc] initWithWindow:statusWindow]];
        } else if ( [sender indexOfSelectedItem] == 4 ) {
            [statusWindow setExitEffect:[[ITPivotWindowEffect alloc] initWithWindow:statusWindow]];
        }

        [[statusWindow exitEffect] setEffectTime:[swSpeedSlider floatValue]];

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
#pragma mark ITBevelView SUPPORT
/*************************************************************************/

- (IBAction)changeBevelViewSetting:(id)sender
{
    [bevelView setBevelDepth:[sender intValue]];
}


/*************************************************************************/
#pragma mark -
#pragma mark ITButton SUPPORT
/*************************************************************************/


/*************************************************************************/
#pragma mark -
#pragma mark NSWindow DELEGATE METHODS
/*************************************************************************/

- (void)windowWillMiniaturize:(NSNotification *)note
{
    [[note object] setMiniwindowImage:[NSImage imageNamed:@"ITStatusItem"]];
}


@end
