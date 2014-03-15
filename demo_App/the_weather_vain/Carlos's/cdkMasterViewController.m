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

    [query whereKey:@"User" equalTo:[PFUser currentUser]];
    
    NSLog(@"current user %@", [PFUser currentUser]);
    
    
                                    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    NSLog(@"count of closet by user query: %lu", (unsigned long)self.objects.count);
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        
        NSLog(@"query in cache: %u", query.cachePolicy);
        
        PFQuery *defaultquery = [PFQuery queryWithClassName:@"DefaultCloset"];
        [defaultquery findObjectsInBackgroundWithBlock:^(NSArray *defaultobjects, NSError *error) {
            

            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %d objects.", defaultobjects.count);
                // Do something with the found objects
                for (PFObject *object in defaultobjects) {
                    NSLog(@"copying default object to custom object id %@", object.objectId);
                  //  NSLog(@"my object in copy contains: %@", object);
                    
                    
                    //  Next section is all about copying the default closet into the users closet one item at a time.  chh 03152014
                    
                    NSNumber *myBlack = [object objectForKey:@"Black"];
                    
                  //  NSLog(@"my black value in copy contains: %@", myBlack);
                    
                    NSNumber *myBlue = [object objectForKey:@"Blue"];
                    NSNumber *myCloudy = [object objectForKey:@"Cloudy"];
                    NSNumber *myCold = [object objectForKey:@"Cold"];
                    NSString *myDescription = object[@"Description"];
                    PFFile *myImage = [object objectForKey:@"Image"];
                    
                //    NSLog(@"my image value in copy contains: %@", myImage);
                    
                    NSNumber *myGender = [object objectForKey:@"Gender"];
                    NSNumber *myGreen = [object objectForKey:@"Green"];
                    NSNumber *myHot = [object objectForKey:@"Hot"];
  
                    
                    NSString *myLabel = object[@"Label"];
                    NSNumber *myMild = [object objectForKey:@"Mild"];
                    NSNumber *myOrange = [object objectForKey:@"Orange"];
                    NSNumber *myPurple = [object objectForKey:@"Purple"];
                    NSNumber *myRainy = [object objectForKey:@"Rainy"];
                    
                    NSNumber *myRating = [object objectForKey:@"Rating"];
                    NSNumber *myRed = [object objectForKey:@"Red"];
                    NSNumber *myStatus = [object objectForKey:@"Status"];
                    NSNumber *mySunny = [object objectForKey:@"Sunny"];
                    
                    NSNumber *myTempMax = [object objectForKey:@"TempMax"];
                    NSNumber *myTempMin = [object objectForKey:@"TempMin"];
                    NSNumber *myTypeID = [object objectForKey:@"TypeID"];

                    
                    NSNumber *myWhite = [object objectForKey:@"White"];
                    NSNumber *myWindy = [object objectForKey:@"Windy"];
                    NSNumber *myYellow = [object objectForKey:@"Yellow"];
                    
                 
                 
                    // self.itemImage.file = [self.detailItem objectForKey:@"Image"];
                    
                    PFUser *user = [PFUser currentUser];
                    PFObject *newItem = [PFObject objectWithClassName:@"Closet"];
                    
                    newItem[@"User"] = user;
                    
                    //newItem[@"User"] = [PFUser currentUser];
                    
                   // PFRelation *myUser = [[PFUser currentUser] relationForKey:@"newItem"];
                    
                   // newItem[@"User"] = myUser;
                    
                    newItem[@"Black"] = myBlack;
                    newItem[@"Blue"] = myBlue;
                    newItem[@"Cloudy"] = myCloudy;
                    newItem[@"Cold"] = myCold;
                    newItem[@"Description"] = myDescription;
                    newItem[@"Image"] = myImage;
                    newItem[@"Gender"] = myGender;
                    newItem[@"Green"] = myGreen;
                    newItem[@"Hot"] = myHot;
                    newItem[@"Label"] = myLabel;
                    newItem[@"Mild"] = myMild;
                    newItem[@"Orange"] = myOrange;
                    newItem[@"Purple"] = myPurple;
                    newItem[@"Rainy"] = myRainy;
                    newItem[@"Rating"] = myRating;
                    newItem[@"Red"] = myRed;
                    newItem[@"Status"] = myStatus;
                    newItem[@"Sunny"] = mySunny;
                    newItem[@"TempMax"] = myTempMax;
                    newItem[@"TempMin"] = myTempMin;
                    newItem[@"TypeID"] = myTypeID;
                    newItem[@"White"] = myWhite;
                    newItem[@"Windy"] = myWindy;
                    newItem[@"Yellow"] = myYellow;
                    
                    
                    [newItem saveInBackground];
                    
                    
                    
                 //   newItem[@"Black"] = @[[object objectForKey:@"Black"] integerValue]];
                 //   newItem[@"Blue"] = @[[object objectForKey:@"Blue"] integerValue]];
                    
                   // newItem[@"Blue"] = myBlue;
                    
                    
                    
                    
                   // PFRelation *myUser = [[PFUser currentUser] relationForKey:@"newItem"];
                   // NSLog(@"my user value in copy contains: %@", myUser);
                    
                    
                    
               //     newItem[@"Black"] =
                    
                    //
                    
                    
                }
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        
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
