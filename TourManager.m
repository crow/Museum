//
//  TourManager.m
//  Museum
//
//  Created by David Crow on 3/8/15.
//
//

#import "TourManager.h"

@implementation TourManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.messageCache = [[NSMutableDictionary alloc] init];
    }

    return self;
}

+ (instancetype)shared {
    static dispatch_once_t onceToken = 0;

    __strong static id _sharedObject = nil;

    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}

@end
