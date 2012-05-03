//
//  BigView.m
//  May3
//
//  Created by Sunil Gopinath on 5/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BigView.h"
#import "View.h"
#import "PageControlView.h"
#import "SliderView.h"

@implementation BigView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor blueColor];
    CGRect viewRect = CGRectMake(0, self.bounds.size.height/10, self.bounds.size.width, self.bounds.size.height);
    if (self) {
        // Initialization code
        views = [NSArray arrayWithObjects:
                 [[View alloc] initWithFrame:viewRect],
                 [[PageControlView alloc] initWithFrame:viewRect],
                 nil
                 ];
        index = 0;
        [self addSubview:[views objectAtIndex:index]];
        
        //prev, next navigation
        CGFloat spacing = 5.0;
        
        previous = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		previous.frame = CGRectMake(0, 
                                    0, 
                                    self.bounds.size.width/3,
                                    self.bounds.size.height/10
                                    );
        [previous setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
        [previous setTitle: @"Previous" forState: UIControlStateNormal];
        [previous setImage: [UIImage imageNamed: @"prev.jpg"] forState:UIControlStateNormal];
        CGSize previousImageSize = previous.imageView.frame.size;
        CGSize previousTitleSize = previous.titleLabel.frame.size;
        
        // lower the text and push it left to center it
        previous.titleEdgeInsets = UIEdgeInsetsMake(
                                                    0.0, 
                                                    -previousImageSize.width, 
                                                    - (previousImageSize.height + spacing), 
                                                    0.0
                                                    );
        
        // the text width might have changed (in case it was shortened before due to 
        // lack of space and isn't anymore now), so we get the frame size again
        previousTitleSize = previous.titleLabel.frame.size;
        
        // raise the image and push it right to center it
        previous.imageEdgeInsets = UIEdgeInsetsMake(
                                                    - (previousTitleSize.height + spacing), 
                                                    0.0, 
                                                    0.0, 
                                                    - previousTitleSize.width
                                                    );
        [previous addTarget: self
                     action: @selector(moveToPrevious)
           forControlEvents: UIControlEventTouchUpInside
         ];
        
		[self addSubview: previous];
        
        //prev, next navigation
        next = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		next.frame = CGRectMake(2*self.bounds.size.width/3, 
                                0, 
                                self.bounds.size.width/3,
                                self.bounds.size.height/10
                                );
        [next setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
        [next setImage: [UIImage imageNamed: @"next.jpg"] forState:UIControlStateNormal];
        [next setTitle: @"Next" forState: UIControlStateNormal];
        // the space between the image and text
        
        
        // get the size of the elements here for readability
        CGSize imageSize = next.imageView.frame.size;
        CGSize titleSize = next.titleLabel.frame.size;
        
        // lower the text and push it left to center it
        next.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        
        // the text width might have changed (in case it was shortened before due to 
        // lack of space and isn't anymore now), so we get the frame size again
        titleSize = next.titleLabel.frame.size;
        
        // raise the image and push it right to center it
        next.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
		[next addTarget: self
                 action: @selector(moveToNext)
       forControlEvents: UIControlEventTouchUpInside
         ];
        
		[self addSubview: next];
        
        
        
        
        
    }
    return self;
}

- (void) swipe: (UISwipeGestureRecognizer *) recognizer {
	CGPoint p = [recognizer locationInView: self];
    // need to make this a global variable
    CGRect viewRect = CGRectMake(0, self.bounds.size.height/10, self.bounds.size.width, self.bounds.size.height);
    //NSString *direction = @"unknown";
    if(CGRectContainsPoint(viewRect, p)) {
        NSLog(@"in the viewable rect");
        
        if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
            NSLog(@"→");
            //toggle the index
            NSUInteger newIndex = index;
            if(index < views.count-1) {
                newIndex++;
            } else {
                newIndex = 0;
            }
            NSLog(@"index is %i and newIndex is %i", index, newIndex);
            [UIView transitionFromView: [views objectAtIndex: index]
                                toView: [views objectAtIndex: newIndex]
                              duration: 2.25
                               options: UIViewAnimationOptionTransitionFlipFromLeft
                            completion: NULL
             ];
            if(index < views.count-1) {
                index++;
            } else {
                index = 0;
            }
        } else if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
            NSLog(@"←");
            NSUInteger newIndex = index;
            if(index > 1) {
                newIndex--;
            } else {
                newIndex = views.count - 1;
            }
            NSLog(@"index is %i and newIndex is %i", index, newIndex);
            [UIView transitionFromView: [views objectAtIndex: index]
                                toView: [views objectAtIndex: newIndex]
                              duration: 2.25
                               options: UIViewAnimationOptionTransitionFlipFromRight
                            completion: NULL
             ];
            if(index > 1) {
                index--;
            } else {
                index = views.count - 1 ;
            }
        } else if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
            NSLog(@"↑");
            [UIView transitionFromView: [views objectAtIndex: index]
                                toView: [views objectAtIndex: 0]
                              duration: 2.25
                               options: UIViewAnimationOptionTransitionFlipFromBottom
                            completion: NULL
             ];
            
        } else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
            NSLog(@"↓");
            [UIView transitionFromView: [views objectAtIndex: index]
                                toView: [views objectAtIndex: views.count-1]
                              duration: 2.25
                               options: UIViewAnimationOptionTransitionFlipFromLeft
                            completion: NULL
             ];
        }
        
    }
    
    
}

- (void) moveToPrevious {
    
    NSLog(@"←");
    NSUInteger newIndex = index;
    if(index > 1) {
        newIndex--;
    } else {
        newIndex = views.count - 1;
    }
    NSLog(@"index is %i and newIndex is %i", index, newIndex);
    [UIView transitionFromView: [views objectAtIndex: index]
                        toView: [views objectAtIndex: newIndex]
                      duration: 2.25
                       options: UIViewAnimationOptionTransitionFlipFromRight
                    completion: NULL
     ];
    if(index > 1) {
        index--;
    } else {
        index = views.count - 1 ;
    }
    
}

- (void) moveToNext {
    NSLog(@"→");
    //toggle the index
    NSUInteger newIndex = index;
    if(index < views.count-1) {
        newIndex++;
    } else {
        newIndex = 0;
    }
    NSLog(@"index is %i and newIndex is %i", index, newIndex);
    [UIView transitionFromView: [views objectAtIndex: index]
                        toView: [views objectAtIndex: newIndex]
                      duration: 2.25
                       options: UIViewAnimationOptionTransitionFlipFromLeft
                    completion: NULL
     ];
    if(index < views.count-1) {
        index++;
    } else {
        index = 0;
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