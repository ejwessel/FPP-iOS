//
//  DebyeLengthController.h
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LNNumberpad.h"

@interface DebyeLengthController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputLamda;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UITextField *nInput;
@property (strong, nonatomic) IBOutlet UILabel *lamdaLabel;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *nInputExponent;

@property const float LAMDA_CONST;

- (float) calculateWithInput:(float)t with:(float)n;

- (void) textChanged:(NSNotification*) note;
@end
