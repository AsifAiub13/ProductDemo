//
//  PhotoViewController.m
//  ProductDemo
//
//  Created by Asif on 3/25/18.
//  Copyright (c) 2018 asif.asif. All rights reserved.
//

#import "PhotoViewController.h"
#import "SWRevealViewController.h"

@interface PhotoViewController ()

@end
MainViewController *mainObj;
@implementation PhotoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoImageView.image = [UIImage imageNamed:self.photoFilename];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.tblView.delegate = self;
    self.tblView.dataSource = self;
    self.title = @"List of Products";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSMutableArray* accounts=[[NSUserDefaults standardUserDefaults] valueForKey:@"saved_products"];
    return accounts.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainViewController *mainObj = [[MainViewController alloc] init];
    mainObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    NSMutableDictionary *accInfo;//=[self.offlineAccounts objectAtIndex:indexPath.row];
    NSMutableArray* accounts=[[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"saved_products"]];
    accInfo = [accounts objectAtIndex:indexPath.row];
    NSInteger index=indexPath.row;//[accounts indexOfObject:accInfo];
    mainObj.contentDict=[accInfo mutableCopy];
    mainObj.indexValue = index;

    NSString *price = [accInfo valueForKey:@"ProductPrice"];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.priceOfMine = price;
    [self.tblView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    [self.navigationController pushViewController:mainObj animated:YES];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"cells";//[menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSMutableArray* accounts=[[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"saved_products"]];
    NSMutableDictionary *accInfo =[accounts objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[accInfo valueForKey:@"ProductName"]];
    NSString *detailLabel = [NSString stringWithFormat:@"%@ , %@",
                             [accInfo valueForKey:@"ProductDescription"],[accInfo valueForKey:@"ProductPrice"]];
    cell.imageView.image = [UIImage imageNamed:@"comments"];
    if(![detailLabel isEqualToString:@"(null) , (null)"]){
        cell.detailTextLabel.text = detailLabel;
    }
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)editPressed:(UIBarButtonItem *)sender {
    [self.tblView setEditing:YES animated:YES];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
}

// method to enable the deleting of rows
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableArray* arr1=[[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"saved_products"]];
        int acc_id=[[[arr1 objectAtIndex:indexPath.row] valueForKey:@"ID"] intValue];
        
        [arr1 removeObjectAtIndex:indexPath.row];
        [appDelegate saveDictionaryToUserDefaults:arr1 :@"saved_products"];
        
        [self.tblView beginUpdates];
        [self.tblView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tblView endUpdates];
        [self.tblView setEditing:NO animated:YES];
        //[tableView reloadData];
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tblView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
@end
