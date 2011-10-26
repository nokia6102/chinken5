//
//  HelloWorldLayer.m
//  inputChickenNameView
//
//  Created by Lozen on 11/10/16.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "inputChickenNameLayer.h"
#import "blackWhiteLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        
        
		// create and initialize a Label
//		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
//
//		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
//	
//		// position the label on the center of the screen
//		label.position =  ccp( size.width /2 , size.height/2 );
//		
//		// add the label as a child to this Layer
//		[self addChild: label];
        
        CCMenuItemFont *item1 = [CCMenuItemFont itemFromString:@"輸入名字" target:self selector:@selector(gotoinputChickenName:)];
        CCMenuItemFont *item2 = [CCMenuItemFont itemFromString:@"黑白配" target:self selector:@selector(gotoBlackWhiteGame:)];
        CCMenu *menu = [CCMenu menuWithItems:item1,item2, nil];
        menu.position = CGPointMake(size.width/ 2, size.height/ 2);
        [self addChild:menu];
        [menu alignItemsVerticallyWithPadding:40];
	}
	return self;
}

-(IBAction)gotoinputChickenName:(id)sender
{
    NSLog(@"chickenName");
    [[CCDirector sharedDirector] runWithScene:[inputChickenNameLayer chickenNameScene]];
}
-(IBAction)gotoBlackWhiteGame:(id)sender
{
    [[CCDirector sharedDirector] runWithScene:[blackWhiteLayer Scene]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
