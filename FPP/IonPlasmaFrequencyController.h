//
//  IonPlasmaFrequencyController.h
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IonPlasmaFrequencyController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *zInput;
@property (strong, nonatomic) IBOutlet UITextField *muInput;
@property (strong, nonatomic) IBOutlet UITextField *nInput;
@property (strong, nonatomic) IBOutlet UILabel *outputFrequency;
@property (strong, nonatomic) IBOutlet UILabel *outputOmega;
@property (strong, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (strong, nonatomic) IBOutlet UILabel *omegaLabel;
@property (strong, nonatomic) IBOutlet UILabel *muLabel;

@property const float FREQ_CONST;
@property const float OMEGA_CONST;

- (float) calculateFrequencyWithInput:(float)z with:(float)m with:(float)n;
- (float) calculateOmegaWithInput:(float)z with:(float)m with:(float)n;

- (void) textChanged:(NSNotification*) note;

@end
