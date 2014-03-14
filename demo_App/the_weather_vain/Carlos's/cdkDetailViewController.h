//
//  cdkDetailViewController.h
//  FashionExample
//
//  Created by Carlos Hernandez on 2/16/14.
//  Copyright (c) 2014 Carlos Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface cdkDetailViewController : UIViewController

@property (strong, nonatomic) PFObject *detailItem;

@property (weak, nonatomic) IBOutlet PFImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
