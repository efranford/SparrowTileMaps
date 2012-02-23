//
//  TMXObject.h
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 Abaondon Hope Games, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"
/*
 <object>
 
 name: The name of the object. An arbitrary string.
 type: The type of the object. An arbitrary string.
 x: The x coordinate of the object in pixels.
 y: The y coordinate of the object in pixels.
 width: The width of the object in pixels.
 height: The height of the object in pixels.
 gid: An reference to a tile (optional).
 While tile layers are very suitable for anything repetitive aligned to the tile grid, sometimes you want to annotate your map with other information, not necessarily aligned to the grid. Hence the objects have their coordinates and size in pixels, but you can still easily align that to the grid when you want to.
 
 You generally use objects to add custom information to your tile map, such as spawn points, warps, exits, etc.
 
 When the object has a gid set, then it is represented by the image of the tile with that global ID. Currently that means width and height are ignored for such objects. The image alignment currently depends on the map orientation. In orthogonal orientation it's aligned to the bottom-left while in isometric it's aligned to the bottom-center.
 
 Can contain: properties, polygon, polyline, image
 */

@interface TMXObject : NSObject

{
    @private
    NSString* mName;
    NSString* mType;
    NSInteger mX;
    NSInteger mY;
    NSInteger mWidth;
    NSInteger mHeight;
    NSInteger mGID;
    NSMutableDictionary* mProperties;
    NSArray* mPolygon;
    
}
@property (nonatomic, assign) NSString* name;
@property (nonatomic, assign) NSString* objType;
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger gid;
@property (nonatomic, assign) NSMutableDictionary* properties;
@property (nonatomic, assign) NSArray* polygon;

- (id)init;
- (id)initWithName:(NSString*)name andType:(NSString*)type;
- (id)initWithName:(NSString*)name andType:(NSString*)type withProperties:(NSMutableDictionary*)props andPoly:(NSArray*)poly;
- (bool) hitTest:(id) object;
- (void) dealloc;
@end
