//
//  FavouriteCollectionViewController.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/7/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "FavouriteCollectionViewController.h"
#import "DetailsViewController.h"
#import "../Presenters/FavouritesPresenter.h"
#import "../POJO/Trailer.h"

@interface FavouriteCollectionViewController ()

@end

@implementation FavouriteCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    FavouritesPresenter *favouritePresenter = [[FavouritesPresenter alloc] initWithMovieView:self];
    [favouritePresenter getFavourite];
    [self.collectionView reloadData];
    printf("View: viewWillAppear\n");
}

#pragma mark <IMovieCollectionView>

//-(void) reloadView
//{
//    FavouritesPresenter *favouritePresenter = [[FavouritesPresenter alloc] initWithMovieView:self];
//    [favouritePresenter getFavourite];
//    [self.collectionView reloadData];
//    printf("View Reloaded\n");
//}

-(void)supplyMovieArrayWithObject:(NSArray *)movies
{
    _movies = movies;
    if(movies.count>0)
    {
        Movie* movie = movies[0];
        if(movie.trailers.count > 0)
        {
            Trailer* tmpTrailer = movie.trailers[0];
            printf("Favourites trailer %s\n", [tmpTrailer.key UTF8String]);
        }
    }
}
    
-(void)showLoading
{
    printf("Show Loading\n");
}
    
-(void) hideLoading
{
    printf("hide Loading\n");
    [self.collectionView reloadData];
}
    
-(void)showErrorMessage:(NSString *)errorMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
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
    
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
    
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_movies count];
}
    
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fav" forIndexPath:indexPath];
    
    //    if(cell == nil)
    //    {
    //        cell = [[UICollectionView alloc] in];
    //    }
    
    // Configure the cell
    UILabel* myLabel = [cell viewWithTag:1];
    UIImageView* myImage = [cell viewWithTag:2];
    Movie* movie = _movies[indexPath.item];
    
    NSNumber *i = [NSNumber numberWithDouble:movie.voteAverage];
    [myLabel setText:[i stringValue]];
    
    NSMutableString* tmpStr = [[NSMutableString alloc] initWithString:@"https://image.tmdb.org/t/p/w600_and_h900_bestv2/"];
    //w185
    [tmpStr appendString:movie.posterPath];
    
    [myImage sd_setImageWithURL:[NSURL URLWithString:tmpStr] placeholderImage:[UIImage imageNamed:@"wait.png"]];
    
    return cell;
}
    
#pragma mark <UICollectionViewDelegate>
    
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController* dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsViewController"];
    dvc.movie = _movies[indexPath.item];
    dvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dvc animated:YES];
}
    
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
