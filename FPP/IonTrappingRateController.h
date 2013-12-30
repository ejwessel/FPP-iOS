//
//  IonTrappingRateController.h
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IonTrappingRateController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *zInput;
@property (strong, nonatomic) IBOutlet UITextField *kInput;
@property (strong, nonatomic) IBOutlet UITextField *eInput;
@property (strong, nonatomic) IBOutlet UITextField *muInput;
@property (strong, nonatomic) IBOutlet UILabel *outputVelocity;
@property (strong, nonatomic) IBOutlet UILabel *velocityLabel;
@property (strong, nonatomic) IBOutlet UILabel *muLabel;

@property const float VEL_CONST;

- (float) calculateFrequencyWithInput:(float)z with:(float)k with:(float)e with:(float)m;
- (void) textChanged:(NSNotification*) note;

@end
