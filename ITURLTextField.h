/* ITURLTextField */

#import <Cocoa/Cocoa.h>

@interface ITURLTextField : NSTextField
{
	NSURL *_url;
}
- (void)setURL:(NSURL *)url;
@end
