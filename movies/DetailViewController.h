//
//  DetailViewController.h
//  movies
//
//  Created by farah mahmoud on 04/09/2018.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "network.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UITextView *overView;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *avg_rate;
@property (weak, nonatomic) IBOutlet UITableView *TrailerTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UITableView *ReviewTableView;
@property NSString *name;
@property NSString *r;
@property NSString *o;
@property NSString *rate;
@property NSMutableString *pic;
@property NSString *movieId;
@property NSMutableString *movieLinkWithId;
@property NSMutableString *movieReviews;
@property NSString *mykey;
@property NSMutableArray *movieIdForPlist;
//@property network *det;
- (IBAction)favAction:(id)sender;

@end
