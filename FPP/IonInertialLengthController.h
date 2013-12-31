//
//  IonInertialLengthController.h
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IonInertialLengthController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputAnswer;
@property (strong, nonatomic) IBOutlet UITextField *muInput;
@property (strong, nonatomic) IBOutlet UITextField *nInput;
@property (strong, nonatomic) IBOutlet UILabel *muLabel;

@property const float CONST_VALUE;

- (float) calculateWithInput:(float)m with:(float)n;

- (void) textChanged:(NSNotification*) note;
@end
