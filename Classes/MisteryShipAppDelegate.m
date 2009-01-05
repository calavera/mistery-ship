//
//  MisteryShipAppDelegate.m
//  MisteryShip
//
//  Created by David Calavera on 12/12/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "MisteryShipAppDelegate.h"
#import "RootViewController.h"


@implementation MisteryShipAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	navigationController.navigationBarHidden = YES;
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
