//
//  TextView.h
//  May3
//
//  Created by Sunil Gopinath on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextView : UIView <UITextFieldDelegate> {
	UITextField *textField;
	UILabel *label;
}


@end
