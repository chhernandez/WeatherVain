//
//  cdkMasterViewController.m
//  FashionExample
//
//  Created by Carlos Hernandez on 2/16/14.
//  Copyright (c) 2014 Carlos Hernandez. All rights reserved.
//

#import "cdkMasterViewController.h"

#import <Parse/Parse.h>

#import "cdkDetailViewController.h"

@interface cdkMasterViewController () {
   // NSMutableArray *_objects;
}
@end

@implementation cdkMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}


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
        self.objectsPerPage = 5;
    }
    return self;
}


- (void)viewDidLoad
{
    
    
 //This is to test connection to parse.com
 /*   PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
   */
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
    
    self.myItemsTitle.title = self.TypeList;
    
    NSLog(@"my type list: %@", self.TypeList);
    if (self.TypeList == nil) {
        self.myItemsTitle.title = @"All Items";
    }
    
    /*
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton; */
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
    
    
    if (([self.TypeList  isEqual: @"Tops"])) {
          NSLog(@"my type list: %@", self.TypeList);
        [query whereKey:@"TypeID" equalTo:@1];
    } else if (([self.TypeList  isEqual: @"Bottoms"])) {
        NSLog(@"my type list: %@", self.TypeList);
        [query whereKey:@"TypeID" equalTo:@2];
    } else if (([self.TypeList  isEqual: @"Shoes"])) {
        NSLog(@"my type list: %@", self.TypeList);
        [query whereKey:@"TypeID" equalTo:@3];
    } else if (([self.TypeList  isEqual: @"Outerwear"])) {
        NSLog(@"my type list: %@", self.TypeList);
        [query whereKey:@"TypeID" equalTo:@4];
    } else if (([self.TypeList  isEqual: @"Accessories"])) {
        NSLog(@"my type list: %@", self.TypeList);
        [query whereKey:@"TypeID" equalTo:@5];
    } else if (([self.TypeList  isEqual: @"One Piece"])) {
        NSLog(@"my type list: %@", self.TypeList);
        [query whereKey:@"TypeID" equalTo:@6];
    } else {
        
       // show all items
    }
    // ********************
    // here's how you set the where to in queries
    // [query whereKey:@"TypeID" equalTo:@1];
    
    
    //  [query orderByDescending:@"createdAt"];
    [query orderByDescending:@"Rating"];
    
    return query;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
} */

#pragma mark - Table View

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
} */

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
} */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
     NSLog(@"my object in master contains: %@", object);
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"Label"];
    
    //PFFile *thumbnail = object[@"Image"];
    //cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    //cell.imageView.file = thumbnail;
    // cell.imageView.file = [object objectForKey:self.imageKey];
    
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
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
       // NSDate *object = _objects[indexPath.row];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
        
        NSLog(@"my object in prepareForSegue contains: %@", object);
    } else {
        
        NSLog(@"my object in prepareForSegue contains no objects");
    }
}

@end
