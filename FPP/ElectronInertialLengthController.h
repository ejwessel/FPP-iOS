//
//  ElectronInertialLengthController.h
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElectronInertialLengthController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputAnswer;
@property (strong, nonatomic) IBOutlet UITextField *nInput;

@property const float CONST_VALUE;

- (float) calculateWithInput: (float)n;

- (void) textChanged:(NSNotification*) note;
@end
