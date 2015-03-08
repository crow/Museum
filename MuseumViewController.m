//
//  MuseumViewController.m
//  Museum
//
//  Created by Jonathan Fox on 3/7/15.
//
//

#import "MuseumViewController.h"

@interface MuseumViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueContainerConstraint;
@property (weak, nonatomic) IBOutlet UILabel *blueGlow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redContainerConstraint;
@property (weak, nonatomic) IBOutlet UILabel *redGlow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yellowContainerConstraint;
@property (weak, nonatomic) IBOutlet UILabel *yellowGlow;
@property (nonatomic) NSString *chosenTourColor;
@end

@implementation MuseumViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.blueContainerConstraint.constant = 800;
    self.redContainerConstraint.constant = 800;
    self.yellowContainerConstraint.constant = 800;
    [self.view layoutIfNeeded];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self animateTourLabels];
}


- (IBAction)tourButtonPressed:(UIButton *)sender {
    self.chosenTourColor = sender.titleLabel.text;
    
    [UIView animateWithDuration:0.1 animations:^{
    self.blueGlow.alpha = 0.35;
    self.redGlow.alpha = 0.35;
    self.yellowGlow.alpha = 0.35;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            if ([sender.currentTitle isEqualToString: @"Blue Tour"]) {
                self.blueGlow.alpha = 0.8;
            }
            if ([sender.currentTitle isEqualToString: @"Red Tour"]) {
                self.redGlow.alpha = 0.9;
            }
            if ([sender.currentTitle isEqualToString: @"Yellow Tour"]) {
                self.yellowGlow.alpha = 0.5;
            }
        }];
    }];
}


-(void)animateTourLabels{
    [UIView animateWithDuration:1.0 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations: ^(void) {
        self.blueContainerConstraint.constant = 282;
        self.redContainerConstraint.constant = 348;
        self.yellowContainerConstraint.constant = 418;
        [self.view layoutIfNeeded];
    } completion:nil];
}

@end
