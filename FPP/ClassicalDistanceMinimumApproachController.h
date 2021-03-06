//
//  ClassicalDistanceMinimumApproachController.h
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LNNumberpad.h"

@interface ClassicalDistanceMinimumApproachController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputAnswer;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;

@property const float CONST_VALUE;

- (float) calculateWithInput: (float)t;

- (void) textChanged:(NSNotification*) note;
@end
