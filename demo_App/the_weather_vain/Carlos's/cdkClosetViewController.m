//
//  cdkClosetViewController.m
//  FashionExample
//
//  Created by Carlos Hernandez on 3/2/14.
//  Copyright (c) 2014 Carlos Hernandez. All rights reserved.
//

#import "cdkClosetViewController.h"
#import "cdkCellType.h"
#import "cdkMasterViewController.h"
#import <Parse/Parse.h>

@interface cdkClosetViewController ()

@end

@implementation cdkClosetViewController


-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;

}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.typeArray.count;
    
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    cdkCellType * aCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    aCell.myNewLabel.text = self.typeArray[indexPath.row];
    
    UIImage *typeImage = [[UIImage alloc] init];
    typeImage = [UIImage imageNamed:[self.typeImages objectAtIndex:indexPath.row]];
    aCell.myNewImage.image = typeImage;
    
 //   aCell.myNewLabel.text = [NSString stringWithFormat:@"Rating: "];

    //aCell.myTypeLabel.text = self.typeArray[indexPath.row];
    
    // to add image to the cell, add images with suffix numbering and use this code template:
    //aCell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"myImageIcon%d.jpg", imageNumber]];
    
    return aCell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.typeArray = @[@"Tops", @"Outerwear", @"Bottoms", @"Accessories", @"Shoes", @"One Piece"];
    self.typeImages = @[@"tops.jpg", @"outerwear.jpg", @"Bottoms.jpg", @"accessories.jpg", @"shoes.jpg", @"dress.jpg"];
    
    
    // Here we check to see if the user has closet items. chh 03162014

    PFQuery *query = [PFQuery queryWithClassName:@"Closet"];
    
    [query whereKey:@"User" equalTo:[PFUser currentUser]];
    
    NSLog(@"current user %@", [PFUser currentUser]);
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d objects.", objects.count);
            // Do something with the found objects
            
            if (objects.count == 0) {
                NSLog(@"Successfully retrieved %d objects.", objects.count);
                
                PFQuery *defaultquery = [PFQuery queryWithClassName:@"DefaultCloset"];
                [defaultquery findObjectsInBackgroundWithBlock:^(NSArray *defaultobjects, NSError *error) {
                    
                    
                    if (!error) {
                        // The find succeeded.
                     //   NSLog(@"Successfully retrieved %d objects.", defaultobjects.count);
                        // Do something with the found objects
                        for (PFObject *object in defaultobjects) {
                      //      NSLog(@"copying default object to custom object id %@", object.objectId);
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
                            
                            
                            PFUser *user = [PFUser currentUser];
                            PFObject *newItem = [PFObject objectWithClassName:@"Closet"];
                            
                            newItem[@"User"] = user;
                            
                            
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
                            
                            
                        }
                    } else {
                        // Log details of the failure
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                    }
                }];
            }

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
 /*
    
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
        
  
        
    }
    
    */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    cdkMasterViewController *myListViewController = (cdkMasterViewController *)segue.destinationViewController;
    myListViewController.TypeList = [self.typeArray objectAtIndex:indexPath.row];
    
}

@end
