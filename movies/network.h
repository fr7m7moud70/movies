//
//  network.h
//  movies
//
//  Created by farah mahmoud on 05/09/2018.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface network : NSObject

@property NSMutableArray *original_title;
@property NSMutableArray *overview;
@property NSMutableArray *vote_average;
@property NSMutableArray *release_date;
@property NSMutableArray *poster_path;
@property NSMutableArray *video;
@property NSMutableArray *ids;
@property NSMutableArray *idsForFavView;
@property NSMutableArray *videosId;
@property NSMutableArray *movieReviewContent;
@property NSMutableArray *userName;
@end

