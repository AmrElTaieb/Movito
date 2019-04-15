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
#import "PFNavigationDropdownMenu.h"

@interface AllCollectionViewController ()

@property BOOL loadFlag;
@property BOOL navFlag;
@property CGFloat width;

@end

@implementation AllCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _loadFlag = NO;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.    
    NSArray* items = @[@"Popular Movies", @" Most Rated Movies"];
    PFNavigationDropdownMenu *menuView = [[PFNavigationDropdownMenu alloc]initWithFrame:CGRectMake(0, 0, 300, 44)title:items.firstObject items:items containerView:self.view];
    [menuView setArrowImage:[UIImage imageNamed:@"arrow"]];
    
    menuView.didSelectItemAtIndexHandler = ^(NSUInteger indexPath){
        NSLog(@"Did select item at index: %ld", indexPath);
        self.title = items[indexPath];
//        [self.parentViewController viewWillAppear:NO];
        MoviesPresenter *moviePresenter = [[MoviesPresenter alloc] initWithMovieView:self];
        if (indexPath == 0)
        {
            self->_navFlag = NO;
            self->_movies = nil;
            [self.collectionView reloadData];
            [moviePresenter getMovie:!self->_navFlag];
        } else
        {
            self->_navFlag = YES;
            self->_movies = nil;
            [self.collectionView reloadData];
            [moviePresenter getMovie:!self->_navFlag];
        }
        printf("navigation drop down\n");
        
        [self.collectionView reloadData];
    };
    self.navigationItem.titleView = menuView;
    
//    self.navigationItem.title = @"All Movies";
}

- (void)viewWillAppear:(BOOL)animated
{
    printf("viewWillAppear\n");
    
    [super viewWillAppear:animated];
    
    _width = CGRectGetWidth(self.collectionView.frame)/2;
    
    MoviesPresenter *moviePresenter = [[MoviesPresenter alloc] initWithMovieView:self];
    [moviePresenter getMovie:!_navFlag];
    
    [self.collectionView reloadData];
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
    printf("%s\n", [tmpMovie.originalTitle UTF8String]);
//    if(tmpMovie.reviews.count > 0)
//    {
//        Review* tmpReview = tmpMovie.reviews[0];
//        printf("Review: %s\n", [tmpReview.author UTF8String]);
//    }
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
    UIImageView* myImage = [cell viewWithTag:2];
    Movie* movie = _movies[indexPath.item];
//    printf("title: %s\n", [movie.originalTitle UTF8String]);
    if(_loadFlag)
    {        
        NSMutableString* tmpStr = [[NSMutableString alloc] initWithString:@"https://image.tmdb.org/t/p/w600_and_h900_bestv2/"];
        //w185
//        printf("str did it?\n");
        if (movie.posterPath != nil && movie.posterPath != (id)[NSNull null])
        {
//            printf("not null\n");
            [tmpStr appendString:movie.posterPath];
        }
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_width, _width*1.2);
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
