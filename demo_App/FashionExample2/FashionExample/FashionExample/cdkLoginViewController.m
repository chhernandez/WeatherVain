//
//  cdkLoginViewController.m
//  FashionExample
//
//  Created by itsadmin on 2/21/14.
//  Copyright (c) 2014 Carlos Hernandez. All rights reserved.
//

#import "cdkLoginViewController.h"
#import <Parse/Parse.h>

@interface cdkLoginViewController ()

@end

@implementation cdkLoginViewController

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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundlogin.png"]];
}
 


    - (void)viewDidAppear:(BOOL)animated {
        [super viewDidAppear:animated];
        
        if (![PFUser currentUser]) { // No user logged in
            // Create the log in view controller
            PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
         //   logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsFacebook | PFLogInFieldsTwitter | PFSignUpFieldsSignUpButton | PFLogInFieldsPasswordForgotten;
            
            [logInViewController setDelegate:self]; // Set ourselves as the delegate
            
            // Create the sign up view controller
            PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
            [signUpViewController setDelegate:self]; // Set ourselves as the delegate
            
            // Assign our sign up controller to be displayed from the login controller
            [logInViewController setSignUpController:signUpViewController];
            
            // Present the log in view controller
            [self presentViewController:logInViewController animated:YES completion:NULL];
        }
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
