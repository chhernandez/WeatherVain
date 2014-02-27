//
//  cdkTableViewController.m
//  WeatherDemo
//
//  Created by Carlos Hernandez on 2/15/14.
//  Copyright (c) 2014 Carlos Hernandez. All rights reserved.
//

#import "cdkTableViewController.h"
#import "cdkDetailViewController.h"



@interface cdkTableViewController ()

@end

@implementation cdkTableViewController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // The className to query on
     //   self.parseClassName = @"Fashion";
    //   self.className = @"Fashion";
    
        
        // The key of the PFObject to display in the label of the default cell style
      //  self.textKey = @"id";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
      //  self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
        
    }
    return self;
} */

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
      //  // The className to query on
     //   self.parseClassName = @"Fashion";
        
        // The key of the PFObject to display in the label of the default cell style
    //    self.textKey = @"Label";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
  //   PFQueryTableViewController *controller = [[PFQueryTableViewController alloc] initWithClassName:@"fashion"];
    
 
    
    
  //  self = controller;
    
    //
    // self.window.rootViewController = controller;
    // [self.window makeKeyAndVisible];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"Closet"];
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
  //  [query orderByDescending:@"createdAt"];
      [query orderByDescending:@"Rating"];
    
    return query;
}

// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
// and the imageView being the imageKey in the object.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"Label"];
    
    PFFile *thumbnail = object[@"Image"];
    cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    cell.imageView.file = thumbnail;
 //   cell.imageView.file = [object objectForKey:self.imageKey];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Rating: %@", [object objectForKey:@"Rating"]];

    //cell.accessoryType = UITableViewCellAccessoryDetailButton;
   /* if (toDoItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }*/
    
    return cell;
}
  /*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
  //  [[segue destinationViewController] detailItems:[self objectAtIndex:[self.tableView indexPathForCell:sender]];
 
    if ([segue.identifier isEqualToString:@"myItem"]) {
        cdkDetailViewController *detailViewController = [segue destinationViewController];
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        detailViewController.detailItems = [self.objects objectAtIndex:row];
    }

    
    
}*/


/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
       NSLog(@"I'm in the prepareforsegue: %d", 0);
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        // Row selection
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
  
    
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        cdkDetailViewController *destViewController = segue.destinationViewController;
        destViewController.detailItem = [self.objects objectAtIndex:indexPath.row];
        
        // Hide bottom tab bar in the detail view
        //   destViewController.hidesBottomBarWhenPushed = YES;
    }
} */


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
