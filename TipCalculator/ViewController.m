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
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (strong, nonatomic) UIToolbar *accessoryView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.billAmountTextField.delegate = self;
    self.tipPercentageTextField.delegate = self;
    
    self.accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0)];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(calculateTip)];
    
    [self.accessoryView setItems:@[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                                                                 target:self
                                                                                 action:@selector(previousTextField)],
                                   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                                                                 target:self
                                                                                 action:@selector(nextTextField)],
                                   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                 target:nil
                                                                                 action:nil],
                                   done]];
    
//    self.billAmountTextField.inputAccessoryView = self.accessoryView;
//    self.tipPercentageTextField.inputAccessoryView = self.accessoryView;

}

- (IBAction)calculateTip {
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSNumber *billAmount = [formatter numberFromString:self.billAmountTextField.text];
    
    NSNumber *tipPercentage = [formatter numberFromString:self.tipPercentageTextField.text];
    
    NSNumber *tipAmount;
    
    if (tipPercentage.floatValue != 0.0) {
        tipAmount = @(billAmount.floatValue * tipPercentage.floatValue / 100.0);
    } else {
        tipAmount = @(billAmount.floatValue * 0.15);
    }
    
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"You should tip: %@", [formatter stringFromNumber:tipAmount]];
    
    [self.billAmountTextField resignFirstResponder];
    [self.tipPercentageTextField resignFirstResponder];
    
}

// UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self calculateTip];
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.billAmountTextField) {
        [[self.accessoryView.items objectAtIndex:0] setEnabled:NO];
        [[self.accessoryView.items objectAtIndex:1] setEnabled:YES];
        textField.inputAccessoryView = self.accessoryView;
    } else if (textField == self.tipPercentageTextField) {
        [[self.accessoryView.items objectAtIndex:0] setEnabled:YES];
        [[self.accessoryView.items objectAtIndex:1] setEnabled:NO];
        textField.inputAccessoryView = self.accessoryView;
    }
}

- (void) nextTextField {
    if (self.billAmountTextField) {
        [self.billAmountTextField resignFirstResponder];
        [self.tipPercentageTextField becomeFirstResponder];
    }
}

- (void)previousTextField {
    if (self.tipPercentageTextField) {
        [self.tipPercentageTextField resignFirstResponder];
        [self.billAmountTextField becomeFirstResponder];
    }
}

@end
