//
//  IonGyrofrequencyController.h
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface IonGyrofrequencyController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *inputValue1;
@property (strong, nonatomic) IBOutlet UITextField *inputValue2;
@property (strong, nonatomic) IBOutlet UITextField *inputValue3;
@property (strong, nonatomic) IBOutlet UILabel *outputFrequency;
@property (strong, nonatomic) IBOutlet UILabel *outputOmega;
@property (strong, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (strong, nonatomic) IBOutlet UILabel *omegaLabel;
@property (strong, nonatomic) IBOutlet UILabel *magneticFieldLabel;
@property (strong, nonatomic) IBOutlet UILabel *muLabel;
@property (strong, nonatomic) IBOutlet UILabel *zetaLabel;



- (float) calculateFrequencyWithInput:(float)B with:(float)m with:(float)z;
- (float) calculateOmegaWithInput:(float)B with:(float)m with:(float)z;

- (void) textChanged:(NSNotification*) note;

@end
