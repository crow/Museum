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

@interface HueLightChanger ()

@end

@implementation HueLightChanger


//String is "red" or "yellow" or "blue"
-(id)initWithredORyellowORblue:(NSString *)color
{
    self = [super init];
    if (self)
    {
        self.colorString = color;
        _numberOfItem = 0;
    }
    return self;
}

-(void)didEnter
{
    _numberOfItem++;
    [self resetToWhite];
}

-(void)didExit
{
    [self didEnterBeaconwithTour:_colorString andLightNumber:_numberOfItem];
}

-(void)resetToWhite
{
    [self setlight:0 toHue:35000];
    [self setlight:1 toHue:35000];
}

-(void)setlight:(int)light toHue:(int)color
{
    if (light == 0) light = 2;
    if (light == 1) light = 3;

    NSURL *aUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/light.php?color=%i&light=%i&sat=255&bri=255", server, color, light]];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];

    [request setHTTPMethod:@"POST"];

    NSURLConnection *connection2 = [[NSURLConnection alloc] initWithRequest:request
                                                                   delegate:self];

    [connection2 start];
}

-(void)didEnterBeaconwithTour:(NSString *)color andLightNumber:(int)light
{
    if ([color isEqualToString:@"red"])
    {
        if (light == 1)
        {
            [self setlight:0 toHue:250];
            [self setlight:1 toHue:35000];
        }
        else
        {
            [self setlight:1 toHue:250];
            [self setlight:0 toHue:35000];
        }
    }
    else if ([color isEqualToString:@"blue"])
    {
        if (light == 1)
        {
            [self setlight:0 toHue:45000];
            [self setlight:1 toHue:35000];
        }
        else
        {
            [self setlight:1 toHue:45000];
            [self setlight:0 toHue:35000];
            ;}
    }
    else if ([color isEqualToString:@"yellow"])
    {
        if (light == 1)
        {
            [self setlight:0 toHue:18000];
            [self setlight:1 toHue:35000];
        }
        else
        {
            [self setlight:1 toHue:18000];
            [self setlight:0 toHue:35000];
        }
    }
}

-(IBAction)red:(UIButton *)sender
{
    _numberOfItem = 0;
    _colorString = @"red";
    [self didEnterBeaconwithTour:_colorString andLightNumber:_numberOfItem];
}

-(IBAction)blue:(UIButton *)sender
{
    _numberOfItem = 0;
    _colorString = @"blue";
    [self didEnterBeaconwithTour:_colorString andLightNumber:_numberOfItem];
}

-(IBAction)yellow:(UIButton *)sender
{
    _numberOfItem = 0;
    _colorString = @"yellow";
    [self didEnterBeaconwithTour:_colorString andLightNumber:_numberOfItem];
}

@end
