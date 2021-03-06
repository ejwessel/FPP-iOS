//
//  IonGyroradiusController.h
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LNNumberpad.h"

@interface IonGyroradiusController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputRadius;
@property (strong, nonatomic) IBOutlet UITextField *muInput;
@property (strong, nonatomic) IBOutlet UITextField *zInput;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UITextField *bInput;
@property (strong, nonatomic) IBOutlet UILabel *muLabel;
@property (strong, nonatomic) IBOutlet UITextField *muInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *zInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *bInputExponent;

@property const float RADIUS_CONST;

- (float) calculateWithInput: (float)m with:(float)z with:(float)t with:(float)b;

- (void) textChanged:(NSNotification*) note;
@end
