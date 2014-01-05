//
//  TransverseSpitzerController.h
//  FPP
//
//  Created by Ethan Wessel on 1/1/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransverseSpitzerController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputN;
@property (strong, nonatomic) IBOutlet UITextField *zInput;
@property (strong, nonatomic) IBOutlet UITextField *lamdaInput;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UITextField *omegaInput;
@property (strong, nonatomic) IBOutlet UILabel *lambaLabel;
@property (strong, nonatomic) IBOutlet UILabel *omegaLabel;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *zInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *lambdaInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *omegaInputExponent;

@property const float VALUE_CONST;

- (float) calculateWithInput:(float)z with:(float)l with:(float)t with:(float)o;

- (void) textChanged:(NSNotification*) note;
@end
