//
//  SearchCellViewController.h
//  MisteryShip
//
//  Created by David Calavera on 09/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"


@interface SearchCellViewController : UITableViewCell {
	UILabel *titleLabel;
	UILabel *addressLabel;
	UILabel *localityLabel;
	UIImageView *imageView;
}

-(void)setData:(NSDictionary *)dict;
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

// you should know what this is for by know
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *addressLabel;
@property (nonatomic, retain) UILabel *localityLabel;
@property (nonatomic, retain) UIImageView *imageView;

@end
