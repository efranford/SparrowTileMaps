//
//  TMXTile.h
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SPImage.h"
/*
 <tile>
 
 id: The local tile ID within its tileset.
 Can contain: properties, image
 */
@interface TMXTile : NSObject
    {
    @private
        NSInteger mTileGid;
        NSInteger mX;
        NSInteger mY;
        NSInteger mRow;
        NSInteger mCol;
        NSMutableDictionary* mProperties;
    }
    @property (nonatomic,assign) NSInteger tileGid;
    @property (nonatomic,assign) NSInteger x;
    @property (nonatomic,assign) NSInteger y;
    @property (nonatomic,assign) NSInteger row;
    @property (nonatomic,assign) NSInteger col;
    @property (nonatomic,assign) NSMutableDictionary* properties;


    - (id) init;
    - (id) initWithXYGid:(NSInteger)gid x:(NSInteger)x y:(NSInteger)y;

@end
