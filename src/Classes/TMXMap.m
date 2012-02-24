//
//  AHGTMXMap.m
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 Abaondon Hope Games, LLC. All rights reserved.
//

#import "Sparrow.h"

@implementation TMXMap

@synthesize version = mVersion;
@synthesize orientation = mOrientation;
@synthesize properties = mProperties;
@synthesize height = mHeight;
@synthesize width = mWidth;
@synthesize layers = mLayers;
@synthesize tileSet = mTileSet;
@synthesize tileWidth = mTileWidth;
@synthesize tileHeight = mTileHeight;
@synthesize objectGroups = mObjectGroups;
@synthesize map = mMap;
@synthesize currentUpperLeftX = mCurrentUpperLeftX;
@synthesize currentUpperLeftY = mCurrentUpperLeftY;

TMXLayer* lastLayer;
TMXTileSet* lastTileSet;
float displayHeight;
float displayWidth;
NSObject* currentParent;
NSString* currentObjectName;
Boolean transitioning;

- (id)initWithContentsOfFile:(NSString *)path width:(float)width height:(float)height
{
    self = [super init];
    displayHeight = height;
    displayWidth = width;
    mLayers = [[NSMutableDictionary alloc]init];
    mObjectGroups = [[NSMutableDictionary alloc]init];
    mProperties = [[NSMutableDictionary alloc] init];
    mCurrentUpperLeftX = 0;
    [self parseTMXXml:path];   
    return self;
}

- (void) westEdgeReached :(TMXEvent*)evt{
    NSLog(@"West[%f,%f]",evt.playerX, evt.playerY);
    //mCurrentUpperLeftX = displayWidth+mCurrentUpperLeftX;
    //[self createMapForPixelsX:evt.playerX y:evt.playerY width:displayWidth height:displayHeight];
}
/*
- (void)createMapForPixelsX:(int)x y:(int)y width:(int)width height:(int)height{
    NSLog(@"Create map with upper left at x=%i y=%i CUL=[%i,%i]",x,y,mCurrentUpperLeftX,mCurrentUpperLeftY);
    if(mLayers){
        [self removeAllChildren];
        for (id key in mLayers) {
            TMXLayer* layer = [mLayers objectForKey:key];
            NSMutableArray* rows = layer.tableData;
            for(NSMutableArray* row in rows) {
                for(TMXTile* i in row){
                    if(i.x*mTileSet.tileHeight < mCurrentUpperLeftX || i.y*mTileSet.tileWidth>displayHeight)
                    {
                        break;
                    }
                    if(i.tileGid >= mTileSet.firstGid)
                    {
                        NSLog(@"[%i,%i]=%i",i.x,i.y,i.tileGid);
                        SPImage* img = [[[SPImage alloc] initWithTexture:[mTileSet tileByGid:i.tileGid]]autorelease];
                        img.y =(i.y*mTileSet.tileHeight) - mTileSet.spacing - mCurrentUpperLeftX;
                        img.x = i.x*mTileSet.tileWidth-mTileSet.spacing - mCurrentUpperLeftY;
                        [self addChild:img];
                    }
                }
            }
        }
    }
}*/

/*
 south..
 if(i.x*mTileSet.tileHeight < mCurrentUpperLeftX || i.y*mTileSet.tileWidth>displayHeight)
 {
 break;
 }
 if(i.tileGid >= mTileSet.firstGid)
 {
 SPImage* img = [[[SPImage alloc] initWithTexture:[mTileSet tileByGid:i.tileGid]]autorelease];
 img.y =(i.x*mTileSet.tileHeight) - mTileSet.spacing - mCurrentUpperLeftX;
 img.x = i.y*mTileSet.tileWidth-mTileSet.spacing;
 [self addChild:img];
 }
 */

- (void)createMap
{
    [self removeAllChildren];
    if(mLayers){
        for (id key in mLayers) {
            float rowC =0, colC = 0;
            TMXLayer* layer = [mLayers objectForKey:key];
            NSMutableArray* rows = layer.tableData;
            for(NSMutableArray* row in rows) {
                colC = 0;
                for(TMXTile* i in row){
                    if(i.x*mTileSet.tileHeight > displayWidth || i.y*mTileSet.tileWidth>displayHeight){
                        break;
                    }
                    if(i.tileGid >= mTileSet.firstGid)
                    {
                        SPImage* img = [[[SPImage alloc] initWithTexture:[mTileSet tileByGid:i.tileGid]]autorelease];
                            img.x = i.y*mTileSet.tileWidth;
                            img.y = i.x*mTileSet.tileWidth;
                        [self addChild:img];
                    }
                    colC++;
                }
                rowC++;
            }
        }
    }
    
    /*if(mObjectGroups){
        for(id obj in mObjectGroups)
        {
            TMXObjectGroup* group = [mObjectGroups objectForKey:obj];
            if(group.objects)
            {
                for(id o in group.objects)
                {
                    NSLog(@"Trouble maker? %@", o);
                    TMXObject* object = (TMXObject*)[group.objects objectForKey:o];
                    //NSLog(@"[%i,%i]=%@", object.x,object.y,object.name);
                    if(object.polygon)
                    {
                        NSLog(@"%@ polygon..",object.name);
                        for(SPPoint* pt in object.polygon)
                        {
                            NSLog(@"pt[%f,%f]",pt.x,pt.y);
                        }
                    }
                }
            }
     
        }
    }*/
}

- (void)parseTMXXml:(NSString *)path
{
    if (!path) return;
    
    float scaleFactor = [SPStage contentScaleFactor];
    mPath = [[SPUtils absolutePathToFile:path withScaleFactor:scaleFactor] retain];    
    if (!mPath) [NSException raise:SP_EXC_FILE_NOT_FOUND format:@"file not found: %@", path];
    
    SP_CREATE_POOL(pool);
    
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:mPath];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    [xmlData release];
    
    xmlParser.delegate = self;    
    BOOL success = [xmlParser parse];
    
    SP_RELEASE_POOL(pool);
    
    if (!success)    
        [NSException raise:SP_EXC_FILE_INVALID 
                    format:@"could not parse texture atlas %@. Error code: %d, domain: %@", 
         path, xmlParser.parserError.code, xmlParser.parserError.domain];
    
    [xmlParser release];    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict 
{
    currentElementName = [elementName copy];
    if ([currentElementName isEqualToString:@"map"])
    {
        currentParent = self;
        mVersion = [attributeDict valueForKey:@"version"];
        mOrientation =[attributeDict valueForKey:@"orientation"];
        mWidth = [[attributeDict valueForKey:@"width"] intValue];
        mHeight = [[attributeDict valueForKey:@"height"]intValue];
        mTileWidth = [[attributeDict valueForKey:@"tilewidth"]intValue];
        mTileHeight = [[attributeDict valueForKey:@"tileheight"]intValue];
    }
    else if ([currentElementName isEqualToString:@"tileset"])
    {
        TMXTileSet* set = [[TMXTileSet alloc]init];
        set.firstGid = [[attributeDict valueForKey:@"firstgid"] intValue];
        set.name = [attributeDict valueForKey:@"name"];
        currentTileSetName = set.name;
        set.tileWidth = [[attributeDict valueForKey:@"tilewidth"]intValue];
        set.tileHeight = [[attributeDict valueForKey:@"tileheight"]intValue];
        set.spacing = [[attributeDict valueForKey:@"spacing"] intValue];
        mTileSet = set;
        currentParent = mTileSet;
    }
    else if([currentElementName isEqualToString:@"image"])
    {
        NSString* source = [attributeDict valueForKey:@"source"];
        float scaleFactor = [SPStage contentScaleFactor];
        NSString* imgPath = [SPUtils absolutePathToFile:source withScaleFactor:scaleFactor];    
        if (!imgPath) [NSException raise:SP_EXC_FILE_NOT_FOUND format:@"file not found: %@", imgPath];
        
        SPTexture* image = [[[SPTexture alloc] initWithContentsOfFile:imgPath]autorelease];
        mTileSet.tileSetImage = image;
    }
    else if([currentElementName isEqualToString:@"layer"])
    {
        TMXLayer* layer = [[TMXLayer alloc]init];
        layer.name = [attributeDict valueForKey:@"name"];
        currentLayerName = layer.name;
        layer.width = [[attributeDict valueForKey:@"width"]intValue];
        layer.height = [[attributeDict valueForKey:@"height"]intValue];
        [mLayers setObject:layer forKey:layer.name];
        lastLayer = layer;
    }
    else if([currentElementName isEqualToString:@"data"])
    {
        TMXData *data =  [[[TMXData alloc]init]autorelease];
        data.encoding = [attributeDict valueForKey:@"encoding"];
        data.compression = [attributeDict valueForKey:@"compression"];
        ((TMXLayer*)[mLayers objectForKey:currentLayerName]).data = data;
    }
    else if ([currentElementName isEqualToString:@"objectgroup"])
    {
        TMXObjectGroup *group = [[TMXObjectGroup alloc]init];
        group.name = [attributeDict valueForKey:@"name"];
        currentObjectGroupName = [[[NSString alloc]initWithString:group.name]retain];
        group.width = [[attributeDict valueForKey:@"width"]intValue];
        group.height = [[attributeDict valueForKey:@"height"]intValue];
        [mObjectGroups setObject:group forKey:group.name];
        currentParent = group;
    }
    else if([currentElementName isEqualToString:@"object"])
    {
        NSString* name = [attributeDict valueForKey:@"name"];
        NSString* type = [attributeDict valueForKey:@"type"];
        if(type == (id)[NSNull null] ||type.length == 0)
            type = [[[NSString alloc] initWithString:@"Undefined"] autorelease];
        TMXObject *object = [[[TMXObject alloc]initWithName:name andType:type]autorelease];
        object.x = [[attributeDict valueForKey:@"x"]intValue];
        object.y = [[attributeDict valueForKey:@"y"]intValue];
        object.width = [[attributeDict valueForKey:@"width"]intValue];
        object.height = [[attributeDict valueForKey:@"height"]intValue];
        TMXObjectGroup* temp = [mObjectGroups objectForKey:currentObjectGroupName];
        [temp.objects setObject:object forKey:object.name];
        currentObjectName  = object.name;
        currentParent = object;
    }
    else if([currentElementName isEqualToString:@"property"])
    {   
        NSString* name = [attributeDict valueForKey:@"name"];
        NSObject* value = [attributeDict valueForKey:@"value"];
        if([currentParent isKindOfClass:[TMXMap class]])
        {
            [[self properties] setValue:value forKey:name];
        }
        else if([currentParent isKindOfClass:[TMXLayer class]]){
            TMXLayer* layer = [mLayers valueForKey:currentLayerName];
            [layer.properties setValue:value forKey:name];
        }
        else if([currentParent isKindOfClass:[TMXObjectGroup class]]){
            TMXObjectGroup* group = [mObjectGroups valueForKey:currentObjectGroupName];
            [group.properties setValue:value forKey:name];
        }
        else if([currentParent isKindOfClass:[TMXObject class]]){
            TMXObjectGroup* group = [mObjectGroups valueForKey:currentObjectGroupName];
           [((TMXObject*)[group.objects valueForKey:currentObjectName]).properties  setValue:value forKey:name];
        }
        else{
        }
    }
    else if([currentElementName isEqualToString:@"polygon"])
    { 
        NSMutableArray* polygon = [[[NSMutableArray alloc]init]autorelease];
        NSString* pointString = [attributeDict valueForKey:@"points"];
        NSArray* points = [[[NSArray alloc]initWithArray:[pointString componentsSeparatedByString:@" "]]autorelease];
        for(int x =0; x < points.count; x++){
            NSString* point = [points objectAtIndex:x];
            NSArray* p = [point componentsSeparatedByString:@","];
            SPPoint* sp = [[[SPPoint alloc]initWithX:[[p objectAtIndex:0]intValue] y:[[p objectAtIndex:1]intValue]]autorelease];
            [polygon insertObject:sp atIndex:x];
        }
        ((TMXObject*)[((TMXObjectGroup*)[mObjectGroups valueForKey:currentObjectGroupName]).objects valueForKey:currentObjectName]).polygon = polygon;
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if([currentElementName isEqualToString:@"data"] && string.length > 0)
    { 
        ((TMXLayer*)[self.layers objectForKey:currentLayerName]).data.data = [[[NSString alloc]initWithString:string]autorelease];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    currentElementName = nil;
    if([elementName isEqualToString:@"layer"]){
        [[mLayers objectForKey:lastLayer.name] createTiles];
    }
    else if([elementName isEqualToString:@"map"]){
        [self createMap];
    }
    else if([elementName isEqualToString:@"tileset"]){
        [mTileSet init];
    }
}

- (id)pixeslToGrid:(int)x :(int)y{
    TMXTile* tile = [[[TMXTile alloc]init]autorelease];
    int row = floor(x/mTileWidth);
    int col = floor(y/mTileHeight);
    tile.row = row;
    tile.col = col;
    tile.x = x;
    tile.y = y;
    return tile;
}

- (id)gridToPixels:(int)row :(int)col
{
    TMXTile* tile = [[[TMXTile alloc]init]autorelease];
    int x = floor(row*mTileWidth);
    int y = floor(col*mTileHeight);
    tile.row = row;
    tile.col = col;
    tile.x = x;
    tile.y = y;
    return tile;
}

@end
