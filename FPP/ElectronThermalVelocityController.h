//
//  ElectronThermalVelocityController.h
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElectronThermalVelocityController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputVelocity;
@property (strong, nonatomic) IBOutlet UITextField *tInput;

@property const float VELOCITY_CONST;

- (float) calculateWithInput: (float)t;

- (void) textChanged:(NSNotification*) note;
@end
