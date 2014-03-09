//
//  ElectronBroglieLengthController.h
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LNNumberpad.h"

@interface ElectronBroglieLengthController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lambaLabel;
@property (strong, nonatomic) IBOutlet UILabel *outputLambda;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;

@property const float LAMBDA_CONST;

- (float) calculateWithInput: (float)t;

- (void) textChanged:(NSNotification*) note;

@end
