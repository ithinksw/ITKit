#import <Cocoa/Cocoa.h>


typedef enum _ITBezelStyle {
    ITGrayRoundedBezelStyle  = 1001
} ITBezelStyle;


@interface ITButtonCell : NSButtonCell {

    ITBezelStyle _subStyle;

}


@end
