//
//  cdkDefaultSettingsViewController.h
//  FashionExample
//
//  Created by itsadmin on 2/26/14.
//  Copyright (c) 2014 Carlos Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface cdkDefaultSettingsViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

//@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

- (IBAction)logOutButtonTapAction:(id)sender;

//- (IBAction)logOutButtonTapAction:(id)sender;


@end
