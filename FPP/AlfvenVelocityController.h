//
//  AlfvenVelocityController.h
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LNNumberpad.h"

@interface AlfvenVelocityController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputVelocity;
@property (strong, nonatomic) IBOutlet UITextField *muInput;
@property (strong, nonatomic) IBOutlet UITextField *nInput;
@property (strong, nonatomic) IBOutlet UITextField *bInput;
@property (strong, nonatomic) IBOutlet UILabel *muLabel;
@property (strong, nonatomic) IBOutlet UITextField *muInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *nInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *bInputExponent;

@property const float VELOCITY_CONST;

- (float) calculateWithInput:(float)m with:(float)n with:(float)b;

- (void) textChanged:(NSNotification*) note;
@end
