//
//  startBlackWhiteGameLayer.m
//  inputChickenNameView
//
//  Created by Lozen on 11/10/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "startBlackWhiteGameLayer.h"
#import "blackWhiteLayer.h"
#import "roundGirlLayer.h"
#import "myChickens.h"
#import "CCTransitionPageTurn.h"

#import "save_ChickenData.h"
#import "jagenLayer.h"


@implementation startBlackWhiteGameLayer

@class save_ChickenData;

+(id) Scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CCLayer *layer = [startBlackWhiteGameLayer node];
    
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    
    CCSprite* blackWhiteBg = [CCSprite spriteWithFile:@"blackWhiteBg.png"];
    blackWhiteBg.anchorPoint = CGPointMake(0, 0);
    [layer addChild:blackWhiteBg z:0 tag:0];
    
	// return the scene
    
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
    
    
        save_ChickenData *getMyChickenNameClass = [[save_ChickenData alloc]init];
        
        NSString* chickenName = [getMyChickenNameClass GetMyChickenName:[[getMyChickenNameClass GetMychickenNumber] integerValue]];
        
        NSLog(@"myChickenName = %@", chickenName);
        
        //self.isTouchEnabled = YES;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
//		CCSprite* blackWhiteBg = [CCSprite spriteWithFile:@"blackWhiteBg.png"];
//        blackWhiteBg.anchorPoint = CGPointMake(0, 0);
//        [self addChild:blackWhiteBg z:0 tag:0];
        
        CCNode *comNode = [myChickens com_node];
        CCNode *userNode = [myChickens user_node];
        
        comNode.position = CGPointMake(size.width * 0.7, size.height *0.66);
        userNode.position = CGPointMake(size.width * 0.3, size.height * 0.25);  
        
        [self addChild:comNode z:1 tag:1];
        [self addChild:userNode z:2 tag:2];
        
        CCNode *vsNode = [myChickens vs_node];
        [self addChild:vsNode z:3 tag:3];
        
        CCLabelTTF *showUserName = [CCLabelTTF labelWithString:chickenName fontName:@"Marker Felt" fontSize:40];
        //showUserName.color = ccWHITE;
        [self addChild:showUserName z:4 tag:4];
        NSLog(@"showmyname : %@", chickenName);
        
        showUserName.position = CGPointMake(size.width * 0.3, size.height * 0.1);
        
        [vsNode runAction:[CCSequence actions:
                           [CCDelayTime actionWithDuration:3.0f],
                           [CCBlink actionWithDuration:0.5 blinks:8],
                           [CCCallFuncND actionWithTarget:self selector:@selector(goRoundGirl:data:)data:(void *)1],
                           nil]];
        
        //self.isTouchEnabled = YES;
                        
    
	}
	return self;
}

-(void)goRoundGirl:(id)sender data:(NSInteger)data
{
    [self removeChildByTag:1 cleanup:YES];
    [self removeChildByTag:2 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    [self removeChildByTag:4 cleanup:YES];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCNode *girlNode = [myChickens round_node:(NSInteger)data];
    girlNode.position = CGPointMake(size.width/2, size.height * 0.6);
    [self addChild:girlNode z:1 tag:1];
    
    [self runAction:[CCSequence actions:
    				 [CCDelayTime actionWithDuration:2.0f],
    				 [CCCallFunc actionWithTarget:self selector:@selector(gotoJaGenScene)],
    				 nil]];
}


-(void)gotoJaGenScene
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCNode* userReadyNode = [myChickens user_ready];
    [self addChild:userReadyNode z:1 tag:1];
    userReadyNode.position = CGPointMake(size.width * 0.3, size.height * 0.1);
    
    CCNode* comReadyNode = [myChickens com_ready];
    [self addChild:comReadyNode z:2 tag:2];
    comReadyNode.position = CGPointMake(size.width * 0.6, size.height * 0.65);
    
    
    
    //[self runAction:[CCDelayTime actionWithDuration:2.0f]];
    
    CCNode * myCountdown = [jagenLayer countdown];
    [self addChild:myCountdown z:9 tag:9];
    myCountdown.position = CGPointMake(size.width /2, size.height / 2);
    //CCNode* sayChickenFight = [jagenLayer SayChickenFight];
    //[self addChild:sayChickenFight z:8 tag:8];
    //sayChickenFight.position = CGPointZero;
    //[sayChickenFight runAction:[CCDelayTime actionWithDuration:2]];
    
    [self runAction:[CCDelayTime actionWithDuration:5.0f]];
    
    //跳出剪刀石頭布對話框
    
    CCSprite *jagenDialog = [jagenLayer ShowJaGenDialog];
    [self addChild:jagenDialog z:3 tag:3];
    //jagenDialog.position = CGPointMake(size.width * 0.55, size.height * 0.3);  
    jagenDialog.position = CGPointMake(size.width * 0.55, -size.height * 0.5);
    [jagenDialog runAction:[CCSequence actions:
                          [CCDelayTime actionWithDuration:3.0f],
                          [CCJumpTo actionWithDuration:0.5f position:CGPointMake(size.width * 0.55, size.height * 0.4) height:size.height * 0.3 jumps:1], nil]];    
    
    //[menu alignItemsHorizontallyWithPadding:10];
    //CCNode* menu = [jagenLayer ShowJaGenDialog];
    CCMenuItem *scissorsItem = [CCMenuItemImage itemFromNormalSprite:[jagenLayer ItemsForJaGen:1] selectedSprite:nil target:self selector:@selector(scissorsItemTouched)];
    CCMenuItem *rockItem = [CCMenuItemImage itemFromNormalSprite:[jagenLayer ItemsForJaGen:2] selectedSprite:[jagenLayer ItemsForJaGen:5] target:self selector:@selector(rockItemTouched)];
    CCMenuItem *paperItem = [CCMenuItemImage itemFromNormalSprite:[jagenLayer ItemsForJaGen:3] selectedSprite:[jagenLayer ItemsForJaGen:4] target:self selector:@selector(paperItemTouched)];
    CCMenu *jagenMenu = [CCMenu menuWithItems:scissorsItem, rockItem, paperItem, nil];
    scissorsItem.position = CGPointMake(size.width * 0.2, size.height * 0.4);
    rockItem.position = CGPointMake(size.width * 0.5, size.height * 0.4);
    paperItem.position = CGPointMake(size.width * 0.8, size.height * 0.4);
    [self addChild:jagenMenu z:4 tag:4];
    //jagenMenu.position = CGPointZero;
    jagenMenu.position = CGPointMake(0, -size.height * 0.5);
    [jagenMenu runAction:[CCSequence actions:
                          [CCDelayTime actionWithDuration:3.5f],
                          [CCJumpTo actionWithDuration:0.5f position:CGPointMake(0, size.height * 0.1) height:size.height * 0.5 jumps:1], nil]];
    
    
}

-(NSInteger)comAnswer
{
    arc4random();
    NSInteger randJagen = arc4random() % 3 + 1;
    NSLog(@"%d", randJagen);
    return randJagen;
}

-(void)WhoisWinner:(NSInteger)userJagenNumber
{
    

    CGSize size = [[CCDirector sharedDirector] winSize];
    CCNode * myDialog = [self getChildByTag:3];
    CCNode * myJagenMenu = [self getChildByTag:4];
    
    CCNode * bigNode;
    switch (userJagenNumber) {
        case 1:
            bigNode = [self getChildByTag:5];
            break;
        case 2:
            bigNode = [self getChildByTag:6];
            break;
        case 3:
            bigNode = [self getChildByTag:7];
            break;
    }
    
    //CCNode * bigScissorsNode = [self getChildByTag:5];
    
    [myDialog runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.3 position:CGPointMake(0, 0)],
                         [CCHide action],nil]];
    [myJagenMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.3 position:CGPointMake(0, 0)],
                            [CCHide action],nil]];
    [bigNode runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.0],
                                 [CCMoveTo actionWithDuration:0.3 position:CGPointMake(size.width * 0.7, size.height * 0.2)],
                                 [CCHide action],[CCDelayTime actionWithDuration:3]
                                 ,nil]];
    NSInteger comJagenNumber = [self comAnswer];
    
    NSNumber* myComJagenNumber = [NSNumber numberWithInteger:comJagenNumber];
    NSNumber* myUserJagenNumber = [NSNumber numberWithInteger:userJagenNumber];
    //NSInteger myJagenNumber = userJagenNumber;
    NSMutableArray * jagenArray = [[NSMutableArray alloc] initWithObjects:myUserJagenNumber,myComJagenNumber, nil];
    
    CCSprite *comJagenImage = [jagenLayer ItemsForJaGen:comJagenNumber + 3];
    [self addChild:comJagenImage z:10 tag:10];
    comJagenImage.position = CGPointMake(size.width * 0.2, size.height * 0.7);
    [self runAction:[CCDelayTime actionWithDuration:3]];

    
    CCSprite *miniScissorsImage = [jagenLayer ItemsForJaGen:userJagenNumber];
    [self addChild:miniScissorsImage z:11 tag:11];
    miniScissorsImage.position = CGPointMake(size.width * 0.7, size.height * 0.2);
    [miniScissorsImage runAction:[CCSequence actions:[CCHide action],
                                  [CCDelayTime actionWithDuration:0.3],[CCShow action],
                                  [CCDelayTime actionWithDuration:3],
                                  [CCCallFuncND actionWithTarget:self selector:@selector(ReJaGenScene:data:)data:(NSArray*)jagenArray],
                                  nil]];
    
    
  }

-(void) ReJaGenScene:(id)sender data:(NSArray*) jagenArray
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    NSArray* myArray = (NSArray*)jagenArray;
    NSInteger userJagen = (NSInteger)[myArray objectAtIndex:0];
    NSInteger comJagen = (NSInteger)[myArray objectAtIndex:1];
    
                
    //    NSLog(@"comJagen = %d", comJagen);
    //    NSLog(@"comJagen = %d", userJagenNumber);
    
    //NSInteger comJagen = [self comAnswer];
    if (comJagen == userJagen)
     {
                          [self removeChildByTag:5 cleanup:YES];
                 [self removeChildByTag:6 cleanup:YES];
                 [self removeChildByTag:7 cleanup:YES];
        [self removeChildByTag:10 cleanup:YES];
        [self removeChildByTag:11 cleanup:YES];
        [self removeChildByTag:3 cleanup:YES];
        [self removeChildByTag:4 cleanup:YES];
       //[self removeChild:bigNode cleanup:YES];
            NSLog(@"平手");
            [self gotoJaGenScene];
    
        }    
    else
        {
            [[CCDirector sharedDirector] replaceScene:[blackWhiteLayer Scene]];
            NSLog(@"誰輸");
    }

}

-(void)scissorsItemTouched
{
    CCMenu * menu = (CCMenu *)[self getChildByTag:4];
    menu.isTouchEnabled = NO;
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *bigScissorsImage = [jagenLayer ItemsForJaGen:4];
    bigScissorsImage.position = CGPointMake(size.width * 0.2, size.height * 0.5);
    [self addChild:bigScissorsImage z:5 tag:5];
    
    [self runAction:[CCDelayTime actionWithDuration:1]];
    
    [self WhoisWinner:1];
    
    NSLog(@"choseScissors");
}

-(void)rockItemTouched
{
    CCMenu * menu = (CCMenu *)[self getChildByTag:4];
    menu.isTouchEnabled = NO;
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *bigRockImage = [jagenLayer ItemsForJaGen:5];
    bigRockImage.position = CGPointMake(size.width * 0.5, size.height * 0.5);
    [self addChild:bigRockImage z:6 tag:6];

    [self runAction:[CCDelayTime actionWithDuration:1]];
    
    [self WhoisWinner:2];
    
    NSLog(@"choseRock");
}

-(void)paperItemTouched
{
    CCMenu * menu = (CCMenu *)[self getChildByTag:4];
    menu.isTouchEnabled = NO;
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *bigPaperImage = [jagenLayer ItemsForJaGen:6];
    bigPaperImage.position = CGPointMake(size.width * 0.8, size.height * 0.5);
    [self addChild:bigPaperImage z:7 tag:7];
   
    [self runAction:[CCDelayTime actionWithDuration:1]];
    
    [self WhoisWinner:3];
    
    NSLog(@"chosePaper");
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"began");
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //self.isTouchEnabled = NO;
    
    

    
    
   // [[CCDirector sharedDirector] replaceScene:[blackWhiteLayer Scene]];
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
