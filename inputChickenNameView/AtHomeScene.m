//
//  AtHomeScene.m
//  ChickenFight
//
//  Created by App on 2011/10/13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AtHomeScene.h"
#import "startBlackWhiteGameLayer.h"
#import "ChooseRole.h"
//#import "CCTouchDispatcher.h"
#import "SimpleAudioEngine.h"
@implementation AtHomeScene


+(CCScene *) scene;
{
    CCScene *scene=[CCScene node];
    AtHomeScene *layer=[AtHomeScene node];
    [scene addChild:layer];
    return scene;
    
}

-(id)init
{
    if((self=[super init]))
    {
        CCLOG(@"%@:%@",NSStringFromSelector(_cmd),self);
      
      [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"home.m4a"];//play 
        //self.isAccelerometerEnabled = YES;
        //self.isTouchEnabled=YES;
        
//        //小雞
//        smallChicken = [CCSprite spriteWithFile:@"smallChicken.png"];
//        [self addChild:smallChicken z:1 tag:2];
//        CGSize screenSize=[CCDirector sharedDirector].winSize;
//        float imageHeight = [smallChicken texture].contentSize.height;
//        smallChicken.position=CGPointMake(screenSize.width/4*3, imageHeight/2);
//        
//        //大雞
//        chicken=[CCSprite spriteWithFile:@"chicken.png"];
//        [self addChild:chicken z:2 tag:3];
//        float imageChickenHeight = [chicken texture].contentSize.height;
//        chicken.position=CGPointMake(100, imageChickenHeight/2);
//        
//        //背景
//        bg=[CCSprite spriteWithFile:@"bg.png"];
//        [self addChild:bg z:0 tag:1 ];
//        bg.position=CGPointMake(screenSize.width/2, screenSize.height/2);
//        
//        
//        CCLabelTTF * gameStart=[CCLabelTTF labelWithString:@"Chicken Jump!!" fontName:@"Marker Felt" fontSize:50];
//        gameStart.position=CGPointMake(screenSize.width/2, screenSize.height/4*3);
//        [self addChild:gameStart];
//        
//        
//        //跳
//        CGPoint testPoint=CGPointMake(0, 0);
//        CCJumpBy *jump=[CCJumpBy actionWithDuration:1 position:testPoint height:screenSize.height/2 jumps:1];
//        CCJumpBy *jumpChicken=[CCJumpBy actionWithDuration:2 position:testPoint height:screenSize.height-imageChickenHeight jumps:1];
//        
//        CCRepeatForever *repeatJump=[CCRepeatForever actionWithAction:jump];
//        CCRepeatForever *repeatJumpChinken=[CCRepeatForever actionWithAction:jumpChicken];
//        [smallChicken runAction:repeatJump];
//        [chicken runAction:repeatJumpChinken];
//        
//        //動作 放大
//        CCScaleTo *scaleUp=[CCScaleTo actionWithDuration:CCRANDOM_0_1()*2+1 scale:1.5f];
//        //速度漸變動作 速度由慢至快 再由快至慢
//        //CCEaseBackInOut *easeUp=[CCEaseBackInOut actionWithAction:scaleUp];
//        //動作 縮小
//        CCScaleTo *scaleDown=[CCScaleTo actionWithDuration:CCRANDOM_0_1()*2+1 scale:0.5f];
//        //速度漸變動作 速度由慢至快 再由快至慢
//        // CCEaseBackInOut *easeDown=[CCEaseBackInOut actionWithAction:scaleDown];
//        
//        //動畫佇列
//        CCSequence *scaleSequence=[CCSequence actions:scaleUp,scaleDown, nil];
//        CCRepeatForever *repeatScale=[CCRepeatForever actionWithAction:scaleSequence];
//        [chicken runAction:repeatScale];
//        
//        // 设置在每一帧都运行的预约方法:
//        //    [self scheduleUpdate];

   
        CGSize screenSize=[CCDirector sharedDirector].winSize;
        
        //背景
        bg=[CCSprite spriteWithFile:@"homebg.png"];
        [self addChild:bg z:0 tag:0 ];
        bg.position=CGPointMake(screenSize.width/2, screenSize.height/2);
        
        //電視
        tv=[CCSprite spriteWithFile:@"TVwithTitle.png"];
        [self addChild:tv z:2 tag:2];
        tv.position=CGPointMake(screenSize.width*0.75+2,screenSize.height*0.55);
        
        //空電視底
        tv_null=[CCSprite spriteWithFile:@"TVempty.png"];
        [self addChild:tv_null z:1 tag:1];
        tv_null.position=CGPointMake(screenSize.width*0.75,screenSize.height*0.55);
        
        //閃爍
        blink=[CCBlink actionWithDuration:10 blinks:20];
        repeatBlink=[CCRepeatForever actionWithAction:blink];
        [tv runAction:repeatBlink];

       // CCSprite * returnImage = [CCSprite spriteWithFile:@"returnButton.png"];
        
        //主選單
        CCMenuItem *wiiItem=[CCMenuItemImage itemFromNormalImage:@"game.png" selectedImage:@"game.png" target:self selector:@selector(showGameMenu:)];
        CCMenuItem *foodItem=[CCMenuItemImage itemFromNormalImage:@"food.png" selectedImage:@"food.png" target:self selector:@selector(eatFood:)];
        CCMenuItem *settingItem=[CCMenuItemImage itemFromNormalImage:@"setting.png" selectedImage:@"setting.png" target:self selector:@selector(setOptional:)];
        CCMenuItem *returnItem = [CCMenuItemImage itemFromNormalImage:@"returnButton.png" selectedImage:nil target:self selector:@selector(returnMyChooseRole)];
        
        returnItem.scale = 0.7;
        returnItem.rotation = 81;
        returnItem.position = CGPointMake(screenSize.width * 0.13, screenSize.height * 0.92);

        
        tvChickenItem=[CCMenuItemImage itemFromNormalImage:@"watchTV.png" selectedImage:@"watchTV.png" target:self selector:@selector(chickenJump:)];
        
        wiiItem.position=CGPointMake(screenSize.width*0.9,screenSize.height*0.53);
        foodItem.position=CGPointMake(screenSize.width*0.2,screenSize.height*0.45);
        tvChickenItem.position=CGPointMake(screenSize.width*0.53, screenSize.height*0.17);
        settingItem.position=CGPointMake(screenSize.width*0.1, screenSize.height*0.1);
        settingItem.scale=0.8;
        mainMenu =[CCMenu menuWithItems:wiiItem,foodItem,tvChickenItem ,settingItem, returnItem, nil];
        mainMenu.position=CGPointZero;
        [self addChild:mainMenu z:3];
        
    }    
    return self;
}


+(CGPoint)locationFromTouch:(UITouch *)touch
{
    CGPoint touchLocation=[touch locationInView:[touch view]];
    return [[CCDirector sharedDirector]convertToGL:touchLocation];
}

-(void)returnMyChooseRole 
{
    NSLog(@"back");
    [[CCDirector sharedDirector] replaceScene:[ChooseRole scene]];
}

//處碰偵測
-(void)registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
}


//處碰開始
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    chicken.visible=NO;
    //紀錄手指位置
    CGPoint location=[touch locationInView:[touch view]];
        
    location = [[CCDirector sharedDirector] convertToGL:location]; 
    NSLog(@"loction is (%f ,%f)",location.x, location.y );
        
        
    return YES;
}


-(void)showGameMenu:(id)sender
{
[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"showGameMenu.m4a"];//play 

  tv.visible=NO;
    tv_null.visible=NO;
    chicken.visible=NO;
    mainMenu.visible=NO;
    tvChicken.visible=NO;
    [tv stopAction:repeatBlink];
    CGSize size = [[CCDirector sharedDirector] winSize];
    //CCSprite * game12=[CCSprite spriteWithFile:@"game_menu12.png"];
    //[game12 setTextureRect:CGRectMake(0, 0, 128, 285)];
    allGameMenu = [CCNode node];
    CCSprite *gameMenuBg = [CCSprite spriteWithFile:@"bg.png"];
    gameMenuBg.position = CGPointMake(size.width/2, size.height/2);
    [allGameMenu addChild:gameMenuBg z:0 tag:0];
    
    CCSprite * blackWhiteImage = [CCSprite spriteWithFile:@"game_menu12.png" rect:CGRectMake(0, 0,( size.width/320)*128, (size.height/480)*285)];
    CCSprite * sumoImage = [CCSprite spriteWithFile:@"game_menu12.png" rect:CGRectMake((size.width/320)*128, 0,( size.width/320)*128, (size.height/480)*285)];
    CCSprite * tutuImage = [CCSprite spriteWithFile:@"game_menu3.png" rect:CGRectMake(0, 0, (size.width/320)*285, (size.height/480)*128)];
    
        CCMenuItem *blackWhiteItem = [CCMenuItemImage itemFromNormalSprite:blackWhiteImage selectedSprite:nil target:self selector:@selector(linkToBlackWhiteGamePage:)];
    CCMenuItem *sumoItem = [CCMenuItemImage itemFromNormalSprite:sumoImage selectedSprite:nil target:self selector:@selector(linkToSumoGamePage:)];
    CCMenuItem *tutuItem = [CCMenuItemImage itemFromNormalSprite:tutuImage selectedSprite:nil target:self selector:@selector(linkToTutuGamePage:)];
     CCMenuItem *returnItem = [CCMenuItemImage itemFromNormalImage:@"returnButton.png" selectedImage:nil target:self selector:@selector(BackToHome:)];
    
        blackWhiteItem.position=ccp(size.width/4, size.height/3*2);
    sumoItem.position=ccp(size.width/4*3, size.height/3*2);
    tutuItem.position=ccp(size.width/2, size.height * 0.2);
    returnItem.scale = 0.7;
    returnItem.position = ccp(size.width * 0.13, size.height * 0.08);
    
    //menu
//    CGSize screenSize=[CCDirector sharedDirector].winSize;
//    CCMenuItem *menuItem1=[CCMenuItemImage itemFromNormalImage:@"blackWhite.png" selectedImage:@"blackWhite.png" target:self selector:@selector(linkToBlackWhiteGamePage:)];
//    CCMenuItem *menuItem2=[CCMenuItemImage itemFromNormalImage:@"sumo.png" selectedImage:@"sumo.png" target:self selector:@selector(linkToSumoGamePage:)];
//    CCMenuItem *menuItem3=[CCMenuItemImage itemFromNormalImage:@"tutu.png" selectedImage:@"tutu.png" target:self selector:@selector(linkToTutuGamePage:)];
    //CCMenuItem *menuItem4=[CCMenuItemImage itemFromNormalImage:@"Icon.png" selectedImage:@"Icon.png" target:self selector:@selector(BackToHome:)];
//    menuItem1.position=ccp(screenSize.width/4, screenSize.height/3*2);
//    menuItem2.position=ccp(screenSize.width/4*3, screenSize.height/3*2);
//    menuItem3.position=ccp(screenSize.width/2, screenSize.height/6);
   // menuItem4.position=ccp(0,0);
    //gameMenu=[CCMenu menuWithItems:menuItem1,menuItem2,menuItem3,menuItem4, nil];
    gameMenu = [CCMenu menuWithItems:blackWhiteItem, sumoItem, tutuItem, returnItem, nil];
    gameMenu.position=CGPointZero;
    [allGameMenu addChild:gameMenu z:2 tag:2];
    [self addChild:allGameMenu];

}

-(void)eatFood:(id)sender
{
    //
}


-(void)linkToBlackWhiteGamePage:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[startBlackWhiteGameLayer Scene]];
}

-(void)linkToSumoGamePage:(id)sender
{
    //
}

-(void)linkToTutuGamePage:(id)sender
{
    //
}

-(void)BackToHome:(id)sender
{
  [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    allGameMenu.visible = NO;
    //gameMenu.visible=NO;
    mainMenu.visible=YES;
    tv.visible=YES;
    tv_null.visible=YES;
    tvChickenItem.visible=YES;
    
    blink=[CCBlink actionWithDuration:10 blinks:20];
    repeatBlink=[CCRepeatForever actionWithAction:blink];
    [tv runAction:repeatBlink];
  [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"home.m4a"];
    NSLog(@"return button pressed!!");
    
}

-(void)setOptional:(id)sender
{
    //
}


-(void)chickenJump:(id)sender
{
    mainMenu.visible=YES;
    tvChickenItem.visible=NO ;
    tv_null.visible=YES;
    tv.visible=YES;
    
    CGSize screenSize=[CCDirector sharedDirector].winSize;
    //大雞
    chicken=[CCSprite spriteWithFile:@"blackWhite_user_vs.png"];
    [self addChild:chicken z:4 tag:4];
    float imageChickenHeight = [chicken texture].contentSize.height;
    chicken.position=CGPointMake(screenSize.width/2, imageChickenHeight/2);
    
    //跳
    CGPoint testPoint=CGPointMake(0, 0);
    CCJumpBy *jumpChicken=[CCJumpBy actionWithDuration:0.5 position:testPoint height:screenSize.height/10 jumps:1];
    
    CCRepeatForever *repeatJumpChinken=[CCRepeatForever actionWithAction:jumpChicken];
    [chicken runAction:repeatJumpChinken];

}
- (void) dealloc
{
  //  [repeatBlink release];
    [super dealloc];
}

@end