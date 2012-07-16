//
//  AgendaViewController.m
//  Guide
//
//  Created by Scott Andrus on 6/12/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import "AgendaViewController.h"
#import "LocationDetailViewController.h"
#import "NavBarManager.h"
#import "RootViewController.h"

@interface AgendaViewController ()

@end

@implementation AgendaViewController

@synthesize agenda = _agenda;
@synthesize allLocations = _allLocations;
@synthesize categories = _categories;
@synthesize imageView = _imageView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
//    NSLog(@"%@", self.agenda);
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (self.tableView.editing) {
        //UIImage *selectedButton30 = [[UIImage imageNamed:@"NewBarButtonSelected"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, -1, 5)];
        //[self.navigationItem.rightBarButtonItem setBackgroundImage:selectedButton30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        //[self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
    else {
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
    }
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VandyMobileBackgroundCanvas"]];
    
    [self.tableView setBackgroundView:backgroundImage];
    [self reload];
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = nil;
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VandyGuideText"]];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar = [NavBarManager setLogo:logo onNavBar:navBar];
}

- (void)reload {
    [self.tableView reloadData];
    
    if ([self.agenda count] == 0) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EmptyAgendaAnno"]];
        [self.imageView setUserInteractionEnabled:NO];
        [self.imageView setClipsToBounds:YES];
        //imageView.frame = self.view.frame;
        [self.view addSubview:self.imageView];
        [[self.imageView superview] setUserInteractionEnabled:NO];
        self.navigationItem.rightBarButtonItem = nil;
    }
    else if ([[self.view subviews] containsObject:self.imageView]) {
        [[self.imageView superview] setUserInteractionEnabled:YES];
        [self.imageView removeFromSuperview];
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    // Return the number of sections.
//    NSMutableOrderedSet *mutableCategories = [[NSMutableOrderedSet alloc] init];
//    for (Location * loc in self.agenda) {
//        [mutableCategories addObject:loc.category];
//    }
//    self.categories = [mutableCategories copy];
//    NSLog(@"Categories: %d",self.categories.count);
//    return self.categories.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    // Return the number of rows in the section.
//    NSInteger counter = 0;
//    for (Location * loc in self.agenda) {
//        if ([loc.category isEqualToString:[self.categories objectAtIndex:section]]) {
//            counter++;
//        }
//    }
//    NSLog(@"Number of rows in section %d: %d", section, counter);
//
//    return counter;
    return self.agenda.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AgendaCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if ([[self.agenda objectAtIndex:indexPath.row] isKindOfClass:[Location class]]) {
        Location * loc = [self.agenda objectAtIndex:indexPath.row];
        cell.textLabel.text = loc.name;
        cell.detailTextLabel.text = loc.category;
    }
    else {
        NSLog(@"Error with agenda data.");
        return nil;
    }
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        Location *location = [self.agenda objectAtIndex:indexPath.row];
        [self.agenda removeObject:location];
        
        
        // Either delete some rows within a section (leaving at least one) or the entire section.
//        if ([self.categories count] > 0)
        {
            // Section is not yet empty, so delete only the current row.
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];

//        }
//        else
//        {
            // Section is now completely empty, so delete the entire section.
//            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]
//                     withRowAnimation:UITableViewRowAnimationFade];
        }
//        
        [self reload];
    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Location *loc = [self.agenda objectAtIndex:fromIndexPath.row];
    [self.agenda removeObject:loc];
    [self.agenda insertObject:loc atIndex:toIndexPath.row];
    [self reload];
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
}

#pragma mark - Storyboard segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"scanLoc"]) {
        LocationDetailViewController *destination = segue.destinationViewController;
        Location *location = sender;
        destination.title = location.name;
        
        destination.location = location;
    }
    else {
        LocationDetailViewController *destination = [segue destinationViewController];
        destination.title = [[self.agenda objectAtIndex:[self.tableView indexPathForCell:sender].row] name];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        // Deselect the row
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        Location *loc = [self.agenda objectAtIndex:indexPath.row];
        
        destination.location = loc;
    }
}

@end
