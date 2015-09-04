//
//  ViewController.m
//  TipCalculator
//
//  Created by Alp Eren Can on 04/09/15.
//  Copyright (c) 2015 Alp Eren Can. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.billAmountTextField.delegate = self;
    
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0)];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(calculateTip)];
    
    [accessoryView setItems:@[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                          target:nil
                                                                          action:nil],
                              done]];
    
    self.billAmountTextField.inputAccessoryView = accessoryView;

}

- (IBAction)calculateTip {
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSNumber *billAmount = [formatter numberFromString:self.billAmountTextField.text];
    
    NSNumber *tipAmount = @(billAmount.floatValue * 0.15);
    
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"You should tip: %@", [formatter stringFromNumber:tipAmount]];
    
    [self.billAmountTextField resignFirstResponder];
    
}

// UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self calculateTip];
    return YES;
}

@end
