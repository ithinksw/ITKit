#import "ITTextField.h"
#import "ITTextFieldCell.h"
#import <ApplicationServices/ApplicationServices.h>
#import "ITCoreGraphicsHacks.h"


/*************************************************************************/
#pragma mark -
#pragma mark IMPLEMENTATION
/*************************************************************************/

@implementation ITTextField


/*************************************************************************/
#pragma mark -
#pragma mark INITIALIZATION METHODS
/*************************************************************************/

+ (void)initialize
{
    if ( self == [ITTextField class] ) {
        [self setCellClass:[ITTextFieldCell class]];
    }
}

+ (Class)cellClass
{
    return [ITTextFieldCell class];
}


/*************************************************************************/
#pragma mark -
#pragma mark ACCESSOR METHODS
/*************************************************************************/

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
