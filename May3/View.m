//
//  View.m
//  May3
//
//  Created by Sunil Gopinath on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View
@synthesize mySwitch;	//in View.m

- (void) valueChanged: (id) sender {
	UISlider *s = sender;
    
	float red = (s.value - s.minimumValue)
    / (s.maximumValue - s.minimumValue);
    
	slider.backgroundColor = [UIColor colorWithRed:
                              red green: 0.0 blue: 1.0 - red alpha: 1.0];
    
	label.text = [NSString stringWithFormat: @"%2.0f",
                  slider.value];
    
    NSLog(@"slide value = %f", slider.value);
    NSLog(@"player volume should be = %f", (slider.value/100));
    appDelegate->player.volume = slider.value/100;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		// Initialization code
        //we need to call the app delegate to use the sound id
        appDelegate = (May3AppDelegate *)[[UIApplication sharedApplication] delegate];
        
		self.backgroundColor = [UIColor whiteColor];
		
		//Do not specify a size for the switch.
		//Let the switch assume its own natural size.
		mySwitch = [[UISwitch alloc] initWithFrame: CGRectZero];
		if (mySwitch == nil) {
			return nil;
		}
        
		//Call the valueChanged: method of the application delegate
		//when the value of the switch is changed.
		
		[mySwitch addTarget: [UIApplication sharedApplication].delegate
                     action: @selector(valueChanged:)
           forControlEvents: UIControlEventValueChanged
         ];
		
		//Center the switch in the SwitchView.
		CGRect b = self.bounds;
        
		mySwitch.center = CGPointMake(
                                      b.origin.x + b.size.width / 2,
                                      b.origin.y + b.size.height / 2
                                      );
        
		mySwitch.on = NO;	//the default
		[self addSubview: mySwitch];
        
        // making a volume control
		float minimumValue = 0;	//
		float maximumValue = 100;
        
		//Center the slider in the View.
		CGSize s = CGSizeMake(maximumValue - minimumValue, 16);
        
		CGRect f = CGRectMake(
                              b.origin.x + (b.size.width - s.width) / 2,
                              b.origin.y + (b.size.height - s.height) / 6,
                              s.width,
                              s.height
                              );
        
		slider = [[UISlider alloc] initWithFrame: f];
		slider.minimumValue = minimumValue;
		slider.maximumValue = maximumValue;
		slider.value = (minimumValue + maximumValue);
		slider.continuous = YES;	//default is YES
        
		//As the slider goes from the minimum to the maximum value,
		//red goes from 0 to 1.  Conversely, blue goes from 1 to 0.

        
		[slider addTarget:self
                   action: @selector(valueChanged:)
         forControlEvents: UIControlEventValueChanged
         ];
		[self addSubview: slider];
        
        f = CGRectMake(
                       b.origin.x + (b.size.width - s.width) / 2,
                       b.origin.y + (b.size.height - slider.frame.size.height) / 6 - s.height - 10,
                       s.width,
                       s.height
                       );
        
        UIFont *font = [UIFont fontWithName: @"Courier" size: 26];
		s = [@"50" sizeWithFont: font];
        
		label = [[UILabel alloc] initWithFrame: f];
		label.textAlignment = UITextAlignmentCenter;
		label.font = font;
		[self valueChanged: slider];
		[self addSubview: label];
	}
    return self;
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
