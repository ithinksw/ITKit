#import "Controller.h"
//#import "ITTransientStatusWindow.h"
#import "ITIconAndTextStatusWindow.h"
#import "ITTSWBackgroundView.h"
#import "ITTextField.h"
#import "ITBevelView.h"
#import "ITCutWindowEffect.h"
#import "ITDissolveWindowEffect.h"
#import "ITSlideHorizontallyWindowEffect.h"
#import "ITSlideVerticallyWindowEffect.h"
#import "ITPivotWindowEffect.h"
#import "ITZoomWindowEffect.h"
#import "ITMultilineTextFieldCell.h"


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
    statusWindow = [ITIconAndTextStatusWindow sharedWindow];
    [statusWindow setEntryEffect:[[ITCutWindowEffect alloc] initWithWindow:statusWindow]];
    [statusWindow setExitEffect:[[ITCutWindowEffect alloc] initWithWindow:statusWindow]];
    [[statusWindow entryEffect] setEffectTime:[swEntrySpeedSlider floatValue]];
    [[statusWindow exitEffect]  setEffectTime:[swExitSpeedSlider floatValue]];
    [self populateEffectPopups];
//  [tabView setAllowsDragging:YES];
    [[NSColorPanel sharedColorPanel] setShowsAlpha:YES];
    
    [tableView setRowHeight:200];
    [[tableView tableColumnWithIdentifier:@"custom"] setDataCell:[[[ITMultilineTextFieldCell alloc] init] autorelease]];
    [[tableView tableColumnWithIdentifier:@"image"] setDataCell:[[[NSImageCell alloc] init] autorelease]];
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

- (void)populateEffectPopups
{
    NSArray *effects = [ITWindowEffect effectClasses];
    int i;
    [entryEffectPopup removeAllItems];
    [exitEffectPopup removeAllItems];
    for (i = 0; i < [effects count]; i++) {
        id anItem = [effects objectAtIndex:i];
        [entryEffectPopup addItemWithTitle:[anItem effectName]];
        [exitEffectPopup addItemWithTitle:[anItem effectName]];
        [[entryEffectPopup lastItem] setRepresentedObject:anItem];
        [[exitEffectPopup lastItem] setRepresentedObject:anItem];
    }
}

- (IBAction)buildStatusWindow:(id)sender
{
    NSImage     *image        = [NSImage imageNamed:SW_IMAGE];
    NSString    *text     = [swSampleTextView string];
    [statusWindow setImage:image];
    [statusWindow buildTextWindowWithString:text];
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
    } else if ( [sender tag] == 3061 ) {
        [[statusWindow exitEffect]  setEffectTime:[sender floatValue]];
    } else if ( [sender tag] == 3070 ) {
        [statusWindow setEntryEffect:[[[[[sender selectedItem] representedObject] alloc] initWithWindow:statusWindow] autorelease]];
        [[statusWindow entryEffect] setEffectTime:[swEntrySpeedSlider floatValue]];
    } else if ( [sender tag] == 3080 ) {
        [statusWindow setExitEffect:[[[[[sender selectedItem] representedObject] alloc] initWithWindow:statusWindow] autorelease]];
        [[statusWindow exitEffect] setEffectTime:[swExitSpeedSlider floatValue]];
    } else if ( [sender tag] == 3090 ) {
        if ( [sender indexOfSelectedItem] == 0 ) {
            [(ITTSWBackgroundView *)[statusWindow contentView] setBackgroundMode:ITTSWBackgroundApple];
        } else if ( [sender indexOfSelectedItem] == 1 ) {
            [(ITTSWBackgroundView *)[statusWindow contentView] setBackgroundMode:ITTSWBackgroundReadable];
        } else if ( [sender indexOfSelectedItem] == 2 ) {
            [(ITTSWBackgroundView *)[statusWindow contentView] setBackgroundMode:ITTSWBackgroundColored];
        }
    } else if ( [sender tag] == 3100 ) {
        [(ITTSWBackgroundView *)[statusWindow contentView] setBackgroundColor:[sender color]];
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

/*************************************************************************/
#pragma mark -
#pragma mark ITMultilineTextFieldCell SUPPORT
/*************************************************************************/

- (int)numberOfRowsInTableView:(NSTableView *)aTableView {
    return 50;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex {
    if ([[aTableColumn dataCell] isKindOfClass:[ITMultilineTextFieldCell class]]) {
        if (rowIndex%2) {
            return [NSArray arrayWithObjects:@"Foo", @"Bar", @"- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex", @"- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex", @"- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex", @"- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex", @"- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex", @"- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex", @"- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex", @"- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex", @"- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex", @"- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex", @"- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex", nil];
        } else {
            return [NSArray arrayWithObjects:[[[NSAttributedString alloc] initWithString:@"This is a demo of ITMultilineTextFieldCell" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Gill Sans" size:48], NSFontAttributeName, [NSColor purpleColor], NSForegroundColorAttributeName, nil]] autorelease], [[[NSAttributedString alloc] initWithString:@"Bar" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Gadget" size:20], NSFontAttributeName, nil]] autorelease], [[[NSObject alloc] init] autorelease], nil];
        }
    } else if ([[aTableColumn dataCell] isKindOfClass:[NSImageCell class]]) {
        return [NSImage imageNamed:@"NSApplicationIcon"];
    } else {
        return @"I like cheese";
    }
}


@end
