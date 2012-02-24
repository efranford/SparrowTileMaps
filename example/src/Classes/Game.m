//
//  Game.m
//  AppScaffold
//

#import "Game.h" 
#import "Sparrow.h"
#import "TMXMap.h"

@implementation Game

- (id)initWithWidth:(float)width height:(float)height
{
    if ((self = [super initWithWidth:width height:height]))
    {
        // this is where the code of your game will start. 
        // in this sample, we add just a simple quad to see if it works.
        
        TMXMap* map = [[TMXMap alloc] initWithContentsOfFile:@"map.tmx" width:width height:height];
        [self addChild:map];
        
        // Per default, this project compiles as an iPhone application. To change that, enter the 
        // project info screen, and in the "Build"-tab, find the setting "Targeted device family".
        //
        // Now Choose:  
        //   * iPhone      -> iPhone only App
        //   * iPad        -> iPad only App
        //   * iPhone/iPad -> Universal App  
        // 
        // If you want to support the iPad, you have to change the "iOS deployment target" setting
        // to "iOS 3.2" (or "iOS 4.2", if it is available.)
    }
    return self;
}
@end
