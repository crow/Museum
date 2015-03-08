//
//  HueLightChanger.h
//  Museum
//
//  Created by benjaminhallock@gmail.com on 3/7/15.
//
//

#import <Foundation/Foundation.h>

@interface HueLightChanger : NSObject

@property int numberOfItem;

@property NSString *colorString;

-(id)initWithredORyellowORblue:(NSString *)color;

-(void)didEnter;

-(void)didExit;

@end
