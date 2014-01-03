//
//  TESTViewController.h
//  FPP
//
//  Created by Ethan Wessel on 1/3/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TESTViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *outputAnswer;
@property (strong, nonatomic) IBOutlet UITextField *tInput;
@property (strong, nonatomic) IBOutlet UITextField *tInputExponent;
@property (strong, nonatomic) IBOutlet UITextField *bInput;
@property (strong, nonatomic) IBOutlet UITextField *bInputExponent;

@property const float D_CONST;

-(float) calculateWithValue:(float)t with:(float)b;
- (void) textChanged:(NSNotification*) note;

@end
