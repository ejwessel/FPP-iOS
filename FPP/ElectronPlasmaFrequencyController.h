//
//  ElectronTrappingRateController.h
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LNNumberpad.h"

@interface ElectronPlasmaFrequencyController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *inputValue;
@property (strong, nonatomic) IBOutlet UITextField *inputValueExponent;
@property (strong, nonatomic) IBOutlet UILabel *outputFrequency;
@property (strong, nonatomic) IBOutlet UILabel *outputOmega;
@property (strong, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (strong, nonatomic) IBOutlet UILabel *omegaLabel;
@property (strong, nonatomic) IBOutlet UILabel *nLabel;

@property const float FREQ_CONST;
@property const float OMEGA_CONST;

- (float) calculateFrequencyWithInput: (float)B;
- (float) calculateOmegaWithInput: (float)B;

- (void) textChanged:(NSNotification*) note;
@end
