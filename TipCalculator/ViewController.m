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
@property (weak, nonatomic) IBOutlet UISlider *tipAdjustmentSlider;
@property (strong, nonatomic) UIToolbar *accessoryView;
@property (strong, nonatomic) NSNumberFormatter *formatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.formatter = [NSNumberFormatter new];
    
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
    
    self.tipAdjustmentSlider.value = 15.0;

}

- (IBAction)calculateTip {

    self.formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSNumber *billAmount = [self.formatter numberFromString:self.billAmountTextField.text];
    
    NSNumber *tipPercentage = [self.formatter numberFromString:self.tipPercentageTextField.text];
    
    NSNumber *tipAmount;
    
    if (![self.tipPercentageTextField.text isEqualToString:@""]) {
        tipAmount = @(billAmount.floatValue * tipPercentage.floatValue / 100.0);
        self.tipAdjustmentSlider.value = [[self.formatter numberFromString:self.tipPercentageTextField.text] floatValue];
    } else {
        self.tipPercentageTextField.text = [NSString stringWithFormat:@"%d", 15];
        tipAmount = @(billAmount.floatValue * 0.15);
    }
    
    self.formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"You should tip: %@", [self.formatter stringFromNumber:tipAmount]];
    
    [self.billAmountTextField resignFirstResponder];
    [self.tipPercentageTextField resignFirstResponder];
    
}

- (IBAction)adjustTipPercentage:(UISlider *)sender {
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%d", (int)sender.value];
    [self calculateTip];
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

// UITextFieldDelegate methods

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

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

@end
