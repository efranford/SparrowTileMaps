//
//  TileSet.h
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 Abaondon Hope Games, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMXTile.h"
/*
 <tileset>
 
 firstgid: The first global tile ID of this tileset (this global ID maps to the first tile in this tileset).
 source: If this tileset is stored in an external TSX (Tile Set XML) file, this attribute refers to that file.
 name: The name of this tileset.
 tilewidth: The (maximum) width of the tiles in this tileset.
 tileheight: The (maximum) height of the tiles in this tileset.
 spacing: The spacing in pixels between the tiles in this tileset (applies to the tileset image).
 margin: The margin around the tiles in this tileset (applies to the tileset image).
 Can contain: properties (since 0.8.0), image, tile
 */
 
@interface TMXTileSet : NSObject

{
@private 
    NSInteger mFirstGid;
    NSString* mSource;
    NSString* mName;
    float mTileWidth;
    float mTileHeight;
    float mSpacing;
    float mMargin;
    
    NSMutableDictionary* mProperties;
    SPTexture* mTileSetImage;
    NSMutableDictionary* mTiles;
}
-(id) init;
-(id)initWithTexture:(SPTexture*)texture;
-(void) createTileSet;
/// Creates a region for a subtexture and gives it a name.
- (void)addTile:(SPRectangle*)region withID:(int)id;
/// Retrieve a subtexture by name. Returns `nil` if it is not found.
- (SPTexture *)tileByGid:(int)gid;

@property (nonatomic,assign) NSInteger firstGid;
@property (nonatomic,assign) NSString* source;
@property (nonatomic,assign) NSString* name;
@property (nonatomic,assign) float tileWidth;
@property (nonatomic,assign) float tileHeight;
@property (nonatomic,assign) float spacing;
@property (nonatomic,assign) float margin;
@property (nonatomic,assign) NSMutableDictionary* properties;
@property (nonatomic,assign) SPTexture* tileSetImage;
@property (nonatomic,assign) TMXTile* tile;
@property (nonatomic,assign) NSMutableDictionary* tiles;

/// The number of available subtextures.
@property (nonatomic, readonly) int count;

@end
