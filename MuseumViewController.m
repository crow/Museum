//
//  MuseumViewController.m
//  Museum
//
//  Created by Jonathan Fox on 3/7/15.
//
//

#import "MuseumViewController.h"

@interface MuseumViewController ()
@property (nonatomic) NSString *chosenTourColor;
@end

@implementation MuseumViewController


- (IBAction)tourButtonPressed:(UIButton *)sender {
    self.chosenTourColor = sender.titleLabel.text;
    NSLog(@"%@", sender.titleLabel.text);
}

@end
