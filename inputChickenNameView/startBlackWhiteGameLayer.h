//
//  startBlackWhiteGameLayer.h
//  inputChickenNameView
//
//  Created by Lozen on 11/10/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@interface startBlackWhiteGameLayer : CCLayer {
    
}

+(id)Scene;
-(void)WhoisWinner:(NSInteger)userJagenNumber;

@end
