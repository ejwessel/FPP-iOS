//
//  ElectronPlasmaGyroRatioController.h
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElectronPlasmaGyroRatioController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputAnswer;
@property (strong, nonatomic) IBOutlet UITextField *nInput;
@property (strong, nonatomic) IBOutlet UITextField *bInput;

@property const float VALUE_CONST;

- (float) calculateWithInput:(float)n with:(float)b;

- (void) textChanged:(NSNotification*) note;
@end
