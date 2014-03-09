//
//  IonThermalVelocityController.m
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonThermalVelocityController.h"

@interface IonThermalVelocityController ()

@end

@implementation IonThermalVelocityController
@synthesize outputVelocity;
@synthesize muInput;
@synthesize muInputExponent;
@synthesize tInput;
@synthesize tInputExponent;
@synthesize VELOCITY_CONST;
@synthesize muLabel;

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
    self.title = @"Ion Thermal Velocity";
    
    self.VELOCITY_CONST = 9.79 * pow(10, 5);
    
    self.muInput.text = @"";
    self.muInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.muInput.clearButtonMode = true;
    [self.muInput becomeFirstResponder];
    
    self.tInput.text = @"";
    self.tInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInput.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.muInputExponent.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInputExponent.clearButtonMode = true;
    
    self.outputVelocity.text = @"0";
    self.outputVelocity.layer.borderWidth = 1.0;
    self.outputVelocity.layer.cornerRadius = 5;
    self.outputVelocity.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.muLabel.text = @"\u03BC";
    
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

- (float) calculateWithInput:(float)m with:(float)t{
    return self.VELOCITY_CONST * pow(m, -.5) * pow(t, .5);
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
    NSRange mu_base = [regexBase rangeOfFirstMatchInString:muInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[muInput.text length])];
    NSRange mu_exp = [regexExp rangeOfFirstMatchInString:muInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[muInputExponent.text length])];
    NSRange t_base = [regexBase rangeOfFirstMatchInString:tInput.text
                                                   options:0
                                                     range:NSMakeRange(0,[tInput.text length])];
    NSRange t_exp = [regexExp rangeOfFirstMatchInString:tInputExponent.text
                                                 options:0
                                                   range:NSMakeRange(0,[tInputExponent.text length])];
    if(mu_base.location != NSNotFound
       && mu_exp.location != NSNotFound
       && t_base.location != NSNotFound
       && t_exp.location != NSNotFound){
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        NSLog(@"number: %g, %g", m, t);
        
        //do calculations
        float l = [self calculateWithInput:m with:t];
        
        self.outputVelocity.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputVelocity.text = @"Error with input";
    }
}

@end
