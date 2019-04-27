//
//  HomeCollectionViewController.m
//  movies
//
//  Created by farah mahmoud on 04/09/2018.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import "DetailViewController.h"
#import "DetailsTableViewController.h"
#import "network.h"
#import "AFHTTPSessionManager.h"
#import "popOverViewController.h"
@interface HomeCollectionViewController (){
    
    NSMutableString *imagesUrl;
    NSArray *images;
    network *net;
    
}

@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
     //Uncomment the following line to preserve selection between presentations
     //self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
   // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    net = [network new];
    NSString *str = @"http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=acc6ebc9748b9b5b79969c205a1a8c90";
    
    //@"http://api.themoviedb.org/3/discover/movie?sort_by=vote_average.desc&api_key=acc6ebc9748b9b5b79969c205a1a8c90";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET: str
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
            //NSLog(@"JSON: %@", responseObject);
             net.original_title = [responseObject valueForKeyPath:@"results.original_title"];
             net.overview = [responseObject valueForKeyPath:@"results.overview"];
             net.release_date = [responseObject valueForKeyPath:@"results.release_date"];
             net.vote_average = [responseObject valueForKeyPath:@"results.vote_average"];
             net.poster_path = [responseObject valueForKeyPath:@"results.poster_path"];
             net.ids = [responseObject valueForKeyPath:@"results.id"];
             
             //NSLog(@"JSON: %@", net.ids );
           
             
             [self.collectionView reloadData];
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             // Handle failure
         }];
    
    
   
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [net.poster_path count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    UIImageView *imageView = [cell viewWithTag:1];
    imagesUrl = [NSMutableString new];
    imagesUrl = [NSMutableString stringWithFormat: @"https://image.tmdb.org/t/p/w185/%@" ,[net.poster_path objectAtIndex:indexPath.row]];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:imagesUrl]placeholderImage:[UIImage imageNamed:@"123.jpg"]];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = [[UIScreen mainScreen] bounds].size.width/2;
    CGFloat cellHeight = cellWidth * 1.5;
    return CGSizeMake(cellWidth, cellHeight);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //DetailViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    DetailsTableViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsTable"];
    NSString *s1 = [net.original_title objectAtIndex:indexPath.row];
    NSString *s2 = [net.release_date objectAtIndex:indexPath.row];
    NSString *s3 = [net.overview objectAtIndex:indexPath.row];
    NSString *s4 = [NSString stringWithFormat:@"%@", [net.vote_average objectAtIndex:indexPath.row]];
    NSMutableString *s5 = [NSMutableString stringWithFormat:@"http://image.tmdb.org/t/p/w185/%@", [net.poster_path objectAtIndex:indexPath.row]];
    NSString *s6 = [net.ids objectAtIndex:indexPath.row] ;
    
   //NSLog(@"Value of title %@",[[result objectAtIndex:indexPath.row] objectForKey:@"vote_average"]);
    [details setName:s1];
    [details setR:s2];
    [details setO:s3];
    [details setRate:s4];
    [details setPic:s5];
    [details setMovieId:s6];
    
    //NSLog(@"movie id%@", s6);
    
    [self.navigationController pushViewController:details animated:YES];
    
    
}


- (IBAction)sortAction:(id)sender {
    
    popOverViewController* pop ;
    if(pop == nil){
        pop = [self.storyboard instantiateViewControllerWithIdentifier:@"popOver"];
    }
    // set modal presentation style to popover on your view controller
    // must be done before you reference controller.popoverPresentationController
    pop.modalPresentationStyle = UIModalPresentationPopover;
    pop.preferredContentSize = CGSizeMake(120, 80);
    
    // configure popover style & delegate
    UIPopoverPresentationController *popover =  pop.popoverPresentationController;
    popover.delegate = self;
    popover.sourceView = self.view;
    popover.sourceRect = CGRectMake(320,95,0,0);
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    // display the controller in the usual way
    [self presentViewController:pop animated:YES completion:nil];
    
}
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)pop
{
    return UIModalPresentationNone;
}
@end
