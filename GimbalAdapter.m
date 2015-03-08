#import "GimbalAdapter.h"

#import "UAPush.h"
#import "UAirship.h"
#import "UAAnalytics.h"
#import "TourManager.h"
#import "UAPushLocalization.h"
#import "UAPushNotificationHandler.h"
#import "UAActionRunner.h"

#define kGimbalAdapterEnabled @"ua-gimbal-adapter-enabled"
#define kSource @"Gimbal"

@interface GimbalAdapter ()

@property (assign) BOOL started;
@property (nonatomic) GMBLPlaceManager *placeManager;

@property (nonatomic, strong) GMBLVisit *lastEnterVisit;
@property (nonatomic, strong) GMBLVisit *lastExitVisit;

@end

@implementation GimbalAdapter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.placeManager = [[GMBLPlaceManager alloc] init];
        self.placeManager.delegate = self;

        // hide the power alert by default
        if (![[NSUserDefaults standardUserDefaults] valueForKey:@"gmbl_hide_bt_power_alert_view"]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"gmbl_hide_bt_power_alert_view"];
        }

    }
    return self;
}

- (void)dealloc {
    self.placeManager.delegate = nil;
}

+ (instancetype)shared {
    static dispatch_once_t onceToken = 0;

    __strong static id _sharedObject = nil;

    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });

    return _sharedObject;
}

-(BOOL)isBluetoothPoweredOffAlertEnabled {
    return ![[NSUserDefaults standardUserDefaults] boolForKey:@"gmbl_hide_bt_power_alert_view"];
}

- (void)setBluetoothPoweredOffAlertEnabled:(BOOL)bluetoothPoweredOffAlertEnabled {
    [[NSUserDefaults standardUserDefaults] setBool:!bluetoothPoweredOffAlertEnabled
                                            forKey:@"gmbl_hide_bt_power_alert_view"];
}

- (void)startAdapter{

    if (self.started) {
        return;
    }

    [GMBLPlaceManager startMonitoring];

    self.started = YES;

    UA_LDEBUG(@"Started Gimbal Adapter.");
}

- (void)stopAdapter {

    if (self.started) {

        [GMBLPlaceManager stopMonitoring];
        self.started = NO;

        UA_LDEBUG(@"Stopped Gimbal Adapter.");
    }
}

#pragma mark -
#pragma mark Gimbal places callbacks


-(void)placeManager:(GMBLPlaceManager *)manager didBeginVisit:(GMBLVisit *)visit {
    UA_LDEBUG(@"Entered a Gimbal Place: %@ on the following date: %@", visit.place.name, visit.arrivalDate);

//    if ([self.lastEnterVisit.place.name isEqualToString:visit.place.name]) {
//        UA_LDEBUG(@"Squelched duplicate entry");
//        return;
//    }

    [self fireFastEvent:visit];

//    [[UAPush shared] addTag:[NSString stringWithFormat:@"nearby-place-%@", visit.place.name]];
//    [[UAPush shared] addTag:[NSString stringWithFormat:@"visited-place-%@", visit.place.name]];
//    // Update registration
//    [[UAPush shared] updateRegistration];

    //current light

    self.lastEnterVisit = visit;
}

-(void)placeManager:(GMBLPlaceManager *)manager didEndVisit:(GMBLVisit *)visit {
    UA_LDEBUG(@"Exited a Gimbal Place: %@ on the following date: %@", visit.place.name, visit.arrivalDate);

//    if ([self.lastExitVisit.place.name isEqualToString:visit.place.name]) {
//        UA_LDEBUG(@"Squelched duplicate exit");
//        return;
//    }

//    // Remove the nearby-place-<NAME> tag
//    [[UAPush shared] removeTag:[NSString stringWithFormat:@"nearby-place-%@", visit.place.name]];
//    // Update registration
//    [[UAPush shared] updateRegistration];

    [[TourManager shared] lightNextFromVisit:visit andTour:[TourManager shared].chosenTourColor];

    //give light to turn on

    self.lastExitVisit = visit;
}

-(void)fireFastEvent:(GMBLVisit *) visit {

//if next is 2 you can fire 1 etc

    if ([visit.place.name isEqualToString:@"Beacon_1"] && [self.lastExitVisit.place.name isEqualToString:@"Beacon_0"]) {
        [self exhibit1Fast];
    }

    if ([visit.place.name isEqualToString:@"Beacon_2"] && [self.lastExitVisit.place.name isEqualToString:@"Beacon_1"]) {
        [self exhibit2Fast];
    }

    if ([visit.place.name isEqualToString:@"Beacon_3"] && [self.lastExitVisit.place.name isEqualToString:@"Beacon_2"]) {
        [self exhibit3Fast];
    }
}

-(void)exhibit1Fast {
    UAActionArguments *args = [UAActionArguments argumentsWithValue:@"https://dl-origin.urbanairship.com/binary/public/soXddQOBQXeuS3K_2RBvoA/3d33ad00-9c88-42ac-be1e-533f515f8fab" withSituation:UASituationManualInvocation];

    // Optional completion handle
    UAActionCompletionHandler completionHandler = ^(UAActionResult *result) {
        UA_LDEBUG("Action finished!");
    };

    // Run an action by name
    [UAActionRunner runActionWithName:@"landing_page_action" withArguments:args withCompletionHandler:completionHandler];
}

-(void)exhibit2Fast {
    UAActionArguments *args = [UAActionArguments argumentsWithValue:@"https://dl-origin.urbanairship.com/binary/public/soXddQOBQXeuS3K_2RBvoA/44bbc370-3f99-4273-b902-8cca86872089" withSituation:UASituationManualInvocation];

    // Optional completion handler
    UAActionCompletionHandler completionHandler = ^(UAActionResult *result) {
        UA_LDEBUG("Action finished!");
    };

    // Run an action by name
    [UAActionRunner runActionWithName:@"landing_page_action" withArguments:args withCompletionHandler:completionHandler];
}

-(void)exhibit3Fast {
    UAActionArguments *args = [UAActionArguments argumentsWithValue:@"https://dl-origin.urbanairship.com/binary/public/soXddQOBQXeuS3K_2RBvoA/ac2524ec-0077-427a-b014-01fab71cc334" withSituation:UASituationManualInvocation];

    // Optional completion handler
    UAActionCompletionHandler completionHandler = ^(UAActionResult *result) {
        UA_LDEBUG("Action finished!");
    };

    // Run an action by name
    [UAActionRunner runActionWithName:@"landing_page_action" withArguments:args withCompletionHandler:completionHandler];
}


@end
