//
//  save_ChickenData.m
//  inputChickenNameView
//
//  Created by Lozen on 11/10/18.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "save_ChickenData.h"

@implementation save_ChickenData

-(BOOL)SaveMyChickenName1:(NSString *)chickenName
{
    //key
    
    NSString * const myChicken_DidImportData = @"myChickenName1";
    
    //read
    inputChickenName = [[NSUserDefaults standardUserDefaults] stringForKey:myChicken_DidImportData];
    
    if (inputChickenName==nil) {
        //set data
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    } else{
        //remove
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myChicken_DidImportData];
        //set
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    }
    return YES;
}
-(BOOL)SaveMyChickenName2:(NSString *)chickenName
{
    //key
    
    NSString * const myChicken_DidImportData = @"myChickenName2";
    
    //read
    inputChickenName = [[NSUserDefaults standardUserDefaults] stringForKey:myChicken_DidImportData];
    
    if (inputChickenName==nil) {
        //set data
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    } else{
        //remove
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myChicken_DidImportData];
        //set
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    }
    return YES;
}
-(BOOL)SaveMyChickenName3:(NSString *)chickenName
{
    //key
    
    NSString * const myChicken_DidImportData = @"myChickenName3";
    
    //read
    inputChickenName = [[NSUserDefaults standardUserDefaults] stringForKey:myChicken_DidImportData];
    
    if (inputChickenName==nil) {
        //set data
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    } else{
        //remove
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myChicken_DidImportData];
        //set
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    }
    return YES;
}

-(NSString *)GetMyChickenName:(NSInteger)chickenNumber
{
    NSString * chickenName;
    
    switch (chickenNumber) {
        case 1:
            chickenName = [[NSUserDefaults standardUserDefaults] stringForKey:@"myChickenName1"];
            break;
        case 2:
            chickenName = [[NSUserDefaults standardUserDefaults] stringForKey:@"myChickenName2"];
            break;
        case 3:
            chickenName = [[NSUserDefaults standardUserDefaults] stringForKey:@"myChickenName3"];
            break;
    }
    
    if (chickenName == nil) { 

        return @"";
    }
    else
    {
        return chickenName;
    }
}

-(void)MarkTheChickenNumber:(NSString *)chickenNumber
{
    NSString * const myChicken_Number = @"markMyChickenNumber";
    NSString* markNumber;
    //read
    markNumber = [[NSUserDefaults standardUserDefaults] stringForKey:myChicken_Number];
    
    if (markNumber==nil) {
        //set data
        [[NSUserDefaults standardUserDefaults] setObject:chickenNumber forKey:myChicken_Number];
    } else{
        //remove
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myChicken_Number];
        //set
        [[NSUserDefaults standardUserDefaults] setObject:chickenNumber forKey:myChicken_Number];
    }

}

-(NSString *)GetMychickenNumber
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"markMyChickenNumber"];
}

@end
