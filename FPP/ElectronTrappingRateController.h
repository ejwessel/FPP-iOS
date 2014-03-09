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

@interface ElectronTrappingRateController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *kInput;
@property (strong, nonatomic) IBOutlet UITextField *eInput;
@property (strong, nonatomic) IBOutlet UILabel *outputVelocity;
@property (strong, nonatomic) IBOutlet UILabel *velocityLabel;
@property (strong, nonatomic) IBOutlet UITextField *kInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *eInputExponent;

@property const float VEL_CONST;

- (float) calculateFrequencyWithInput:(float)k with:(float)e;
- (void) textChanged:(NSNotification*) note;

@end
