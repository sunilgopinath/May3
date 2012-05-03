//
//  SliderView.m
//  May3
//
//  Created by Sunil Gopinath on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SliderView.h"

@implementation SliderView

- (void) valueChanged: (id) sender {
	UISlider *s = sender;
    
	float red = (s.value - s.minimumValue)
    / (s.maximumValue - s.minimumValue);
    
	slider.backgroundColor = [UIColor colorWithRed:
                              red green: 0.0 blue: 1.0 - red alpha: 1.0];
    
	label.text = [NSString stringWithFormat: @"%5.1f° F == %5.1f° C",
                  slider.value, CELSIUS(slider.value)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		// Initialization code
		self.backgroundColor = [UIColor whiteColor];
		float minimumValue = 32;	//freezing point of water in Fahrenheit
		float maximumValue = 212;
        
		//Center the slider in the View.
		CGRect b = self.bounds;
		CGSize s = CGSizeMake(maximumValue - minimumValue, 16);
        
		CGRect f = CGRectMake(
                              b.origin.x + (b.size.width - s.width) / 2,
                              b.origin.y + (b.size.height - s.height) / 2,
                              s.width,
                              s.height
                              );
        
		slider = [[UISlider alloc] initWithFrame: f];
		slider.minimumValue = minimumValue;
		slider.maximumValue = maximumValue;
		slider.value = (minimumValue + maximumValue) / 2;
		slider.continuous = YES;	//default is YES
        
		//As the slider goes from the minimum to the maximum value,
		//red goes from 0 to 1.  Conversely, blue goes from 1 to 0.
        
		CGFloat red = (slider.value - slider.minimumValue)
        / (slider.maximumValue - slider.minimumValue);
        
		slider.backgroundColor = [UIColor colorWithRed:
                                  red green: 0.0 blue: 1.0 - red alpha: 1.0];
        
		[slider addTarget:self
                   action: @selector(valueChanged:)
         forControlEvents: UIControlEventValueChanged
         ];
        
		[self addSubview: slider];
        
		//Put the label above the slider
		//with a 10-pixel margin between them.
		UIFont *font = [UIFont fontWithName: @"Courier" size: 26];
		s = [@"123.4f° F == 123.4f° C" sizeWithFont: font];
        
		f = CGRectMake(
                       b.origin.x + (b.size.width - s.width) / 2,
                       b.origin.y + (b.size.height - slider.frame.size.height) / 2 - s.height - 10,
                       s.width,
                       s.height
                       );
        
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
