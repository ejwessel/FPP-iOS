//
//  ElectronGyroradiusController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronGyroradiusController.h"

@interface ElectronGyroradiusController ()

@end

@implementation ElectronGyroradiusController
@synthesize outputRadius;
@synthesize tInput;
@synthesize bInput;
@synthesize RADIUS_CONST;
@synthesize tInputExponent;
@synthesize bInputExponent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    self.title = @"Electron Gyroradius";
    
    self.RADIUS_CONST = 2.38;
    
    self.tInput.text = @"";
    self.tInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInput.clearButtonMode = true;
    [self.tInput becomeFirstResponder];
    
    self.bInput.text = @"";
    self.bInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.bInput.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInputExponent.clearButtonMode = true;
    
    self.bInputExponent.text = @"0";
    self.bInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.bInputExponent.clearButtonMode = true;
    
    self.outputRadius.text = @"0";
    self.outputRadius.layer.borderWidth = 1.0;
    self.outputRadius.layer.cornerRadius = 5;
    self.outputRadius.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(textChanged:)
     name:UITextFieldTextDidChangeNotification
     object:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float) calculateWithInput:(float)t with:(float)b{
    return self.RADIUS_CONST * pow(t, .5) * pow(b, -1);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    NSError *regError = NULL;
    NSRegularExpression *regexBase = [NSRegularExpression regularExpressionWithPattern:BASE_REGEX
                                                                               options:0
                                                                                 error:&regError];
    NSRegularExpression *regexExp = [NSRegularExpression regularExpressionWithPattern:EXP_REGEX
                                                                              options:0
                                                                                error:&regError];
    NSRange t_base = [regexBase rangeOfFirstMatchInString:tInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[tInput.text length])];
    NSRange t_exp = [regexExp rangeOfFirstMatchInString:bInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[bInputExponent.text length])];
    NSRange b_base = [regexBase rangeOfFirstMatchInString:bInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[bInput.text length])];
    NSRange b_exp = [regexExp rangeOfFirstMatchInString:bInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[bInputExponent.text length])];
    if(b_base.location != NSNotFound
       && b_exp.location != NSNotFound
       && t_base.location != NSNotFound
       && t_exp.location != NSNotFound){
           float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
           float b = [self.bInput.text floatValue] * pow(10, [self.bInputExponent.text floatValue]);
           NSLog(@"number: %g, %g", t, b);
           
           //do calculations
           float r = [self calculateWithInput:t with:b];
           
           self.outputRadius.text = [[NSString alloc] initWithFormat:@"%.3e", r];
       }
       else{
           self.outputRadius.text = @"Error with input";
       }
}
@end
