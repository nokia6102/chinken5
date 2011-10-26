//
//  AppDelegate.h
//  inputChickenNameView
//
//  Created by Lozen on 11/10/16.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate, UITextFieldDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    UITextField         *inputTextField;
    NSString            *myChickenName;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) IBOutlet UITextField *inputTextField;
@property (nonatomic, retain) IBOutlet NSString *myChickenName;

-(void)specifyStartLevel;
-(void)returnKeyBoard;

@end
