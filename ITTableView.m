#import "ITTableView.h"
#import "ITTableCornerView.h"


@implementation ITTableView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        corner = [[ITTableCornerView alloc] initWithFrame:[[self cornerView] frame]];
        [corner setPullsDown:YES];
        [self setCornerView:corner];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if (self) {
        corner = [[ITTableCornerView alloc] initWithFrame:[[self cornerView] frame]];
        [corner setPullsDown:YES];
        [self setCornerView:corner];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)coder {
    [super encodeWithCoder:coder];
}

- (void)setCornerImage:(NSImage*)image {
    [corner setImage:image];
}

- (NSImage*)cornerImage {
    return [corner image];
}

- (void)setCornerMenu:(NSMenu*)menu {
    [corner setMenu:menu];
}

- (NSMenu*)cornerMenu {
    return [corner menu];
}

@end
