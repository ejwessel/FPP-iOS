//
//  ElectronGyrofrequencyController.h
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNNumberpad.h"
#import "Constants.h"

@interface ElectronGyrofrequencyController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *bInput;
@property (strong, nonatomic) IBOutlet UILabel *outputFrequency;
@property (strong, nonatomic) IBOutlet UILabel *outputOmega;
@property (strong, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (strong, nonatomic) IBOutlet UILabel *omegaLabel;
@property (strong, nonatomic) IBOutlet UITextField *bInputExponent;

@property const float FREQ_CONST;
@property const float OMEGA_CONST;

- (float) calculateFrequencyWithInput: (float)B;
- (float) calculateOmegaWithInput: (float)B;

- (void) textChanged:(NSNotification*) note;

@end
