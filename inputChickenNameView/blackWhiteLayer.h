//
//  blackWhiteLayer.h
//  inputChickenNameView
//
//  Created by Lozen on 11/10/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <CoreFoundation/CoreFoundation.h>
#import <CoreMotion/CoreMotion.h>


@interface blackWhiteLayer : CCLayer {
    CCLabelTTF *myLable;
    CMMotionManager *motionManager;       
    CCSprite *copy_chicken;
    CCSprite *user_chicken;
    CGSize size;
}

@property (nonatomic, retain) CMMotionManager *motionManager;

+(id) Scene;
-(void) scheduleUpdates;
-(CGSize)getMyWinSize;
@end
