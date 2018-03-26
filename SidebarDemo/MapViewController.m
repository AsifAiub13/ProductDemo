//
//  MapViewController.m
//  ProductDemo
//
//  Created by Asif on 3/25/18.
//  Copyright (c) 2018 asif.asif. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize priceOf;
- (void)viewDidLoad {
    [super viewDidLoad];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.lblSubTotal.text = appDelegate.priceOfMine;

}
- (IBAction)btnResetPresed:(UIButton *)sender {
    self.lblTax.text = @"";
    self.lblTotal.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnMIPressed:(UIButton *)sender {
    float currentValue = [self.lblSubTotal.text floatValue];
    currentValue = (currentValue * 0.07)+currentValue;
    NSLog(@"ne val %f",currentValue);
    self.lblTax.text = @"7%";
    self.lblTotal.text = [NSString stringWithFormat:@"%f",currentValue];
}
- (IBAction)btnINPressed:(UIButton *)sender {
    float currentValue = [self.lblSubTotal.text floatValue];
    currentValue = (currentValue * 0.06)+currentValue;
    NSLog(@"ne val %f",currentValue);
    self.lblTax.text = @"6%";
    self.lblTotal.text = [NSString stringWithFormat:@"%f",currentValue];
}
@end
