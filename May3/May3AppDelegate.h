//
//  May3AppDelegate.h
//  May3
//
//  Created by Sunil Gopinath on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
@class View;
@class BigView;

@interface May3AppDelegate : UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate> {
	AVAudioPlayer *player;
	UIWindow *_window;
    BigView *bigView;
    View *view;
}

- (void) valueChanged: (id) sender;

@property (strong, nonatomic) UIWindow *window;

@end
