//
//  AppDelegate.h
//  ProductDemo
//
//  Created by Asif on 3/25/18.
//  Copyright (c) 2018 asif.asif. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
-(void)saveStringToUserDefaults:(NSString*)myString :(NSString*)myKey;
-(void)saveDictionaryToUserDefaults:(NSMutableArray*)myArray :(NSString*)myKey;
+ (AppDelegate *)sharedAppDelegate;
@property bool checkNewAcc;
@property NSString *priceOfMine;
@end

