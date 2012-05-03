//
//  DatePickerView.m
//  May3
//
//  Created by Sunil Gopinath on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

- (void) valueChanged
{
	textView.text = [dateFormatter stringFromDate: datePicker.date];
    // change date from Sunday forward
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"EEEE"];
    NSString *dateString = [dayFormatter stringFromDate:datePicker.date];
    NSLog(@"day of week = %@", dateString);
    if([dateString isEqualToString: @"Sunday"]) {
        NSDate *newDate = [datePicker.date dateByAddingTimeInterval:60*60*24];
        [datePicker setDate:newDate animated:YES];
    }

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        dateFormatter = [[NSDateFormatter alloc] init];
        
		[dateFormatter setDateStyle: NSDateFormatterFullStyle];
		[dateFormatter setTimeStyle: NSDateFormatterFullStyle];
        
		//Let the date picker assume its natural size.
		datePicker = [[UIDatePicker alloc] initWithFrame: CGRectZero];
        datePicker.calendar =
		[[NSCalendar alloc] initWithCalendarIdentifier: NSHebrewCalendar];
        
        NSLog(@"picker.calendar.calendarIdentifier == %@",
              datePicker.calendar.calendarIdentifier);
		//datePicker.datePickerMode = UIDatePickerModeDate; //vs. UIDatePickerModeTime
        
        //so we don't have to look up the day of the week of December 31, 2011
		[dateFormatter setDateStyle: NSDateFormatterLongStyle];
        
		//so we don't have to specify a time
		[dateFormatter setTimeStyle: NSDateFormatterNoStyle];
        

                
		//Center the picker in the DatePickerView.
		CGRect b = self.bounds;
        
		datePicker.frame = CGRectMake(
                                      b.origin.x,
                                      b.origin.y,
                                      datePicker.bounds.size.width,
                                      datePicker.bounds.size.height
                                      );
        
		[datePicker addTarget: self
                       action: @selector(valueChanged)
             forControlEvents: UIControlEventValueChanged
         ];
        
		[self addSubview: datePicker];
        
		//TextView occupies all of the View below the picker.
        
		CGRect f = CGRectMake(
                              b.origin.x,
                              b.origin.y + datePicker.bounds.size.height,
                              b.size.width,
                              b.size.height - datePicker.bounds.size.height
                              );
        
		textView = [[UITextView alloc] initWithFrame: f];
		textView.editable = NO;
		textView.font = [UIFont systemFontOfSize: 22];
		[self valueChanged];
		[self addSubview: textView];
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
