//
//  May3AppDelegate.h
//  May3
//
//  Created by Sunil Gopinath on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class View;
@class BigView;
@class SegmentView;

@interface May3AppDelegate : UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate> {
	
	UIWindow *_window;
    BigView *bigView;
    View *view;

    @public AVAudioPlayer *player;
                            
                                              
}

- (void) valueChanged: (id) sender;

@property (strong, nonatomic) UIWindow *window;

@end
