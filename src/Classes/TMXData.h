//
//  TMXData.h
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 <data>
 
 encoding: The encoding used to encode the tile layer data. When used, it can be "base64" and "csv" at the moment.
 compression: The compression used to compress the tile layer data. Tiled Qt supports "gzip" and "zlib".
 When no encoding or compression is given, the tiles are stored as individual XML tile elements. Next to that, the easiest format to parse is the "csv" (comma separated values) format.
 
 The base64-encoded and optionally compressed layer data is somewhat more complicated to parse. First you need to base64-decode it, then you may need to decompress it. Now you have an array of bytes, which should be interpreted as an array of unsigned 32-bit integers using little-endian byte ordering.
 
 Whatever format you choose for your layer data, you will always end up with so called "global tile IDs" (gids). They are global, since they may refer to a tile from any of the tilesets used by the map. In order to find out from which tileset the tile is you need to find the tileset with the highest firstgid that is still lower or equal than the gid. The tilesets are always stored with increasing firstgids.
 
 When you use the tile flipping feature added in Tiled Qt 0.7.0, the highest two bits of the gid store the flipped state. Bit 32 is used for storing whether the tile is horizontally flipped and bit 31 is used for the vertically flipped tiles. And since Tiled Qt 0.8.0, bit 30 means whether the tile is flipped (anti) diagonally, enabling tile rotation. These bits have to be read and cleared before you can find out which tileset a tile belongs to.
 

*/
@interface TMXData : NSObject
{
    @private
    NSString *mEncoding;
    NSString *mCompression;
    NSString *mData;
}
@property (nonatomic,assign) NSString* encoding;
@property (nonatomic,assign) NSString* data;
@property (nonatomic,assign) NSString* compression;

-(id) init;
-(NSString*) getData;
-(id) decode;
-(NSData*) decompress;
@end
