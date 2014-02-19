//
//  cdkDetailViewController.m
//  WeatherDemo
//
//  Created by Carlos Hernandez on 2/15/14.
//  Copyright (c) 2014 Carlos Hernandez. All rights reserved.
//

#import "cdkDetailViewController.h"

#import <Parse/Parse.h>

@interface cdkDetailViewController ()

@end

@implementation cdkDetailViewController

#pragma mark - UIViewController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
} */

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.detailItem){
   NSLog(@"my object contains: %@", self.detailItem);
    } else {
         NSLog(@"I have no objects: %d", 0);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
