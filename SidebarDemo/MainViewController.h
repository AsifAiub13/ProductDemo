//
//  MainViewController.h
//  ProductDemo
//
//  Created by Asif on 3/25/18.
//  Copyright (c) 2018 asif.asif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
@interface MainViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITextField *txtProductName;
@property (weak, nonatomic) IBOutlet UITextView *txtViewDescription;
@property (weak, nonatomic) IBOutlet UITextField *txtPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property (weak, nonatomic) IBOutlet UIButton *btnINTax;
@property (weak, nonatomic) IBOutlet UIButton *btnMITax;

@property NSString *productName;
@property NSString *productDescription;
@property NSString* productPrice;

@property NSMutableArray* accounts;
@property (strong, nonatomic) NSMutableDictionary *contentDict;
@property NSMutableDictionary *productDict;
@property NSInteger indexValue;
@property bool newAccount;
@end
