//
//  IonGyrofrequencyController.h
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LNNumberpad.h"

@interface IonGyrofrequencyController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *zInput;
@property (strong, nonatomic) IBOutlet UITextField *muInput;
@property (strong, nonatomic) IBOutlet UITextField *bInput;
@property (strong, nonatomic) IBOutlet UILabel *outputFrequency;
@property (strong, nonatomic) IBOutlet UILabel *outputOmega;
@property (strong, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (strong, nonatomic) IBOutlet UILabel *omegaLabel;
@property (strong, nonatomic) IBOutlet UILabel *magneticFieldLabel;
@property (strong, nonatomic) IBOutlet UILabel *muLabel;
@property (strong, nonatomic) IBOutlet UILabel *zetaLabel;
@property (strong, nonatomic) IBOutlet UITextField *zInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *muInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *bInputExponent;

@property const float FREQ_CONST;
@property const float OMEGA_CONST;

- (float) calculateFrequencyWithInput:(float)B with:(float)m with:(float)z;
- (float) calculateOmegaWithInput:(float)B with:(float)m with:(float)z;

- (void) textChanged:(NSNotification*) note;

@end
