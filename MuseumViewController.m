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

@interface MuseumViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueContainerConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redContainerConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yellowContainerConstraint;
@property (nonatomic) NSString *chosenTourColor;
@end

@implementation MuseumViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.blueContainerConstraint.constant = 600;
    self.redContainerConstraint.constant = 600;
    self.yellowContainerConstraint.constant = 600;
    [self.view layoutIfNeeded];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self animateTourLabels];
}

- (IBAction)tourButtonPressed:(UIButton *)sender {
    self.chosenTourColor = sender.titleLabel.text;

    if ([sender.titleLabel.text isEqualToString:@"Red Tour"]) {
        self.chosenTourColor = @"red";
        [[UAPush shared] addTag:[NSString stringWithFormat:@"%@-tour", self.chosenTourColor]];

        // Update registration
        [[UAPush shared] updateRegistration];
    }

    if ([sender.titleLabel.text isEqualToString:@"Blue Tour"]) {
        self.chosenTourColor = @"blue";
        [[UAPush shared] addTag:[NSString stringWithFormat:@"%@-tour", self.chosenTourColor]];

        // Update registration
        [[UAPush shared] updateRegistration];

    }

    if ([sender.titleLabel.text isEqualToString:@"Yellow Tour"]) {
        self.chosenTourColor = @"yellow";
        [[UAPush shared] addTag:[NSString stringWithFormat:@"%@-tour", self.chosenTourColor]];

        // Update registration
        [[UAPush shared] updateRegistration];

    }

    if (![GimbalAdapter shared].lightChanger) {
        NSLog(@"%@ started", sender.titleLabel.text);
        [GimbalAdapter shared].lightChanger = [[HueLightChanger alloc] initWithredORyellowORblue:self.chosenTourColor];
    }
}

-(void)animateTourLabels {
    [UIView animateWithDuration:1.0 animations:^{
        self.blueContainerConstraint.constant = 282;
        self.redContainerConstraint.constant = 348;
        self.yellowContainerConstraint.constant = 418;
        [self.view layoutIfNeeded];
    }];
}

@end
