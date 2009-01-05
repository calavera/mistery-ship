//
//  ShowServiceViewController.m
//  MisteryShip
//
//  Created by David Calavera on 11/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ShowServiceViewController.h"


@implementation ShowServiceViewController

@synthesize tableView, titleLabel, addressLabel, localityLabel;
@synthesize telephoneLabel, contentLabel, thumbnailImage, mapImage, entry, backButton;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}*/


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}*/


- (void)viewDidLoad {
	
	titleLabel.text = [entry objectForKey: Api11870Title];
	addressLabel.text = [entry objectForKey: Api11870Address];
	localityLabel.text = [entry objectForKey: Api11870Locality];
	telephoneLabel.text = [entry objectForKey: Api11870Telephone];
	contentLabel.text = [entry objectForKey: Api11870Summary];
	
	if (nil != [entry objectForKey: Api11870Thumbnail]) {
		NSURL *url = [NSURL URLWithString: [entry objectForKey: Api11870Thumbnail]];
		self.thumbnailImage.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: url]];
	}
	
	if (nil != [entry objectForKey: Api11870Position]) {
		NSString *marker = [NSString stringWithFormat: @"&markers=%@", [[entry objectForKey: Api11870Position] stringByAppendingString: @",blue"]];
		NSURL *url = [NSURL URLWithString: [GoogleMapsApiKey stringByAppendingString: marker]];
		self.mapImage.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: url]];
	}
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
//	self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//	self.navigationController.navigationBarHidden = NO;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[thumbnailImage release];
	[titleLabel release];
    [super dealloc];
}

-(void)setData:(NSDictionary *)dict {
	self.entry = dict;
}


@end
