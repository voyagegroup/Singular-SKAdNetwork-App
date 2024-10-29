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
        _productParameters = data;
    }
    return self;
}

- (void)viewDidLoad {
    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;
    
    NSNumber *productID = self.productParameters[@"id"];
    if (!productID) {
        NSLog(@"Error: id is missing in productParameters.");
        return;
    }
    
    NSDictionary *parameters = @{
        SKStoreProductParameterITunesItemIdentifier: productID
    };
    
    // Please note that in order to use loadProductWithParameters,
    // Your ViewController must inherit from SKStoreProductViewController
    
    // Step 4: Showing the AppStore window with the product we got from the Ad Network.
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError *error) {
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
