//
//  IonThermalVelocityController.h
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LNNumberpad.h"

@interface IonThermalVelocityController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputVelocity;
@property (strong, nonatomic) IBOutlet UITextField *muInput;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UILabel *muLabel;
@property (strong, nonatomic) IBOutlet UITextField *muInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;

@property const float VELOCITY_CONST;

- (float) calculateWithInput: (float)m with:(float)t;

- (void) textChanged:(NSNotification*) note;
@end
