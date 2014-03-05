//
//  MainPageViewController.m
//  WeatherVain
//
//  Created by Tehreem Syed on 3/3/14.
//  Copyright (c) 2014 CodeKite. All rights reserved.
//

#import "MainPageViewController.h"
#import "WXWeatherViewController.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>

@interface MainPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) UIImageView *blurredImageView;
@end


@implementation MainPageViewController

@synthesize modelArray;
@synthesize pageViewController;

#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.modelArray indexOfObject:[(WXWeatherViewController *)viewController label]];
    
    if(currentIndex == 0)
    {
        [self.segmentControl setSelectedSegmentIndex:0];
        return nil;
    } else {
            [self.segmentControl setSelectedSegmentIndex:currentIndex];
    }
    WXWeatherViewController *weatherViewController = [[WXWeatherViewController alloc] init];
    weatherViewController.label = [self.modelArray objectAtIndex:currentIndex - 1];

    
    return weatherViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.modelArray indexOfObject:[(WXWeatherViewController *)viewController label]];
    if(currentIndex == self.modelArray.count-1)
    {
        return nil;
    }
    WXWeatherViewController *weatherViewController = [[WXWeatherViewController alloc] init];
    weatherViewController.label = [self.modelArray objectAtIndex:currentIndex+1];
    
    return weatherViewController;
}

#pragma mark - UIPageViewControllerDelegate Methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
        //Set the array with only 1 view controller
        UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        //Important- Set the doubleSided property to NO.
        self.pageViewController.doubleSided = NO;
        //Return the spine location
        return UIPageViewControllerSpineLocationMin;
    }
    else
    {
        NSArray *viewControllers = nil;
        WXWeatherViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        
        NSUInteger currentIndex = [self.modelArray indexOfObject:[(WXWeatherViewController *)currentViewController label]];
        if(currentIndex == 0 || currentIndex %2 == 0)
        {
            UIViewController *nextViewController = [self pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:currentViewController, nextViewController, nil];
        }
        else
        {
            UIViewController *previousViewController = [self pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:previousViewController, currentViewController, nil];
        }
        //Now, set the viewControllers property of UIPageViewController
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        return UIPageViewControllerSpineLocationMid;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *background = [UIImage imageNamed: @"austin-2"];
    
    //3
    self.blurredImageView = [[UIImageView alloc] init];
    self.blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blurredImageView.alpha = 1.0;
    [self.blurredImageView setImageToBlur:background blurRadius:10 completionBlock:nil];
    [self.view addSubview:self.blurredImageView];
    
    //Instantiate the model array
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int index = 1; index <= 2 ; index++)
    {
        [array addObject:[NSString stringWithFormat:@"Page %d",index]];
    }
    
    self.modelArray = [NSArray arrayWithArray:array];
    
    //Step 1
    //Instantiate the UIPageViewController.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //Step 2:
    //Assign the delegate and datasource as self.
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    //Step 3:
    //Set the initial view controllers.
    WXWeatherViewController *weatherViewController = [[WXWeatherViewController alloc] init];
    weatherViewController.label = @"Page 1";
    weatherViewController.isHourly = [NSNumber numberWithBool:YES];
    
    NSArray *viewControllers = [NSArray arrayWithObject:weatherViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    //Step 4:
    //ViewController containment steps
    //Add the pageViewController as the childViewController
    [self addChildViewController:self.pageViewController];
    
    //Add the view of the pageViewController to the current view
    [self.view addSubview:self.pageViewController.view];
    
    //Call didMoveToParentViewController: of the childViewController, the UIPageViewController instance in our case.
    [self.pageViewController didMoveToParentViewController:self];
    
    //Step 5:
    // set the pageViewController's frame as an inset rect.
//    CGRect pageViewRect = self.view.bounds;
//    pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
//    self.pageViewController.view.frame = pageViewRect;
    
    //Step 6:
    //Assign the gestureRecognizers property of our pageViewController to our view's gestureRecognizers property.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void) viewWillLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    self.blurredImageView.frame = bounds;
}



@end
