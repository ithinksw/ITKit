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

- (BOOL)castsShadow;
{
    return [[self cell] castsShadow];
}

- (void)setCastsShadow:(BOOL)newSetting;
{
    [[self cell] setCastsShadow:newSetting];
}

- (float)shadowElevation;
{
    return [[self cell] shadowElevation];
}

- (void)setShadowElevation:(float)newElevation;
{
    [[self cell] setShadowElevation:newElevation];
}

- (float)shadowAzimuth;
{
    return [[self cell] shadowAzimuth];
}

- (void)setShadowAzimuth:(float)newAzimuth;
{
    [[self cell] setShadowAzimuth:newAzimuth];
}

- (float)shadowAmbient;
{
    return [[self cell] shadowAmbient];
}

- (void)setShadowAmbient:(float)newAmbient;
{
    [[self cell] setShadowAmbient:newAmbient];
}

- (float)shadowHeight;
{
    return [[self cell] shadowHeight];
}

- (void)setShadowHeight:(float)newHeight;
{
    [[self cell] setShadowHeight:newHeight];
}

- (float)shadowRadius;
{
    return [[self cell] shadowRadius];
}

- (void)setShadowRadius:(float)newRadius;
{
    [[self cell] setShadowRadius:newRadius];
}

- (float)shadowSaturation;
{
    return [[self cell] shadowSaturation];
}

- (void)setShadowSaturation:(float)newSaturation;
{
    [[self cell] setShadowSaturation:newSaturation];
}


@end
