//
//  TourManager.h
//  Museum
//
//  Created by David Crow on 3/8/15.
//
//

#import <Foundation/Foundation.h>
#import "HueLightChanger.h"

@interface TourManager : NSObject

//tour manager singleton
+ (instancetype)shared;

@property (nonatomic, strong) NSString

//message caching dirtiness
@property (nonatomic, strong) NSMutableDictionary *messageCache;

//light changer dirtiness
@property (nonatomic, strong) HueLightChanger *lightChanger;

@end
