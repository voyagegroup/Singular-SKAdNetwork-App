//
//  AdController.m
//  SingularPublisherSampleApp
//
//  Created by Eyal Rabinovich on 24/06/2020.
//

#import "AdController.h"

@interface AdController ()

@property (strong, nonatomic) NSDictionary *productParameters;
@end

@implementation AdController

- (id)initWithProductParameters:(NSDictionary*)data {
    self = [super init];
    if (self) {
        productParameters = data;
    }
    return self;
}

- (void)viewDidLoad {
    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;

	NSLog(@"AdNetwork Attribution Signature: %@", [productParameters objectForKey:SKStoreProductParameterAdNetworkAttributionSignature]);
    NSLog(@"AdNetwork Attribution id: %@", [productParameters objectForKey:SKStoreProductParameterITunesItemIdentifier]);
    NSLog(@"AdNetwork Attribution network id: %@", [productParameters objectForKey:SKStoreProductParameterAdNetworkIdentifier]);
    NSLog(@"AdNetwork Attribution campaign id: %@", [productParameters objectForKey:SKStoreProductParameterAdNetworkCampaignIdentifier]);
    NSLog(@"AdNetwork Attribution timestamp: %@", [productParameters objectForKey:SKStoreProductParameterAdNetworkTimestamp]);
    NSLog(@"AdNetwork Attribution nonce: %@", [productParameters objectForKey:SKStoreProductParameterAdNetworkNonce]);
    NSLog(@"AdNetwork Attribution source app id: %@", [productParameters objectForKey:SKStoreProductParameterAdNetworkSourceAppStoreIdentifier]);
    NSLog(@"AdNetwork Attribution version: %@", [productParameters objectForKey:SKStoreProductParameterAdNetworkVersion]);
    NSLog(@"AdNetwork Attribution sourceIdentifier: %@", [productParameters objectForKey:SKStoreProductParameterAdNetworkSourceIdentifier]);
    
    // Please note that in order to use loadProductWithParameters,
    // Your ViewController must inherit from SKStoreProductViewController
    
    // Step 4: Showing the AppStore window with the product we got from the Ad Network.
    [storeViewController loadProductWithParameters:productParameters completionBlock:^(BOOL result, NSError *error) {
        if (error || !result){
            NSLog(@"Error Domain: %@", error.domain);
            NSLog(@"Error Code: %ld", (long)error.code);
            NSLog(@"Error Description: %@", error.localizedDescription ? error.localizedDescription : @"(no description)");
            NSLog(@"Underlying Error: %@", error.userInfo[NSUnderlyingErrorKey] ? error.userInfo[NSUnderlyingErrorKey] : @"(no underlying error)");
            NSLog(@"URL: %@", error.userInfo[@"AMSURL"] ? error.userInfo[@"AMSURL"] : @"(no URL)");
            // Loading the ad failed, try to load another ad or retry the current ad.
        } else {
            [self presentViewController:storeViewController animated:YES completion:nil];
            NSLog(@"Success: %@", @"Ad loaded successfully! :)");
            // Ad loaded successfully! :)
        }
    }];
}

@end
