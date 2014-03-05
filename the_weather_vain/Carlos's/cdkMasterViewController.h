//
//  cdkMasterViewController.h
//  FashionExample
//
//  Created by Carlos Hernandez on 2/16/14.
//  Copyright (c) 2014 Carlos Hernandez. All rights reserved.
//


#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface cdkMasterViewController : PFQueryTableViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *myItemsTitle;
@property (strong, nonatomic) NSString *TypeList;

@end
