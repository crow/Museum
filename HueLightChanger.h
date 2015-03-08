//
//  HueLightChanger.h
//  Museum
//
//  Created by benjaminhallock@gmail.com on 3/7/15.
//
//

#import <Foundation/Foundation.h>

@interface HueLightChanger : NSObject

-(id)initWithredORyellowORblue:(NSString *)color;

-(void)didEnter:(NSString *)light;

-(void)didExitTurnOnLight:(NSString *)light;

@end
