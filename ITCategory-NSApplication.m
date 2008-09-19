#import "ITCategory-NSApplication.h"

@implementation NSApplication (ITKitCategory)

- (NSString *)applicationName {
	NSString *applicationName;
	if (!(applicationName = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:(NSString *)kCFBundleNameKey])) {
		applicationName = [[NSProcessInfo processInfo] processName];
	}
	return applicationName;
}

@end
