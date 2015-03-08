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
    NSLog(@"%@", sender.titleLabel.text);
}


-(void)animateTourLabels{
    [UIView animateWithDuration:1.0 animations:^{
        self.blueContainerConstraint.constant = 282;
        self.redContainerConstraint.constant = 348;
        self.yellowContainerConstraint.constant = 418;
        [self.view layoutIfNeeded];
    }];
}
@end
