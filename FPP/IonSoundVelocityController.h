//
//  IonSoundVelocityController.h
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LNNumberpad.h"

@interface IonSoundVelocityController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputC;
@property (strong, nonatomic) IBOutlet UITextField *gammaInput;
@property (strong, nonatomic) IBOutlet UITextField *zInput;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UITextField *muInput;
@property (strong, nonatomic) IBOutlet UILabel *gammaLabel;
@property (strong, nonatomic) IBOutlet UILabel *muLabel;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *gammaInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *zInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *muInputExponent;

@property const float C_CONST;

- (float) calculateWithInput:(float)g with:(float)z with:(float)t with:(float)m;

- (void) textChanged:(NSNotification*) note;

@end
