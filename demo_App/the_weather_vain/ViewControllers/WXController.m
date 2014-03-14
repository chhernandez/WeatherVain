//
//  WXControllerViewController.m
//  WeatherVain
//
//  Created by Tehreem Syed on 2/8/14.
//  Copyright (c) 2014 CodeKite. All rights reserved.
//

#import "WXController.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import "WXManager.h"
#import "MainPageViewController.h"

@interface WXController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurredImageView;
@property (nonatomic, strong) IBOutlet UIButton *fullScreenButton;
@property (nonatomic, assign) CGFloat screenHeight;

@end

@implementation WXController

- (id)init {
    if (self = [super init]) {
           }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        _hourlyFormatter = [[NSDateFormatter alloc] init];
//        _hourlyFormatter.dateFormat = @"h a";
//        
//        _dailyFormatter = [[NSDateFormatter alloc] init];
//        _dailyFormatter.dateFormat = @"EEEE";
//
    }
    return self;
}

-(void) pushToDetail:(id) sender{
    MainPageViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainPageView"];
    

    [self presentViewController:viewController animated:YES completion:nil];

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self.navigationController navigationBar].hidden = YES;
     
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
	//  loading the view.
    
    //1
    self.screenHeight = [UIScreen mainScreen].bounds.size.height - self.tabBarController.view.frame.size.height;
    
    UIImage *background = [UIImage imageNamed: @"outfit-1_Fotor"];
    
    //2
    self.backgroundImageView = [[UIImageView alloc] initWithImage:background];
    CGRect frame = self.backgroundImageView.frame;
    frame.size.height = frame.size.height - 50;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    
    //3
//    self.blurredImageView = [[UIImageView alloc] init];
//    self.blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.blurredImageView.alpha = 0;
//    [self.blurredImageView setImageToBlur:background blurRadius:10 completionBlock:nil];
//    [self.view addSubview:self.blurredImageView];
    
    //additional setting up the layout frames and margins
    //1
    CGRect headerFrame = [UIScreen mainScreen].bounds;
    
    headerFrame.size.height = headerFrame.size.height - 50;
//    headerFrame.size.height = self.view.frame.size.height - self.tabBarController.view.frame.size.height;
    //2
    //an inset (or padding) variable so that all labels are evenly spaced and centered.
    CGFloat inset = 5;
    //3
    CGFloat temperatureHeight = 70;
    CGFloat hiloHeight = 40;
    CGFloat iconHeight = 30;
    
    //4
    CGRect hiloFrame = CGRectMake(inset, headerFrame.size.height - hiloHeight , headerFrame.size.width -(2*inset), hiloHeight);
    
    CGRect temperatureFrame = CGRectMake(inset, headerFrame.size.height - (temperatureHeight + hiloHeight), headerFrame.size.width - (2 *inset), temperatureHeight);
    
    CGRect iconFrame = CGRectMake(inset, temperatureFrame.origin.y - iconHeight, iconHeight, iconHeight);
    
    //5
    CGRect conditionsFrame = iconFrame;
    conditionsFrame.size.width = self.view.bounds.size.width - (((2 * inset) + iconHeight)+10);
    conditionsFrame.origin.x =  iconFrame.origin.x + (iconHeight + 10);
    
    //setting up various controls in our view
    
    //1
    UIView *header = [[ UIView alloc] initWithFrame:headerFrame];
    header.backgroundColor = [UIColor blackColor];
    header.alpha = 0.3;
//    self.tableView.tableHeaderView = header;
    
    //2
    //bottom left
    UILabel *temperatureLabel = [[UILabel alloc] initWithFrame:temperatureFrame];
    temperatureLabel.backgroundColor = [UIColor clearColor];
    temperatureLabel.textColor = [UIColor whiteColor];
    temperatureLabel.text = @"0°";
    temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60];//120
    [header addSubview:temperatureLabel];
    
    
    // bottom left
    UILabel *hiloLabel = [[UILabel alloc] initWithFrame:hiloFrame];
    hiloLabel.backgroundColor = [UIColor clearColor];
    hiloLabel.textColor = [UIColor whiteColor];
    hiloLabel.text = @"0° / 0°";
    hiloLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];//28
    [header addSubview:hiloLabel];
    
    //Bottom
    
//    UIButton *detailButton = [UIButton alloc] initWithFrame:<#(CGRect)#>
    
    
    
    // top
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 30)];
    cityLabel.backgroundColor = [UIColor clearColor];
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.text = @"Loading...";
    cityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    cityLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:cityLabel];
    
    UILabel *conditionsLabel = [[UILabel alloc] initWithFrame: conditionsFrame];
    conditionsLabel.backgroundColor = [UIColor clearColor];
    conditionsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    conditionsLabel.textColor = [UIColor whiteColor];
    conditionsLabel.text = @"Clear";
    [header addSubview:conditionsLabel];
    
    // 3
    // bottom left
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:iconFrame];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.backgroundColor = [UIColor clearColor];
    [iconView setImage:[UIImage imageNamed:@"weather-clear"]];
    [header addSubview:iconView];
    
    // 1
    /*Observes the currentCondition key on the WXManager singleton.
     */
    [[RACObserve([WXManager sharedManager], currentCondition)
      // 2
      /*Delivers any changes on the main thread since you’re updating the UI.*/
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(WXCondition *newCondition) {
         // 3
         /*Updates the text labels with weather data; you’re using newCondition for the text and not the singleton. The subscriber parameter is guaranteed to be the new value.*/
         temperatureLabel.text = [NSString stringWithFormat:@"%.0f°",newCondition.temperature.floatValue];
         conditionsLabel.text = [newCondition.condition capitalizedString];
         cityLabel.text = [newCondition.locationName capitalizedString];
         
         // 4
         /*Uses the mapped image file name to create an image and sets it as the icon for the view.*/
         iconView.image = [UIImage imageNamed:[newCondition imageName]];
     }];
    // 1
    /*The RAC(…) macro helps keep syntax clean. The returned value from the signal is assigned to the text key of the hiloLabel object.
*/
    RAC(hiloLabel, text) = [[RACSignal combineLatest:@[
                                                       // 2
                                                       /*Observe the high and low temperatures of the currentCondition key. Combine the signals and use the latest values for both. The signal fires when either key changes.*/
                                                       RACObserve([WXManager sharedManager], currentCondition.tempHigh),
                                                       RACObserve([WXManager sharedManager], currentCondition.tempLow)]
                             // 3
                             /*Reduce the values from your combined signals into a single value; note that the parameter order matches the order of your signals.*/
                              reduce:^(NSNumber *hi, NSNumber *low) {
                                                  return [NSString  stringWithFormat:@"%.0f° / %.0f°",hi.floatValue,low.floatValue];
                                              }]
                            // 4->delivering back to the main thread
                            deliverOn:RACScheduler.mainThreadScheduler];
    
    [[WXManager sharedManager] findCurrentLocation];
//    [ProgressHUD show:@"Getting Weather data"];
    [[RACObserve([WXManager sharedManager], hourlyForecast)
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(NSArray *newForecast) {
//         [ProgressHUD showSuccess:@"Done"];
//         [self.tableView reloadData];
     }];
    
    [[RACObserve([WXManager sharedManager], dailyForecast)
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(NSArray *newForecast) {
//         [self.tableView reloadData];
     }];
    
    [self.view addSubview:header];
    [self.view addSubview:self.fullScreenButton];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    bounds.size.height = bounds.size.height - 50;
    self.backgroundImageView.frame = bounds;
//    self.blurredImageView.frame = bounds;
//    self.fullScreenButton.frame = bounds;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 1
    CGFloat height = scrollView.bounds.size.height;
    CGFloat position = MAX(scrollView.contentOffset.y, 0.0);
    // 2
    CGFloat percent = MIN(position / height, 1.0);
    // 3
    self.blurredImageView.alpha = percent;
}
@end
