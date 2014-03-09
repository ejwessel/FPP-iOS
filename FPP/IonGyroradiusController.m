//
//  IonGyroradiusController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonGyroradiusController.h"

@interface IonGyroradiusController ()

@end

@implementation IonGyroradiusController
@synthesize outputRadius;
@synthesize muInput;
@synthesize muInputExponent;
@synthesize zInput;
@synthesize zInputExponent;
@synthesize tInput;
@synthesize tInputExponent;
@synthesize bInput;
@synthesize bInputExponent;
@synthesize muLabel;
@synthesize RADIUS_CONST;

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
    self.title = @"Ion Gyroradius";
    
    self.RADIUS_CONST = 1.02 * pow(10, 2);
    
    self.muInput.text = @"";
    self.muInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.muInput.clearButtonMode = true;
    [self.muInput becomeFirstResponder];
    
    self.zInput.text = @"";
    self.zInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.zInput.clearButtonMode = true;
    
    self.tInput.text = @"";
    self.tInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInput.clearButtonMode = true;
    
    self.bInput.text = @"";
    self.bInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.bInput.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.muInputExponent.clearButtonMode = true;
    
    self.zInputExponent.text = @"0";
    self.zInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.zInputExponent.clearButtonMode = true;
    
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
    
    self.muLabel.text = @"\u03BC =";
    
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

- (float) calculateWithInput:(float)m with:(float)z with:(float)t with:(float)b{
    return self.RADIUS_CONST * pow(m, .5) * pow(z, -1) * pow(t, .5) * pow(b, -1);
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
    NSRange z_base = [regexBase rangeOfFirstMatchInString:zInput.text
                                                   options:0
                                                     range:NSMakeRange(0,[zInput.text length])];
    NSRange z_exp = [regexExp rangeOfFirstMatchInString:zInputExponent.text
                                                 options:0
                                                   range:NSMakeRange(0,[zInputExponent.text length])];
    NSRange t_base = [regexBase rangeOfFirstMatchInString:tInput.text
                                                   options:0
                                                     range:NSMakeRange(0,[tInput.text length])];
    NSRange t_exp = [regexExp rangeOfFirstMatchInString:tInputExponent.text
                                                 options:0
                                                   range:NSMakeRange(0,[tInputExponent.text length])];
    NSRange b_base = [regexBase rangeOfFirstMatchInString:bInput.text
                                                   options:0
                                                     range:NSMakeRange(0,[bInput.text length])];
    NSRange b_exp = [regexExp rangeOfFirstMatchInString:bInputExponent.text
                                                 options:0
                                                   range:NSMakeRange(0,[bInputExponent.text length])];
    
    if(b_base.location != NSNotFound
       && b_exp.location != NSNotFound
       && z_base.location != NSNotFound
       && z_exp.location != NSNotFound
       && mu_base.location != NSNotFound
       && mu_exp.location != NSNotFound
       && t_base.location != NSNotFound
       && t_exp.location != NSNotFound){
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        float z = [self.zInput.text floatValue] * pow(10, [self.zInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        float b = [self.bInput.text floatValue] * pow(10, [self.bInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g, %g", m, z, t, b);
        
        //do calculations
        float r = [self calculateWithInput:m with:z with:t with:b];
        
        self.outputRadius.text = [[NSString alloc] initWithFormat:@"%.3e", r];
    }
    else{
        self.outputRadius.text = @"Error with input";
    }
}



@end
