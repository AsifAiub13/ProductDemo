//
//  MapViewController.h
//  ProductDemo
//
//  Created by Asif on 3/25/18.
//  Copyright (c) 2018 asif.asif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblTax;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UIButton *btnMI;
@property (weak, nonatomic) IBOutlet UIButton *btnIN;
@property (strong, nonatomic) NSMutableDictionary *contentDict;
@property NSInteger indexValue;
@property NSString* priceOf;
@end
