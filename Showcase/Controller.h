#import <ITKit/ITKit.h>
#import <Cocoa/Cocoa.h>

@interface Controller : NSObject
{
    IBOutlet NSWindow *window;
    
    // ITStatusItem Support
    ITStatusItem      *statusItem;
    IBOutlet NSMenu   *statusItemMenu;
    IBOutlet NSButton *showStatusItemCheckBox;
    IBOutlet NSButton *showImageCheckBox;
    IBOutlet NSButton *useInvertedCheckBox;
    IBOutlet NSButton *showTitleCheckBox;
    
    // ITTabView Support
    IBOutlet ITTabView *tabView;

    // ITTextField Support
    IBOutlet ITTextField *testTextField;

    // ITTransientStatusWindow Support
    ITTransientStatusWindow *statusWindow;
    IBOutlet NSTextView     *swSampleTextView;
    IBOutlet NSPopUpButton  *swVanishModePopup;
    IBOutlet NSPopUpButton  *swBackgroundTypePopup;
    IBOutlet NSPopUpButton  *swDefinedPositionPopup;
    IBOutlet NSTextField    *swVanishDelay;
}

// ITStatusItem Support
- (IBAction)toggleStatusItem:(id)sender;
- (IBAction)toggleImage:(id)sender;
- (IBAction)toggleInvertedImage:(id)sender;
- (IBAction)toggleTitle:(id)sender;

// ITTextField Support
- (IBAction)toggleCastsShadow:(id)sender;

// ITTransientStatusWindow Support
- (IBAction)buildStatusWindow:(id)sender;
- (IBAction)showStatusWindow:(id)sender;
- (IBAction)hideStatusWindow:(id)sender;
- (IBAction)setRotation:(id)sender;

// ITTabView support
- (IBAction)toggleTabDragging:(id)sender;
- (IBAction)toggleCommandDragging:(id)sender;
- (IBAction)toggleControlDragging:(id)sender;
- (IBAction)toggleOptionDragging:(id)sender;
- (IBAction)toggleShiftDragging:(id)sender;

@end
