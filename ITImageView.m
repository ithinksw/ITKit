#import "ITImageView.h"
#import "ITImageCell.h"


@implementation ITImageView


+ (void)initialize
{
    if ( self == [ITImageView class] ) {
        [self setCellClass:[ITImageCell class]];
    }
}

+ (Class)cellClass
{
    return [ITImageCell class];
}

- (id)initWithFrame:(NSRect)rect
{
    if ( (self = [super initWithFrame:rect]) ) {
        [self setScalesSmoothly:YES];
    }
    
    return self;
}

- (BOOL)scalesSmoothly
{
    return [[self cell] scalesSmoothly];
}

- (void)setScalesSmoothly:(BOOL)flag
{
    [[self cell] setScalesSmoothly:flag];
}


@end
