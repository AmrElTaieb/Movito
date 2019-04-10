//
//  AllCollectionViewController.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "AllCollectionViewController.h"
#import "FavouriteCollectionViewController.h"
#import "DetailsViewController.h"

@interface AllCollectionViewController ()

@property BOOL loadFlag;
@property BOOL favouritesFlag;

@end

@implementation AllCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _loadFlag = NO;
    _favouritesFlag = NO;
    MoviesPresenter *moviePresenter = [[MoviesPresenter alloc] initWithMovieView:self];
    [moviePresenter getMovie];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

//-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    if ([tabBarController.viewControllers indexOfObject:viewController] == 1 && _favouritesFlag)
//    {
//        MoviesPresenter *moviePresenter = [[MoviesPresenter alloc] initWithMovieView:self];
//        [moviePresenter updateFavouritesService];
//        printf("It's a profile\n");
//        return YES;
//    } else
//    {
//        if ([tabBarController.viewControllers indexOfObject:viewController] == 1)
//        {
//            _favouritesFlag = YES;
//        }
//        printf("It's %lu\n", [tabBarController.viewControllers indexOfObject:viewController]);
//        return YES;
//    }
//}

#pragma mark <IMovieCollectionView>

-(void)supplyMovieArrayWithObject:(NSArray *)movie
{
    _movies = movie;
}

-(void)showLoading
{
    printf("Show Loading\n");
}

-(void) hideLoading
{
    printf("hide Loading\n");
    _loadFlag = YES;
    Movie* tmpMovie = _movies[0];
    Trailer* tmpTrailer = tmpMovie.trailers[0];
    printf("Trailer: %s\n", [tmpTrailer.key UTF8String]);
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"all" forIndexPath:indexPath];
    // Configure the cell
    UILabel* myLabel = [cell viewWithTag:1];
    UIImageView* myImage = [cell viewWithTag:2];
    Movie* movie = _movies[indexPath.item];
    if(_loadFlag)
    {
//        printf("cellForItemAtIndexPath flag: YES\n");
        NSNumber *i = [NSNumber numberWithDouble:movie.voteAverage];
        [myLabel setText:[i stringValue]];
//        [myLabel setText:[[_movies[indexPath.item] objectForKey:@"vote_average"] stringValue]];
//        printf("cellForItemAtIndexPath label: %s\n", [[myLabel text] UTF8String]);
        
        NSMutableString* tmpStr = [[NSMutableString alloc] initWithString:@"https://image.tmdb.org/t/p/w600_and_h900_bestv2/"];
        //w185
//        printf("str did it?\n");
            [tmpStr appendString:movie.posterPath];
//        [tmpStr appendString:[_movies[indexPath.item] objectForKey:@"poster_path"]];
//        printf("img did it?\n");
        [myImage sd_setImageWithURL:[NSURL URLWithString:tmpStr] placeholderImage:[UIImage imageNamed:@"wait.png"]];
        
//        printf("cellForItemAtIndexPath string: %s\n", [tmpStr UTF8String]);
    }
    
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
 ThirdViewController* tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"thirdViewController"];
 tvc.hidesBottomBarWhenPushed = YES;
 [self.navigationController pushViewController:tvc animated:YES];
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
