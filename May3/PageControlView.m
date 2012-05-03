//
//  PageControlView.m
//  May3
//
//  Created by Sunil Gopinath on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageControlView.h"

@implementation PageControlView

- (void) touchUpInside: (id) sender {
	UIPageControl *c = sender;
    
	label.text = [NSString stringWithFormat:
                  @"page %2d of %d",
                  c.currentPage + 1, c.numberOfPages
                  ];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // Initialization code
		textView = [[UITextView alloc] initWithFrame: self.bounds];
		textView.textColor = [UIColor blueColor];
        //textView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"introductionbackground.jpg"]];
		textView.font = [UIFont fontWithName: @"Georgia" size: 16];
		textView.editable = NO;	//Don't pop up a keyboard.
		NSString *fullpath = [[NSBundle mainBundle] pathForResource:@"PageControl0" ofType:@"txt"];  
        if (fullpath) {  
            NSString *contents = [NSString stringWithContentsOfFile:fullpath encoding:NSUTF8StringEncoding error:nil];[NSString stringWithContentsOfFile:fullpath encoding:NSUTF8StringEncoding error:nil];
            if (contents) {  
                textView.text= contents;  
            }  
        } else {
            NSLog(@"filepath not found");
        }       
        [self addSubview: textView];
        
		self.backgroundColor = [UIColor whiteColor];
		NSInteger numberOfPages = 4;
        
		//Center the UIPageControl in the View.
		CGRect b = self.bounds;
		CGSize s = CGSizeMake(16 * numberOfPages, 16);	//size of UIPageControl
		
		CGRect f = CGRectMake(
                              b.origin.x + (b.size.width - s.width) / 2,
                              b.origin.y + (b.size.height - s.height) / 10,
                              s.width,
                              s.height
                              );
        
		control = [[UIPageControl alloc] initWithFrame: f];
        
		[control addTarget: self
                    action: @selector(pageChanged:)
          forControlEvents: UIControlEventTouchUpInside
         ];
        
		control.backgroundColor = [UIColor grayColor];
		control.hidesForSinglePage = NO;	//default is NO
		control.numberOfPages = numberOfPages;
		control.currentPage = 0;			//default is 0
		[self addSubview: control];
        
		//Put the label above the page control
		//with a 10-pixel margin between them.
		UIFont *font = [UIFont fontWithName: @"Courier" size: 24];
		s = [@"Page 10 of 10" sizeWithFont: font];
        
		f = CGRectMake(
                       b.origin.x + (b.size.width - s.width) / 2,
                       b.origin.y + (b.size.height - control.frame.size.height) / 2 - s.height - 10,
                       s.width,
                       s.height
                       );
        
		label = [[UILabel alloc] initWithFrame: f];
		label.textAlignment = UITextAlignmentCenter;
		label.font = font;
		[self touchUpInside: control];
		[self addSubview: label];
    }
    return self;
}

- (void) pageChanged: (id) sender {
    UIPageControl *c = sender;
    NSString *filename = [NSString stringWithFormat:@"PageControl%d", c.currentPage];
    NSString *fullpath = [[NSBundle mainBundle] pathForResource:filename ofType:@"txt"];  
    if (fullpath) {  
        NSString *contents = [NSString stringWithContentsOfFile:fullpath encoding:NSUTF8StringEncoding error:nil];[NSString stringWithContentsOfFile:fullpath encoding:NSUTF8StringEncoding error:nil];
        if (contents) {  
            textView.text= contents;  
        }  
    } else {
        NSLog(@"filepath not found");
    }
    
    label.text = [NSString stringWithFormat:
                  @"page %2d of %d",
                  c.currentPage + 1, c.numberOfPages
                  ];
    
    
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
