//
//  ElectronCollisionRateController.h
//  FPP
//
//  Created by Ethan Wessel on 12/29/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElectronCollisionRateController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *nInput;
@property (strong, nonatomic) IBOutlet UITextField *coulombInput;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UILabel *outputVelocity;
@property (strong, nonatomic) IBOutlet UILabel *coulombLabel;

@property const float VEL_CONST;

- (float) calculateFrequencyWithInput:(float)n with:(float)c with:(float)t;
- (void) textChanged:(NSNotification*) note;
@end
