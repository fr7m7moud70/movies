//
//  FavMoviesCollectionViewController.m
//  movies
//
//  Created by farah mahmoud on 06/09/2018.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "FavMoviesCollectionViewController.h"
#import "network.h"
#import "AFHTTPSessionManager.h"

@interface FavMoviesCollectionViewController (){
    
    NSArray *moviesId;
    network *net;
}

@end

@implementation FavMoviesCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    net = [network new];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"FavMoviesList" ofType:@"plist"];
//
//    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"FavMoviesList.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"FavMoviesList" ofType:@"plist"];
    }
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    moviesId = [dict objectForKey:@"moviesId"];
    NSLog(@"%@",[moviesId objectAtIndex:0]);
    /*
    NSString *str = @"http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=acc6ebc9748b9b5b79969c205a1a8c90";
    
    //NSString *favMovieUrl = [NSString stringWithFormat:@"https://api.themoviedb.org/3/account/%@/favorite/movies?api_key=acc6ebc9748b9b5b79969c205a1a8c90&language=en-US&sort_by=created_at.asc&page=1", moviesId];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET: str
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             //NSLog(@"JSON: %@", responseObject);
             net.idsForFavView = [responseObject valueForKeyPath:@"results.id"];
             
             //NSLog(@"JSON: %@", net.idsidsForFavView );
             
             
             [self.collectionView reloadData];
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             // Handle failure
         }];
   */
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [moviesId count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //UIImageView *imageView = [cell viewWithTag:1];
    //imagesUrl = [NSMutableString new];
    //imagesUrl = [@"https://image.tmdb.org/t/p/w185/" stringByAppendingString:[net.poster_path objectAtIndex:indexPath.row]];
    
    //[imageView sd_setImageWithURL:[NSURL URLWithString:imagesUrl]placeholderImage:[UIImage imageNamed:@"123.jpg"]];
    
    return cell;
}





@end
