//
//  TMXObject.m
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 Abaondon Hope Games, LLC. All rights reserved.
//

#import "TMXObject.h"

@implementation TMXObject
    @synthesize width = mWidth;
    @synthesize height = mHeight;
    @synthesize x = mX;
    @synthesize y = mY;
    @synthesize gid = mGID;
    @synthesize name = mName;
    @synthesize objType = mType;
    @synthesize properties = mProperties;
    @synthesize polygon = mPolygon;

- (id)init
{
    self = [super init];
    return self;
}

-(id)initWithName:(NSString*)name andType:(NSString*)type{
    self = [super init];
    self.name = [[NSString alloc]initWithString:name];
    self.objType = [[NSString alloc]initWithString:type];
    self.properties = [[NSMutableDictionary alloc]init];
    self.polygon = [[NSArray alloc] init];    
    return self;
}

- (id)initWithName:(NSString*)name andType:(NSString*)type withProperties:(NSMutableDictionary*)props andPoly:(NSArray*)poly
{
    self = [super init];
    self.name = [[NSString alloc]initWithString:name];
    self.objType = [[NSString alloc]initWithString:type];
    self.properties = [[NSMutableDictionary alloc]initWithDictionary:props];
    self.polygon = [[NSArray alloc] initWithArray:poly];    
    return self;
}
- (bool) hitTest:(id) object
{
    bool result = NO;
    if([object isKindOfClass:AHGPlayer.class])
    {
        AHGPlayer* player  = ((AHGPlayer*)object);
       //  if([self.polygon])
        {
            
        }

    }
    return result;
}


-(void) dealloc{
    [self.name dealloc];
    [self.objType dealloc];
    [self.properties dealloc];
    [self.polygon dealloc];
    [self dealloc];
}
@end
