//
//  TMXMap.h
//  Sparrow
//
//  Created by Elliot Franford on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"

/*
 <map>
    version: The TMX format version, generally 1.0.
    orientation: Map orientation. Tiled supports "orthogonal" and "isometric" at the moment.
    width: The map width in tiles.
    height: The map height in tiles.
    tilewidth: The width of a tile.
    tileheight: The height of a tile.
 
 The tilewidth and tileheight properties determine the general grid size of the map. The individual tiles may have different sizes. Larger tiles will extend at the top and right (anchored to the bottom left).
 
 Can contain: properties, tileset, layer, objectgroup
 */


@interface TMXMap : SPDisplayObjectContainer <NSXMLParserDelegate>
{
@private
    NSString *mPath;
    NSString *mVersion; // version: The TMX format version, generally 1.0.
    NSString *mOrientation; // orientation: Map orientation. Tiled supports "orthogonal" and "isometric" at the moment.
    NSInteger mWidth; // width: The map width in tiles.
    NSInteger mHeight; // height: The map height in tiles.
    NSInteger mTileWidth; // tilewidth: The width of a tile.
    NSInteger mTileHeight; // tileheight: The height of a tile.
    NSMutableDictionary *mProperties;
    NSMutableDictionary *mLayers;
    TMXTileSet *mTileSet;
    NSMutableDictionary *mObjectGroups;
    SPDisplayObjectContainer *mMap;
    
    int mCurrentUpperLeftX;
    int mCurrentUpperLeftY;
    
    NSString *currentElementName;
    NSString *currentTileSetName;
    NSString *currentObjectGroupName;
    NSString *currentLayerName;
}
@property (nonatomic, assign) NSString* version;
@property (nonatomic, assign) NSString* orientation;
@property (nonatomic, assign) NSMutableDictionary* properties;
@property (nonatomic, assign) NSInteger width; // width: The map width in tiles.
@property (nonatomic, assign) NSInteger height; // height: The map height in tiles.
@property (nonatomic, assign) NSInteger tileWidth; // tilewidth: The width of a tile.
@property (nonatomic, assign) NSInteger tileHeight; // tileheight: The height of a tile.
@property (nonatomic, assign) int currentUpperLeftX;
@property (nonatomic, assign) int currentUpperLeftY;
@property (nonatomic, assign) NSMutableDictionary *layers;
@property (nonatomic, assign) TMXTileSet *tileSet;
@property (nonatomic, assign) NSMutableDictionary *objectGroups;
@property (nonatomic, assign) SPDisplayObjectContainer *map;

- (void)createMap;
//- (void)createMapForPixelsX:(int)x y:(int)y width:(int)width height:(int)height;
- (void)westEdgeReached:(TMXEvent*)evt;
- (id)initWithContentsOfFile:(NSString *)path width:(float)width height:(float)height;
- (void)parseTMXXml:(NSString *)path;
- (id)pixeslToGrid:(int)x :(int)y;
- (id)gridToPixels:(int)row :(int)col;
@end
