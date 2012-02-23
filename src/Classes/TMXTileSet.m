//
//  TileSet.m
//  Sparrow
//
//  Created by Elliot Franford on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TMXTileSet.h"
#import "Sparrow.h"

@implementation TMXTileSet
@synthesize firstGid = mFirstGid;
@synthesize margin = mMargin;
@synthesize tileSetImage = mTileSetImage;
@synthesize name = mName;
@synthesize spacing = mSpacing;
@synthesize tile = mTile;
@synthesize source = mSource;
@synthesize tileWidth = mTileWidth;
@synthesize properties = mProperties;
@synthesize tileHeight = mTileHeight;
@synthesize tiles = mTiles;

- (id)init
{
    return [self initWithTexture:mTileSetImage];
}

-(id)initWithTexture:(SPTexture*)texture
{
    [super init];
    mProperties = [[NSMutableDictionary alloc]init];
    mTiles = [[NSMutableDictionary alloc]init];
    mTileSetImage = [texture retain];
    [self createTileSet];
    return self;
}

- (int)count
{
    return [mTiles count];
}

-(void) createTileSet{
     if (mTileWidth && mTileHeight)
    {
        float x = 0;
        float y = 0;
        float currentRow = 0;
        float currentColumn = 0;
        float columnCount = 0;
        int id = mFirstGid;      
        while(x < mTileSetImage.width){
            if((x + mTileWidth+mSpacing) > mTileSetImage.width)
            {
                x =0+mSpacing;
                if(currentColumn > columnCount)
                    columnCount = currentColumn;
                currentColumn = 0;
                currentRow++;
                if((y + mTileHeight+mSpacing) > mTileSetImage.height)
                    break;
                else
                    y += (mTileHeight + mSpacing);
            }
            else
            {    
                [self addTile: [SPRectangle rectangleWithX:x y:y width:mTileWidth-mSpacing height:mTileHeight-mSpacing] withID:id];
                x += (mTileHeight+ mSpacing);
                currentColumn++;
                id++;
            }
        }
    }
}

- (void)addTile:(SPRectangle *)region withID:(int)id
{
    [mTiles setObject:region forKey: [NSString stringWithFormat:@"%i", id]];
}

- (SPTexture *)tileByGid:(int)gid
{    
    SPRectangle *region = [mTiles objectForKey: [NSString stringWithFormat:@"%d", gid]];
    if (!region) 
    {
        NSLog(@"no region for %i", gid);
        return nil;   
    }    
    
    SPTexture *texture = [SPSubTexture textureWithRegion:region ofTexture:mTileSetImage];
    if(!texture)
        NSLog(@"no texture for %i", gid);
    
    return texture;
}

@end
