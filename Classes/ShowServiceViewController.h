//
//  ShowServiceViewController.h
//  MisteryShip
//
//  Created by David Calavera on 11/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"


@interface ShowServiceViewController : UIViewController {
	IBOutlet UITableView *tableView;
	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *addressLabel;
	IBOutlet UILabel *localityLabel;
	IBOutlet UILabel *telephoneLabel;
	IBOutlet UILabel *contentLabel;
	IBOutlet UIImageView *thumbnailImage;
	IBOutlet UIImageView *mapImage;
	
	IBOutlet UIBarButtonItem *backButton;
	
	NSDictionary *entry;
}

@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, retain) UILabel *addressLabel;
@property(nonatomic, retain) UILabel *localityLabel;
@property(nonatomic, retain) UILabel *telephoneLabel;
@property(nonatomic, retain) UILabel *contentLabel;
@property(nonatomic, retain) UIImageView *thumbnailImage;
@property(nonatomic, retain) UIImageView *mapImage;
@property(nonatomic, retain) UIBarButtonItem *backButton;

@property(nonatomic, retain) NSDictionary *entry;

-(void)setData:(NSDictionary *)dict;

@end
