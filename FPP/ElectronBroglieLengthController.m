//
//  ElectronBroglieLengthController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronBroglieLengthController.h"

@interface ElectronBroglieLengthController ()

@end

@implementation ElectronBroglieLengthController

@synthesize lambaLabel;
@synthesize outputLambda;
@synthesize tInput;
@synthesize LAMBDA_CONST;
@synthesize tInputExponent;

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
    self.title = @"Electron deBroglie Length";
    
    self.LAMBDA_CONST = 2.76 * pow(10, -8);
    
    
    self.tInput.text = @"";
    self.tInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInput.clearButtonMode = true;
    [self.tInput becomeFirstResponder];
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInputExponent.clearButtonMode = true;
    
    self.outputLambda.text = @"0";
    self.outputLambda.layer.borderWidth = 1.0;
    self.outputLambda.layer.cornerRadius = 5;
    self.outputLambda.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.lambaLabel.text = @"\u019B =";
    
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

- (float) calculateWithInput:(float)t{
    return self.LAMBDA_CONST * pow(t, -.5);
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
    NSRange t_exp = [regexExp rangeOfFirstMatchInString:tInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[tInputExponent.text length])];
    if(t_base.location != NSNotFound
       && t_exp.location != NSNotFound){
        float B = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        NSLog(@"number: %g", B);
        
        //do calculations
        float l = [self calculateWithInput:B];
        
        self.outputLambda.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputLambda.text = @"Error with input";
    }
}


@end
