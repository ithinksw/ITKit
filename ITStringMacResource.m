//
//  ITStringMacResource.m
//  ITKit
//
//  Created by Joseph Spiros on Thu Dec 25 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "ITStringMacResource.h"


@implementation ITStringMacResource

+ (void)load {
    [ITMacResource _registerClass:self forType:'STR '];
}

- (Class)nativeRepresentationClass {
    return [NSString class];
}

- (id)nativeRepresentation {
    return @"Not Implemented Yet";
}

@end
