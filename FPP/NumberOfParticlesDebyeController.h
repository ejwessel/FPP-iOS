//
//  NumberOfParticlesDebyeController.h
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberOfParticlesDebyeController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputAnswer;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UITextField *nInput;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *nInputExponent;

@property const float VALUE_CONST;

- (float) calculateWithInput:(float)t with:(float)n;

- (void) textChanged:(NSNotification*) note;

@end
