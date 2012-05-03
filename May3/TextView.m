//
//  TextView.m
//  May3
//
//  Created by Sunil Gopinath on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TextView.h"

@implementation TextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Initialization code
		self.backgroundColor = [UIColor whiteColor];
		UIFont *font = [UIFont systemFontOfSize: 24];
		CGFloat height = [@"A" sizeWithFont: font].height;
        
		//Center the UITextField in the TextFieldView.
		CGRect b = self.bounds;
        
		CGRect f = CGRectMake(
                              b.origin.x,
                              b.origin.y,
                              b.size.width,
                              height
                              );
        
        textField = [[UITextField alloc] initWithFrame: f];
		textField.borderStyle = UITextBorderStyleNone;	//default
		textField.backgroundColor = [UIColor yellowColor];
		textField.textColor = [UIColor blackColor];
        
		textField.clearButtonMode = UITextFieldViewModeAlways;
		textField.keyboardType = UIKeyboardTypeDefault;
		textField.returnKeyType = UIReturnKeyDone;
        
		textField.font = font;
		textField.placeholder = @"<type a word>";
		textField.textAlignment = UITextAlignmentLeft;	//default
		textField.autocapitalizationType = UITextAutocapitalizationTypeNone; //default
		textField.autocorrectionType = UITextAutocorrectionTypeNo;
		textField.secureTextEntry = NO;	//for secret passwords
        
        textField.delegate = self;
		[self addSubview: textField];
        
		f = CGRectMake(
                       b.origin.x,
                       b.origin.y + textField.bounds.size.height + 10,
                       b.size.width,
                       height
                       );
        
		label = [[UILabel alloc] initWithFrame: f];
		label.backgroundColor = [UIColor orangeColor];
		label.font = font;
		[self addSubview: label];

    }
    return self;
}

#pragma mark -
#pragma mark methods of UITextFieldDelegate protocol

//Called when return key is pressed.
//Decide if the app should accept this input and hide the keyboard.

- (BOOL) textFieldShouldReturn: (UITextField *) tf {
	if ([tf.text isEqualToString: @""]) {
		textField.placeholder = @"<type a non-empty word>";
	} else {
		[tf resignFirstResponder];	//Hide keyboard.
	}
	return YES;	//The text field should do its default behavior.
}

- (void) textFieldDidEndEditing: (UITextField *) tf {
	if ([textField.text isEqualToString: @""]) {
		label.text = @"";
	} else {
		NSString *lowercase = [textField.text lowercaseString];
        
		label.text = [NSString stringWithFormat: @"%@%@ay",
                      [lowercase substringFromIndex: 1],	//all characters except the first
                      [lowercase substringToIndex: 1]		//the first character
                      ];
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
