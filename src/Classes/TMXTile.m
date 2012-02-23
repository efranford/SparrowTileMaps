//
//  TMXTile.m
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TMXTile.h"

@implementation TMXTile
@synthesize tileGid = mTileGid;
@synthesize x = mX;
@synthesize y = mY;
@synthesize properties = mProperties;
@synthesize row = mRow;
@synthesize col = mCol;
-(id) init
{
    return self;
}

- (id) initWithXYGid:(NSInteger)gid x:(NSInteger)x y:(NSInteger)y
{
    mX = x;
    mY = y;
    mTileGid = gid;
    return self;
}

@end
