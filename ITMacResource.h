//
//  ITMacResource.h
//  ITKit
//
//  Created by Joseph Spiros on Thu Dec 25 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

typedef ResType ITMacResourceType;

@interface ITMacResource : NSObject {
    @protected
    Handle _handle;
}
+ (void)_registerClass:(Class)class forType:(ITMacResourceType)type;
+ (Class)_classForType:(ITMacResourceType)type;

+ (id)_resourceWithHandle:(Handle)handle;
- (id)_initWithHandle:(Handle)handle;

- (Handle)_handle;

- (NSData *)data;
- (ITMacResourceType)type;
- (NSNumber *)id;
- (NSString *)name;

- (Class)nativeRepresentationClass;
- (id)nativeRepresentation;
@end
