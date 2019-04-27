//
//  DetailsTableViewController.m
//  movies
//
//  Created by farah mahmoud on 09/09/2018.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "DetailsTableViewController.h"
#import "AFHTTPSessionManager.h"
#import "network.h"
#import "TrailersTableViewController.h"

@interface DetailsTableViewController (){
    
    network *net;
    NSMutableString *videoUrl;
    NSArray *arr;
    
}

@end

@implementation DetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    net = [network new];
    [_TrailerTableView setDataSource: self];
    [_TrailerTableView setDelegate: self];
    
    [_ReviewTableView setDataSource: self];
    [_ReviewTableView setDelegate: self];
    
    
    
    [_movieName setText:_name];
    [_overView setText:_o];
    [_avg_rate setText:_rate];
    [_releaseDate setText:_r];
    [_movieImage sd_setImageWithURL:[NSURL URLWithString:_pic] placeholderImage:[UIImage imageNamed:@"123.jpg"]];
    
    
    
    
    
    _movieLinkWithId = [NSMutableString new];
    _movieLinkWithId = [NSMutableString stringWithFormat: @"https://api.themoviedb.org/3/movie/%@/videos?api_key=acc6ebc9748b9b5b79969c205a1a8c90&language=en-US", _movieId ];
    
    _movieReviews = [NSMutableString new];
    _movieReviews = [NSMutableString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/reviews?api_key=acc6ebc9748b9b5b79969c205a1a8c90", _movieId];
    
    //NSLog(@"%@",_movieLinkWithId);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET: _movieLinkWithId
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             //NSLog(@"JSON: %@", responseObject);
             
             net.videosId= [responseObject valueForKeyPath:@"results.id"];
             
             //NSLog(@"videos id: %@", net.videosId );
             
             
             [self.TrailerTableView reloadData];
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             // Handle failure
         }];
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager1 GET: _movieReviews
       parameters:nil
          success:^(NSURLSessionDataTask *task, id responseObject) {
              //NSLog(@"JSON: %@", responseObject);
              
              net.movieReviewContent= [responseObject valueForKeyPath:@"results.content"];
              net.userName= [responseObject valueForKeyPath:@"results.author"];
              //NSLog(@"videos id: %@", net.userName );
              
              
              [self.ReviewTableView reloadData];
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              // Handle failure
          }];
    
}

/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _TrailerTableView){
        return [net.videosId count];
    }else if(tableView == _ReviewTableView) {
        return [net.userName count];
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == _TrailerTableView){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UILabel *label = [cell viewWithTag:1];
        
        [label setText: [NSString stringWithFormat: @"Movie Trailer %ld", (long)indexPath.row+1 ] ];
        return cell;
    }else{
        
        static NSString *CellIdentifier = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UILabel *label1 = [cell viewWithTag:1];
        UITextView *text = [cell viewWithTag:2];
        
        [label1 setText: [net.userName objectAtIndex : indexPath.row ]];
        [text setText: [net.movieReviewContent objectAtIndex : indexPath.row ] ];
        return cell;
        
    }
    
    
}


*/

@end
