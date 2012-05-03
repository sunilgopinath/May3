//
//  May3AppDelegate.m
//  May3
//
//  Created by Sunil Gopinath on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "May3AppDelegate.h"
#import "BigView.h"
#import "View.h"

@implementation May3AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Override point for customization after application launch.
	NSBundle *bundle = [NSBundle mainBundle];
	NSLog(@"bundle.bundelPath == \"%@\"", bundle.bundlePath);
    
	NSString *filename = [bundle pathForResource: @"musette" ofType: @"mp3"];
	NSLog(@"filename == \"%@\"", filename);
    
	NSURL *url = [NSURL fileURLWithPath: filename isDirectory: NO];
	NSLog(@"url == \"%@\"", url);
    
	NSError *error = nil;
	player = [[AVAudioPlayer alloc] initWithContentsOfURL: url error: &error];
    
	if (player == nil) {
		NSLog(@"could not initialize player:  %@", error);
	} else {
		player.volume = 1.0;		//the default
		player.numberOfLoops = 0;	//negative for infinite loop
		[player setDelegate: self];
		//mono or stereo
		NSLog(@"player.numberOfChannels == %u", player.numberOfChannels);
        
		if (![player prepareToPlay]) {
			NSLog(@"prepareToPlay failed");
		}
        
        NSEnumerator *e = [player.settings keyEnumerator];
		NSString *key;
        
		while ((key = [e nextObject]) != nil) {
			if ([key isEqualToString: @"AVFormatIDKey"]) {
				const int i = ((NSNumber *)[player.settings objectForKey: key]).intValue;
				NSLog(@"%@ %c%c%c%c", key,
                      i >> 3 * CHAR_BIT & 0xFF,
                      i >> 2 * CHAR_BIT & 0xFF,
                      i >> 1 * CHAR_BIT & 0xFF,
                      i >> 0 * CHAR_BIT & 0xFF
                      );
			} else {
				NSLog(@"%@ %@", key, [player.settings objectForKey: key]);
			}
		}
	}
    
	UIScreen *screen = [UIScreen mainScreen];
	bigView = [[BigView alloc] initWithFrame: screen.applicationFrame];
	self.window = [[UIWindow alloc] initWithFrame: screen.bounds];
	//self.window.backgroundColor = [UIColor whiteColor];
    
	[self.window addSubview: bigView];
	[self.window makeKeyAndVisible];
	return YES;}

- (void) valueChanged: (id) sender {
	UISwitch *s = sender;
	if (s.isOn) {
		//The switch has just been turned on.
		if (![player play]) {
			NSLog(@"[player play] failed.");
		}
	} else {
		//The switch has just been turned off.
		NSLog(@"Paused at %g of %g seconds.", player.deviceCurrentTime, player.duration);
		[player pause];
	}
}

- (void) changeVolume: (id) sender {
    
}

- (void) audioPlayerDidFinishPlaying: (AVAudioPlayer *) p successfully: (BOOL) flag {
	if (p == player) {
		[view.mySwitch setOn: NO animated: NO];	//Go back to the OFF position.
	}
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
