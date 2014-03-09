//
//  TransverseSpitzerController.h
//  FPP
//
//  Created by Ethan Wessel on 1/1/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LNNumberpad.h"

@interface SpitzerResistivityController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputNPerpendicular;
@property (strong, nonatomic) IBOutlet UILabel *outputNParallel;
@property (strong, nonatomic) IBOutlet UITextField *zInput;
@property (strong, nonatomic) IBOutlet UITextField *lamdaInput;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UILabel *lambaLabel;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *zInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *lamdaInputExponent;

@property const float VALUE_CONST;

- (float) calculateWithInput:(float)z with:(float)l with:(float)t;

- (void) textChanged:(NSNotification*) note;
@end
