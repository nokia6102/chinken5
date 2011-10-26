//
//  blackWhiteLayer.m
//  inputChickenNameView
//
//  Created by Lozen on 11/10/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "blackWhiteLayer.h"
#import "myChickens.h"
#import <CoreMotion/CoreMotion.h>


@implementation blackWhiteLayer

@synthesize motionManager;

+(id) Scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CCLayer *layer = [blackWhiteLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        CCSprite *blackWhitebg = [CCSprite spriteWithFile:@"blackWhiteBg.png"];
        blackWhitebg.anchorPoint = CGPointMake(0, 0);
        [self addChild:blackWhitebg z:0];
        
        //CGSize size = [[CCDirector sharedDirector] winSize];
        
                
        copy_chicken = [CCSprite spriteWithFile:@"com_up.png"];
        [copy_chicken setPosition:CGPointMake([self getMyWinSize].width * 0.6, [self getMyWinSize].height * 0.65)];
        [self addChild:copy_chicken z:1 tag:1];
        
        user_chicken = [CCSprite spriteWithFile:@"user_up.png"];
        [user_chicken setPosition:CGPointMake([self getMyWinSize].width * 0.1, [self getMyWinSize].height * 0.3)];
        [self addChild:user_chicken z:2 tag:2];

        
        //[self addChild:myLable];
        self.motionManager = [[[CMMotionManager alloc] init] autorelease];
        motionManager.deviceMotionUpdateInterval = 1.0/1.0;
        if (motionManager.isDeviceMotionAvailable) {
            [motionManager startDeviceMotionUpdates];
        }
        
        [self scheduleUpdate]; 
    }
	return self;
}

-(void) scheduleUpdates
{
    [self schedule:@selector(updateTenTimesPerSecond:) interval:0.1f];
}

-(void)update:(ccTime)delta {
    [self removeChildByTag:1 cleanup:YES];
    [self removeChildByTag:2 cleanup:YES];
    CMDeviceMotion *currentDeviceMotion = motionManager.deviceMotion;
    CMAttitude *currentAttitude = currentDeviceMotion.attitude;
    
    
    // 1: Convert the radians yaw value to degrees then round up/down
    float yaw = roundf((float)(CC_RADIANS_TO_DEGREES(currentAttitude.yaw)));
    float pitch = roundf((float)(CC_RADIANS_TO_DEGREES(currentAttitude.pitch)));
    //float roll = roundf((float)(CC_RADIANS_TO_DEGREES(currentAttitude.roll)));
    
    
    if (pitch >= 30)
    {
        copy_chicken = [CCSprite spriteWithFile:@"com_up.png"];
        NSLog(@"1");
        user_chicken = [CCSprite spriteWithFile:@"user_up.png"];
    }
    else if (pitch <= -30)
    {
        
        copy_chicken = [CCSprite spriteWithFile:@"com_down.png"];
        NSLog(@"2");
        user_chicken = [CCSprite spriteWithFile:@"user_down.png"];
    }
    else
    {
        if (yaw >= 45)
        {
            copy_chicken = [CCSprite spriteWithFile:@"com_right.png"];
            NSLog(@"3");
            user_chicken = [CCSprite spriteWithFile:@"user_left.png"];
        }
        else if (yaw <= -45)
        {
            copy_chicken = [CCSprite spriteWithFile:@"com_left.png"];
            NSLog(@"4");
            user_chicken = [CCSprite spriteWithFile:@"user_right.png"];
        }
        else{
        copy_chicken = [CCSprite spriteWithFile:@"blackWhite_com_vs.png"];
        NSLog(@"5");
        user_chicken = [CCSprite spriteWithFile:@"blackWhite_user_ready.png"];
        }
    }

    
    // 2: Convert the degrees value to float and use Math function to round the value
    [copy_chicken setPosition:CGPointMake([self getMyWinSize].width * 0.6, [self getMyWinSize].height * 0.65)];
    [self addChild:copy_chicken z:1 tag:1];
    [user_chicken setPosition:CGPointMake([self getMyWinSize].width * 0.3, [self getMyWinSize].height * 0.3)];
    [self addChild:user_chicken z:2 tag:2];
} 

-(CGSize)getMyWinSize
{
    size = [[CCDirector sharedDirector] winSize];
    return size;
}

-(void) updateTenTimesPerSecond:(ccTime)delta
{
    CMDeviceMotion *currentDeviceMotion = motionManager.deviceMotion;
    CMAttitude *currentAttitude = currentDeviceMotion.attitude;
    
   // float roll = currentAttitude.roll;  
    float pitch = currentAttitude.pitch;  //上下 +z~-z
    float yaw = currentAttitude.yaw;  //左右  + ~ -
    //NSLog(@"roll: %@",roll);
    //NSLog(@"pitch: %@",pitch);
    NSLog(@"yaw: %@",currentAttitude.yaw);
    
    //NSLog(@"%@", myLable);
    //copy_chicken.rotation = CC_RADIANS_TO_DEGREES(yaw);
    
    //NSLog(@"yaw = %f",yaw);
    //NSLog(@"pitch = %f", pitch); 
    
    
    //myLable.rotation = CC_RADIANS_TO_DEGREES(yaw);
    [self removeChildByTag:2 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    
    if (pitch > 0.5)
    {
        copy_chicken = [CCSprite spriteWithFile:@"com_up.png"];
        NSLog(@"1");
        user_chicken = [CCSprite spriteWithFile:@"user_up.png"];
    }
    else if (pitch < -0.5)
    {
        copy_chicken = [CCSprite spriteWithFile:@"com_down.png"];
        NSLog(@"2");
        user_chicken = [CCSprite spriteWithFile:@"user_down.png"];
    }
    else
    {
        if (yaw >= 0.5)
        {
            copy_chicken = [CCSprite spriteWithFile:@"com_right.png"];
            NSLog(@"3");
            user_chicken = [CCSprite spriteWithFile:@"user_left.png"];
        }
        else if (yaw <= -0.5)
        {
            copy_chicken = [CCSprite spriteWithFile:@"com_left.png"];
            NSLog(@"4");
            user_chicken = [CCSprite spriteWithFile:@"user_right.png"];
        }
        else
        {
        copy_chicken = [CCSprite spriteWithFile:@"blackWhite_com_vs.png"];
            NSLog(@"5");
            user_chicken = [CCSprite spriteWithFile:@"blackWhite_user_ready.png"];
        }
    }
    
        
    
    CGSize csize = [[CCDirector sharedDirector] winSize];
    [copy_chicken setPosition:CGPointMake(csize.width * 0.6, csize.height * 0.65)];
    [self addChild:copy_chicken z:2 tag:2];
    [user_chicken setPosition:CGPointMake(csize.width * 0.3, csize.height * 0.3)];
    [self addChild:user_chicken z:3 tag:3];

}

//-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    CMDeviceMotion *currentDeviceMotion = motionManager.deviceMotion;
//    CMAttitude *currentAttitude = currentDeviceMotion.attitude;
//    
//}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    [motionManager release];
	[super dealloc];
}

@end
