//
//  View.h
//  May3
//
//  Created by Sunil Gopinath on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "May3AppDelegate.h"

@interface View : UIView {
    UISwitch *mySwitch;
    UISlider *slider;
    UILabel *label;
    May3AppDelegate *appDelegate;
}
@property (strong, nonatomic) UISwitch *mySwitch;

@end
