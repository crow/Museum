//
//  TourManager.h
//  Museum
//
//  Created by David Crow on 3/8/15.
//
//

#import <Foundation/Foundation.h>
#import "HueLightChanger.h"
#import "GimbalAdapter.h"

@interface TourManager : NSObject

//tour manager singleton
+ (instancetype)shared;

//message caching dirtiness
@property (nonatomic, strong) NSMutableDictionary *messageCache;

//light changer dirtiness
@property (nonatomic, strong) HueLightChanger *lightChanger;

//chosen tour
@property (nonatomic) NSString *chosenTourColor;

-(NSString *)lightNextFromVisit:(GMBLVisit *) visit andTour:(NSString *) tour;

@end
