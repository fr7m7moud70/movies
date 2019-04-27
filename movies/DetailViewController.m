//
//  DetailViewController.m
//  movies
//
//  Created by farah mahmoud on 04/09/2018.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "DetailViewController.h"
#import "AFHTTPSessionManager.h"
#import "network.h"
@interface DetailViewController (){
    
    network *net;
    NSMutableString *videoUrl;
    NSArray *arr;
}

@end

@implementation DetailViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    net = [network new];
    //arr = [NSArray new];
    //arr =@[@"one", @"two", @"three"];
    [_TrailerTableView setDataSource: self];
    [_TrailerTableView setDelegate: self];
    
    [_ReviewTableView setDataSource: self];
    [_ReviewTableView setDelegate: self];
    

    [_myScrollView setScrollEnabled:YES];
    //[_myScrollView setContentSize:CGSizeMake(320, 1000)];
   
    
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

-(void)viewDidAppear:(BOOL)animated{
    CGRect contentRect = CGRectZero;
    
    for (UIView *view in self.ScrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.ScrollView.contentSize = contentRect.size;
    
    dispatch_async(dispatch_get_main_queue(),^{
        CGRect frame = self.ReviewTableView.frame;
        frame.size.height = self.ReviewTableView.contentSize.height;
        self.ReviewTableView.frame = frame;
        
    });
    
    dispatch_async(dispatch_get_main_queue(),^{
        CGRect frame = self.TrailerTableView.frame;
        frame.size.height = self.TrailerTableView.contentSize.height;
        self.TrailerTableView.frame = frame;

    });
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == _TrailerTableView){
    return 1;
    }else {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _TrailerTableView){
            return [net.videosId count];
    }else {
        return [net.userName count];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _TrailerTableView){
            videoUrl = [NSMutableString new];
            videoUrl = [NSMutableString stringWithFormat:@"https://www.youtube.com/watch?v=%@", [net.videosId objectAtIndex:indexPath.row]];
    //NSLog(@"%@",videoUrl);
            UIApplication *application = [UIApplication sharedApplication];
            [application openURL:[NSURL URLWithString: videoUrl] options:@{} completionHandler:nil];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == _ReviewTableView){
        return 200;
    }
     return 50;
}



/*-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}*/


- (IBAction)favAction:(id)sender {
    
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [paths objectAtIndex:0];
//    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"FavMoviesList.plist"];
//
//    _movieIdForPlist = [NSMutableArray new];
//    [_movieIdForPlist addObject:_movieId];
//
//    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithObjects: [NSArray arrayWithObjects: _movieIdForPlist, nil] forKeys:[NSArray arrayWithObjects: @"moviesId", nil]];
//
//    NSError *error = nil;
//    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
//
//    if(plistData)
//    {
//        [plistData writeToFile:plistPath atomically:YES];
//        printf("movie is added to fav list");
//    }
//    else
//    {
//       printf("movie is not added to fav list");
//    }

}
@end
