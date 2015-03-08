//
//  HueLightChanger.m
//  Museum
//
//  Created by benjaminhallock@gmail.com on 3/7/15.
//
//

#import "HueLightChanger.h"

#warning Set the server depending on the ip of the tehtered computer
#define server @"http://192.168.0.119"

#define red 250
#define yellow 18000
#define blue 45000

@interface HueLightChanger ()

@property int currentHue;

@property NSString *currentColor;

@end

@implementation HueLightChanger

//String is "red" or "yellow" or "blue"
-(id)initWithredORyellowORblue:(NSString *)color
{
    self = [super init];
    if (self)
    {
        self.currentColor = color;

        if ([color isEqualToString:@"red"])
        {
            self.currentHue = red;
        }
        else if ([color isEqualToString:@"blue"])
        {
            self.currentHue = blue;
        }
        else if ([color isEqualToString:@"yellow"])
        {
            self.currentHue = yellow;
        }
    }
    return self;
}

-(void)didEnter:(NSString *)light
{
    [self setLightToWhite:light];
}

-(void)didExitTurnOnLight:(NSString *)light
{
    [self setlight:light toHue:_currentHue];
}

-(void)setLightToWhite:(NSString *)light
{
    [self setlight:light toHue:35000];
}

-(void)setlight:(NSString *)light toHue:(int)color
{
    NSURL *aUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/light.php?color=%i&light=%@&sat=255&bri=255", server, color, light]];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];

    [request setHTTPMethod:@"POST"];

    NSURLConnection *connection2 = [[NSURLConnection alloc] initWithRequest:request
                                                                   delegate:self];
    [connection2 start];
}

-(void)didEnterBeaconwithTour:(NSString *)color andLightNumber:(NSString *)light
{
    if ([color isEqualToString:@"red"])
    {
        [self setlight:light toHue:red];
    }
    else if ([color isEqualToString:@"blue"])
    {
        [self setlight:light toHue:blue];
    }
    else if ([color isEqualToString:@"yellow"])
    {
        [self setlight:light toHue:yellow];
    }
}

@end
