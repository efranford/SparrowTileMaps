//
//  TMXObjectGroup.m
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TMXObjectGroup.h"

@implementation TMXObjectGroup
    @synthesize name = mName;
    @synthesize x = mX;
    @synthesize y = mY;
    @synthesize width = mWidth;
    @synthesize height = mHeight;
    @synthesize color = mColor;
    @synthesize opacity = mOpacity;
    @synthesize visible = mVisible;
    @synthesize objects = mObjects;
    @synthesize properties = mProperties;

- (id)init
{
    self = [super init];
    mObjects = [[NSMutableDictionary alloc]init];
    return self;
}

@end

