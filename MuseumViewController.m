//
//  MuseumViewController.m
//  Museum
//
//  Created by Jonathan Fox on 3/7/15.
//
//

#import "MuseumViewController.h"
#import "HueLightChanger.h"
#import "GimbalAdapter.h"
#import "HueLightChanger.h"
#import "UAirship.h"
#import "UAPush.h"
#import "TourManager.h"

@interface MuseumViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueContainerConstraint;
@property (weak, nonatomic) IBOutlet UILabel *blueGlow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redContainerConstraint;
@property (weak, nonatomic) IBOutlet UILabel *redGlow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yellowContainerConstraint;
@property (weak, nonatomic) IBOutlet UILabel *yellowGlow;
@end

@implementation MuseumViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.blueContainerConstraint.constant = 700;
    self.redContainerConstraint.constant = 700;
    self.yellowContainerConstraint.constant = 700;
    [self.view layoutIfNeeded];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [TourManager shared];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self animateTourLabels];
}

- (IBAction)tourButtonPressed:(UIButton *)sender {
    [UIView animateWithDuration:0.1 animations:^{
    self.blueGlow.alpha = 0.35;
    self.redGlow.alpha = 0.35;
    self.yellowGlow.alpha = 0.35;

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            if ([sender.currentTitle isEqualToString: @"Blue Tour"]) {
                self.blueGlow.alpha = 0.8;
                [TourManager shared].chosenTourColor = @"blue";
                [self initializeTagAndRegister];
            }
            if ([sender.currentTitle isEqualToString: @"Red Tour"]) {
                self.redGlow.alpha = 0.9;
                [TourManager shared].chosenTourColor = @"red";
                [self initializeTagAndRegister];
            }
            if ([sender.currentTitle isEqualToString: @"Yellow Tour"]) {
                self.yellowGlow.alpha = 0.5;
                [TourManager shared].chosenTourColor = @"yellow";
                [self initializeTagAndRegister];
            }
        }];
    }];

    //if tourmanager and light changer are uninitialized then it means a tour has already started
    if (![TourManager shared].lightChanger) {
        NSLog(@"%@ started", sender.titleLabel.text);
        [TourManager shared].lightChanger = [[HueLightChanger alloc] initWithredORyellowORblue:[TourManager shared].chosenTourColor];
    }

    //turn on first light
    [[TourManager shared].lightChanger didExitTurnOnLight:@"2"];
}

-(void)animateTourLabels{
    [UIView animateWithDuration:1.0 animations: ^(void) {
        self.blueContainerConstraint.constant = 282;
        self.redContainerConstraint.constant = 348;
        self.yellowContainerConstraint.constant = 418;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - HELPER

-(void)initializeTagAndRegister{
    [TourManager shared].lightChanger = [[HueLightChanger alloc] initWithredORyellowORblue:[TourManager shared].chosenTourColor];

    [[UAPush shared] addTag:[NSString stringWithFormat:@"%@-tour", [TourManager shared].chosenTourColor]];
    
    // Update registration
    [[UAPush shared] updateRegistration];
}


@end
