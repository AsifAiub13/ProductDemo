//
//  MainViewController.m
//  ProductDemo
//
//  Created by Asif on 3/25/18.
//  Copyright (c) 2018 asif.asif. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize newAccount;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Product";

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.contentDict=[[NSMutableDictionary alloc]init];
    self.txtPrice.delegate = self;
    self.txtProductName.delegate = self;
    self.txtViewDescription.delegate = self;
    self.txtPrice.text = self.productPrice;
    self.txtProductName.text = self.productName;
    self.txtViewDescription.text = self.productDescription;
    self.txtPrice.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtProductName.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtViewDescription.keyboardAppearance = UIKeyboardAppearanceDark;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    //NSLog(@"gcgcgcgcgcgcc %@",self.newAccount);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"bool gcgcgcgc %s", appDelegate.checkNewAcc ? "true" : "false");
//    if(appDelegate.checkNewAcc == false){
//        self.txtProductName.text = [self.contentDict valueForKey:@"ProductName"];
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.checkNewAcc == false){
        NSMutableArray* accounts= [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"saved_products"]];
        self.contentDict = [[accounts objectAtIndex:self.indexValue] mutableCopy];
        self.txtProductName.text = [self.contentDict valueForKey:@"ProductName"];
        self.txtViewDescription.text = [self.contentDict valueForKey:@"ProductDescription"];
        self.txtPrice.text = [self.contentDict valueForKey:@"ProductPrice"];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dismissKeyboard{
    [self.view endEditing:true];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height+140;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [self.txtPrice resignFirstResponder];
    [self.txtProductName resignFirstResponder];
    [self.txtViewDescription resignFirstResponder];
    return YES;
}

- (IBAction)btnDonePressed:(UIButton *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([self.txtProductName.text isEqualToString:@""] || [self.txtPrice.text isEqualToString:@""]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Empty Field"
                                                                       message:@"Please insert value in Product Name and Price Fields!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [self.view endEditing:true];
    NSLog(@"xcxc name:%@ description:%@ price:%@",self.productName,self.productDescription,self.productPrice);
    NSMutableArray* accounts= [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"saved_products"]];
    if(appDelegate.checkNewAcc == true){
        NSInteger j;
        for (j=101;[accounts count]>0;j++){
            int found=1;
            for(int i=0;i<[accounts count];i++){
                NSLog(@"loop@%d",[[[accounts objectAtIndex:i] valueForKey:@"ID"] intValue]);
                if ([[[accounts objectAtIndex:i] valueForKey:@"ID"] intValue]==j) {
                    found=0;
                    break;
                }
            }
            
            if(found==1){
                break;
            }
        }
        NSNumber *accId=[NSNumber numberWithInt: (int)j];
        
        [self.contentDict setObject:accId forKey:@"ID"];
        [self.contentDict setObject:self.productName forKey:@"ProductName"];
        [self.contentDict setObject:self.productPrice forKey:@"ProductPrice"];
        [self.contentDict setObject:self.productDescription forKey:@"ProductDescription"];
        [accounts addObject:self.contentDict];
        [appDelegate saveDictionaryToUserDefaults:accounts :@"saved_products"];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success"
                                                                       message:@"Product added successfully!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [accounts replaceObjectAtIndex:self.indexValue withObject:self.contentDict];
        int acc_id=[[[accounts objectAtIndex:self.indexValue] valueForKey:@"ID"] intValue];
        NSLog(@"id isxxxxxx%d",acc_id);
        NSNumber *accId=[NSNumber numberWithInt: (int)acc_id];
        [self.contentDict setObject:accId forKey:@"ID"];
        [self.contentDict setObject:self.productName forKey:@"ProductName"];
        [self.contentDict setObject:self.productPrice forKey:@"ProductPrice"];
        [self.contentDict setObject:self.productDescription forKey:@"ProductDescription"];
        [accounts addObject:self.contentDict];
        [appDelegate saveDictionaryToUserDefaults:accounts :@"saved_products"];
    }
}
-(void) textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.txtProductName) {
        self.productName = self.txtProductName.text;
    }else if (textField == self.txtPrice){
        self.productPrice = self.txtPrice.text;
    }
}

-(void) textViewDidEndEditing:(UITextView *)textView{
    if (textView == self.txtViewDescription){
        self.productDescription = self.txtViewDescription.text;
    }
}
- (IBAction)btnMITaxPressed:(id)sender {
    if ([self.txtPrice.text isEqualToString:@""] || self.txtPrice.text == nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Empty Field"
                                                                       message:@"Please insert a Price first!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }else{
        float currentValue = [self.txtPrice.text floatValue];
        currentValue = (currentValue * 0.07)+currentValue;
        NSLog(@"ne val %f",currentValue);
        self.txtPrice.text = [NSString stringWithFormat:@"%f",currentValue];
        self.productPrice = self.txtPrice.text;
    }
}
- (IBAction)btnINTaxPressed:(id)sender {
    if ([self.txtPrice.text isEqualToString:@""] || self.txtPrice.text == nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Empty Field"
                                                                       message:@"Please insert a Price first!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }else{
        float currentValue = [self.txtPrice.text floatValue];
        currentValue = (currentValue * 0.06)+currentValue;
        NSLog(@"ne val %f",currentValue);
        self.txtPrice.text = [NSString stringWithFormat:@"%f",currentValue];
        self.productPrice = self.txtPrice.text;
    }
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
@end
