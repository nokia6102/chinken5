//
//  ChooseRole.m
//  ChickenFight
//
//  Created by App on 2011/10/11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

//#import "AtHomeScene.h"
#import "ChooseRole.h"
#import "save_ChickenData.h"
#import "inputChickenNameLayer.h"
#import "AtHomeScene.h"
#import "SimpleAudioEngine.h"
#import "GetNewEgg.h"
//#import "CCTouchDispatcher.h"


@implementation ChooseRole

+(CCScene *) scene;
{
    CCScene *scene=[CCScene node];
    ChooseRole *layer=[ChooseRole node];
    [scene addChild:layer];
    return scene;
    
}


-(id)init
{
    if((self=[super init]))
    {
      
       [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];//stop 
        CCLOG(@"%@:%@",NSStringFromSelector(_cmd),self);
        self.isAccelerometerEnabled = YES;
        self.isTouchEnabled=YES;
        
        
        CGSize screenSize=[CCDirector sharedDirector].winSize;
        
        //背景
        bg=[CCSprite spriteWithFile:@"loadyourChicken.png"];
        [self addChild:bg z:0 tag:0 ];
        bg.position=CGPointMake(screenSize.width/2, screenSize.height/2);
        
        save_ChickenData* saveChickenNameClass = [[save_ChickenData alloc] init];
        
        //角色名稱
        playerName1=[saveChickenNameClass GetMyChickenName:1];
        playerName2=[saveChickenNameClass GetMyChickenName:2];
        playerName3=[saveChickenNameClass GetMyChickenName:3];
        
        if (playerName1 == @"") {
            player1 = [self TheChickenOfPlayers:YES :1];
        }else{
            player1 = [self TheChickenOfPlayers:NO :1];
        }
       
        if (playerName2 == @"") {
            player2 = [self TheChickenOfPlayers:YES :2];
        }else{
            player2 = [self TheChickenOfPlayers:NO :2];
        }
        
        if (playerName3 == @"") {
            player3 = [self TheChickenOfPlayers:YES :3];
        }else{
            player3 = [self TheChickenOfPlayers:NO :3];
        }
        
        //蛋(player)
        //player1=[CCSprite spriteWithFile:@"sleepChicken.png"];
        [self addChild:player1 z:1 tag:1];
        player1.position=CGPointMake(screenSize.width/3.5, screenSize.height/5*4-10);
        
        //player2=[CCSprite spriteWithFile:@"egg2.png"];
        [self addChild:player2 z:2 tag:2];
        player2.position=CGPointMake(screenSize.width/4*3, screenSize.height/2+12);
        
        //player3=[CCSprite spriteWithFile:@"egg3.png"];
        [self addChild:player3 z:3 tag:3];
        player3.position=CGPointMake(screenSize.width/3, screenSize.height/5);
        
                       
        CCLabelTTF * LabName1=[CCLabelTTF labelWithString:playerName1 fontName:@"Marker Felt" fontSize:30];
        LabName1.position=CGPointMake(player1.position.x, player1.position.y-player1.contentSize.height/5);
        [self addChild:LabName1 z:4];
        
        CCLabelTTF * LabName2=[CCLabelTTF labelWithString:playerName2 fontName:@"Marker Felt" fontSize:30];
        LabName2.position=CGPointMake(player2.position.x, player2.position.y-player2.contentSize.height/5);
        [self addChild:LabName2 z:5];
        
        CCLabelTTF * LabName3=[CCLabelTTF labelWithString:playerName3 fontName:@"Marker Felt" fontSize:30];
        LabName3.position=CGPointMake(player3.position.x, player3.position.y-player3.contentSize.height/5);
        [self addChild:LabName3 z:6];

        
        
    }    
    return self;
}

-(CCSprite *)TheChickenOfPlayers:(BOOL)isNew:(NSInteger)playNumber
{

    if (isNew) {
        switch (playNumber) {
            case 1:
                return [CCSprite spriteWithFile:@"egg1.png"];
            case 2:
                return [CCSprite spriteWithFile:@"egg2.png"];
            case 3:
                return [CCSprite spriteWithFile:@"egg3.png"];
        }    }
    else
        return [CCSprite spriteWithFile:@"sleepChicken.png"];
    return [CCSprite spriteWithFile:@"egg1.png"];
 
}

+(CGPoint)locationFromTouch:(UITouch *)touch
{
    CGPoint touchLocation=[touch locationInView:[touch view]];
    return [[CCDirector sharedDirector]convertToGL:touchLocation];
}

//處碰偵測
-(void)registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

//處碰開始
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
//    //紀錄手指位置
//    CGPoint location=[ChooseRole locationFromTouch:touch];
//    NSLog(@"loction is (%f ,%f)",location.x, location.y );
//    //BOOL isTouchHandled=CGRectContainsPoint([chicken boundingBox], touchLocation);
//    bool isTouchHandled=[self isTouchForMe:location];
//    
//    if(isTouchHandled)
//    {
//        //變色
//        CCNode *node=[self getChildByTag:playerTag];
//        NSAssert([node isKindOfClass:[CCSprite class]], @"node is not a CCSprite");
//        ((CCSprite *)node).color=ccRED;
//        
//        //[[CCDirector sharedDirector]replaceScene: [AtHomeScene scene]];
//
//        return isTouchHandled;
//    }
//        
    //處碰到的坐標 
    CGPoint location=[touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location]; 
     //NSLog(@"loction is (%f ,%f)",location.x, location.y );
    
    CGRect rectP1 =CGRectMake(player1.position.x-108, player1.position.y-108, 180, 150);
    CGRect rectP2 =CGRectMake(player2.position.x-108, player2.position.y-108, 180, 150);
    CGRect rectP3 =CGRectMake(player3.position.x-108, player3.position.y-108, 180, 150);
    
    //NSLog(@"player1 position x= %f ,player1 position y= %f",player1.position.x,player1.position.y );
   // NSLog(@"x=%f, y=%f", player1.position.x -player1.contentSize.width/3, player1.position.y - player1.contentSize.height/3);
    
    //物件矩形包含手術碰到的點（坐標）
    CCNode *myEgg;
    CCNode *mySleepChicken;
    save_ChickenData* saveChickenNameClass = [[save_ChickenData alloc] init];
    
    if (CGRectContainsPoint(rectP1, location)) {
        [saveChickenNameClass MarkTheChickenNumber:@"1"];
        if (playerName1 == @"") {                          
           [[SimpleAudioEngine sharedEngine] playEffect:@"selChicken_new.m4a"]; 
            
            myEgg = (CCNode *)[self getChildByTag:1];
            [myEgg runAction:[CCSequence actions:
                              [CCJumpTo actionWithDuration:0.5 position:myEgg.position height:10 jumps:2],
                              [CCCallFunc actionWithTarget:self selector:@selector(Ge)],
                              nil]];
        }else{
           [[SimpleAudioEngine sharedEngine] playEffect:@"selChicken.m4a"]; 
          
            mySleepChicken = (CCNode *)[self getChildByTag:1];
            [mySleepChicken runAction:[CCSequence actions:
                              [CCJumpTo actionWithDuration:0.5 position:mySleepChicken.position height:10 jumps:2],
                              [CCCallFunc actionWithTarget:self selector:@selector(GotoMyHome)],
                              nil]];

        }
        
//        [player1 setColor:ccBLUE];
//        [player2 setColor:ccWHITE];
//        [player3 setColor:ccWHITE];
      //  [[CCDirector sharedDirector]replaceScene:[CCTransitionFlipX transitionWithDuration:1 scene:[AtHomeScene scene]]];
    }
   
    if (CGRectContainsPoint(rectP2, location)) {
        [saveChickenNameClass MarkTheChickenNumber:@"2"];
        if (playerName2 == @"") {
           [[SimpleAudioEngine sharedEngine] playEffect:@"selChicken_new.m4a" ]; 
            myEgg = (CCNode *)[self getChildByTag:2];
            [myEgg runAction:[CCSequence actions:
                              [CCJumpTo actionWithDuration:0.5 position:myEgg.position height:10 jumps:2],
                              [CCCallFunc actionWithTarget:self selector:@selector(GotoInputName)],
                              nil]];
        }else{
           [[SimpleAudioEngine sharedEngine] playEffect:@"selChicken.m4a"]; 
            mySleepChicken = (CCNode *)[self getChildByTag:2];
            [mySleepChicken runAction:[CCSequence actions:
                                       [CCJumpTo actionWithDuration:0.5 position:mySleepChicken.position height:10 jumps:2],
                                       [CCCallFunc actionWithTarget:self selector:@selector(GotoMyHome)],
                                       nil]];
            
        }

    }
    
    if (CGRectContainsPoint(rectP3, location)) {
        [saveChickenNameClass MarkTheChickenNumber:@"3"];
        if (playerName3 == @"") {
          [[SimpleAudioEngine sharedEngine] playEffect:@"selChicken_new.m4a"]; 
         
          
            myEgg = (CCNode *)[self getChildByTag:3];
            [myEgg runAction:[CCSequence actions:
                              [CCJumpTo actionWithDuration:0.5 position:myEgg.position height:10 jumps:2],
                              [CCCallFunc actionWithTarget:self selector:@selector(GotoInputName)],
                              nil]];
        }else{
          [[SimpleAudioEngine sharedEngine] playEffect:@"selChicken.m4a"]; 
            mySleepChicken = (CCNode *)[self getChildByTag:3];
            [mySleepChicken runAction:[CCSequence actions:
                                       [CCJumpTo actionWithDuration:0.5 position:mySleepChicken.position height:10 jumps:2],
                                       [CCCallFunc actionWithTarget:self selector:@selector(GotoMyHome)],
                                       nil]];
        }

    }
  
   
     

  
    return YES;
}

-(void)GotoMyHome
{
    [[CCDirector sharedDirector] replaceScene:[AtHomeScene scene]];
}

-(void)GotoInputName
{
    [[CCDirector sharedDirector] replaceScene:[GetNewEgg scene]];
}

- (void) realloc
{
    [super dealloc];
}

@end