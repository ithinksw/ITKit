#import "ITLoginItem.h"
#import <Carbon/Carbon.h>
#import <CoreServices/CoreServices.h>
#import <ITFoundation/ITFoundation.h>

void ITSetApplicationLaunchOnLogin(NSString *path, BOOL flag) {
	if ((flag && ITDoesApplicationLaunchOnLogin(path)) || ![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		return;
	}
	NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary *loginwindow;
	NSMutableArray *loginarray;

	ITDebugLog(@"Set if \"%@\" launches at login to %i.", path, flag);
	[df synchronize];
	loginwindow = [[df persistentDomainForName:@"loginwindow"] mutableCopy];
	loginarray = [[loginwindow objectForKey:@"AutoLaunchedApplicationDictionary"] mutableCopy];

	if (flag) {
		/*FSRef fileRef;
		AliasHandle alias;
		NSData *aliasData;
		FSPathMakeRef([path UTF8String], &fileRef, NULL);
		FSNewAlias(NULL, &fileRef, &alias);
		aliasData = [NSData dataWithBytes:&alias length:GetHandleSize((Handle)alias)];*/

		if (!loginarray) { //If there is no loginarray of autolaunch items, create one
			loginarray = [[[NSMutableArray alloc] init] autorelease];
		}
		NSDictionary *itemDict = [NSDictionary dictionaryWithObjectsAndKeys:
			[[NSBundle mainBundle] bundlePath], @"Path",
			[NSNumber numberWithInt:0], @"Hide",
			[NSData data], @"AliasData", nil, nil];
		[loginarray addObject:itemDict];
	} else {
		int i;
		for (i = 0;i < [loginarray count];i++) {
			NSDictionary *tempDict = [loginarray objectAtIndex:i];
			if ([[[tempDict objectForKey:@"Path"] lastPathComponent] isEqualToString:[path lastPathComponent]]) {
				[loginarray removeObjectAtIndex:i];
				break;
			}
		}
	}
	[loginwindow setObject:loginarray forKey:@"AutoLaunchedApplicationDictionary"];
	[df setPersistentDomain:loginwindow forName:@"loginwindow"];
	[df synchronize];
	[loginwindow release];
	[loginarray release];
}

BOOL ITDoesApplicationLaunchOnLogin(NSString *path) {
	NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
	NSDictionary *loginwindow;
	NSMutableArray *loginarray;
	NSEnumerator *loginEnum;
	id anItem;
	ITDebugLog(@"Checking if \"%@\" launches at login.", path);
	[df synchronize];
	loginwindow = [df persistentDomainForName:@"loginwindow"];
	loginarray = [loginwindow objectForKey:@"AutoLaunchedApplicationDictionary"];

	loginEnum = [loginarray objectEnumerator];
	while ((anItem = [loginEnum nextObject])) {
		if ([[[anItem objectForKey:@"Path"] lastPathComponent] isEqualToString:[path lastPathComponent]]) {
			return YES;
		}
	}
	return NO;
}