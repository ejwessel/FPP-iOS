//
//  IonSoundVelocityController.m
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonSoundVelocityController.h"

@interface IonSoundVelocityController ()

@end

@implementation IonSoundVelocityController
@synthesize outputC;
@synthesize gammaInput;
@synthesize zInput;
@synthesize tInput;
@synthesize muInput;
@synthesize C_CONST;
@synthesize gammaLabel;
@synthesize muLabel;
@synthesize gammaInputExponent;
@synthesize zInputExponent;
@synthesize tInputExponent;
@synthesize muInputExponent;

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
    self.title = @"Ion Sound Velocity";
    
    self.C_CONST = 9.79 * pow(10, 5);
    
    self.gammaInput.text = @"";
    self.gammaInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.gammaInput.clearButtonMode = true;
    [self.gammaInput becomeFirstResponder];
    
    self.zInput.text = @"";
    self.zInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.zInput.clearButtonMode = true;
    
    self.tInput.text = @"";
    self.tInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.tInput.clearButtonMode = true;
    
    self.muInput.text = @"";
    self.muInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.muInput.clearButtonMode = true;
    
    self.gammaInputExponent.text = @"0";
    self.gammaInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.gammaInputExponent.clearButtonMode = true;
    
    self.zInputExponent.text = @"0";
    self.zInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.zInputExponent.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.tInputExponent.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.muInputExponent.clearButtonMode = true;
    
    self.outputC.text = @"0";
    self.outputC.layer.borderWidth = 1.0;
    self.outputC.layer.cornerRadius = 5;
    self.outputC.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.muLabel.text = @"\u03BC";
    self.gammaLabel.text = @"\u03B3";
    
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

- (float) calculateWithInput:(float)g with:(float)z with:(float)t with:(float)m{
    return self.C_CONST * pow(g * z * t / m, .5) ;
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
    NSRange gamma_base = [regexBase rangeOfFirstMatchInString:gammaInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[gammaInput.text length])];
    NSRange gamma_exp = [regexExp rangeOfFirstMatchInString:gammaInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[gammaInputExponent.text length])];
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
    NSRange mu_base = [regexBase rangeOfFirstMatchInString:muInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[muInput.text length])];
    NSRange mu_exp = [regexExp rangeOfFirstMatchInString:muInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[muInputExponent.text length])];
    if(t_base.location != NSNotFound
       && t_exp.location != NSNotFound
       && z_base.location != NSNotFound
       && z_exp.location != NSNotFound
       && mu_base.location != NSNotFound
       && mu_exp.location != NSNotFound
       && gamma_base.location != NSNotFound
       && gamma_exp.location != NSNotFound){
        float g = [self.gammaInput.text floatValue] * pow(10, [self.gammaInputExponent.text floatValue]);
        float z = [self.zInput.text floatValue] * pow(10, [self.zInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        NSLog(@"number: %g, %g", m, t);
        
        //do calculations
        float l = [self calculateWithInput:g with:z with:t with:m];
        
        self.outputC.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputC.text = @"Error with input";
    }
}

@end
