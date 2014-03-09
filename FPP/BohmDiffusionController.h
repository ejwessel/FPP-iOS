//
//  BohmDiffusionController.h
//  FPP
//
//  Created by Ethan Wessel on 1/1/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LNNumberpad.h"

@interface BohmDiffusionController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputD;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UITextField *bInput;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *bInputExponent;

@property const float VALUE_CONST;

- (float) calculateWithInput:(float)t with:(float)b;

- (void) textChanged:(NSNotification*) note;
@end
