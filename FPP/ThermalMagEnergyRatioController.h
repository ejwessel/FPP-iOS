//
//  ThermalMagEnergyRatioController.h
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThermalMagEnergyRatioController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputAnswer;
@property (strong, nonatomic) IBOutlet UITextField *nInput;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UITextField *bInput;
@property (strong, nonatomic) IBOutlet UITextField *nInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *bInputExponent;
@property (strong, nonatomic) IBOutlet UILabel *outputLabel;

@property const float VALUE_CONST;

- (float) calculateWithInput:(float)n with:(float)t with:(float)b;

- (void) textChanged:(NSNotification*) note;
@end
