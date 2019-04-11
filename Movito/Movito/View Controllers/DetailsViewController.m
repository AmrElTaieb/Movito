//
//  DetailsViewController.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/10/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "DetailsViewController.h"
#import "../POJO/Trailer.h"
#import "../POJO/Review.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
}

#pragma mark - custom methods

//-(void) renderMovieDataToView
//{
//    //
//}

-(void) showLoading
{
    //
}

-(void) hideLoading
{
    //
}

-(void) showErrorMessage : (NSString*) errorMessage
{
    //
}

//-(void)setStars
//{
//    //
//}

//-(void)setGesture
//{
//    //
//}

-(void) tapDetected
{
    MovieDetailsPresenter* presenter = [[MovieDetailsPresenter alloc] initWithMovieView:self];
    [presenter toggleFavourites:_movie];
    printf("image tapped\n");
}

-(void) rebindFavouriteStatus : (Movie*) movie
{
    _movie = movie;
//    UIImage* tmpImg = [UIImage imageNamed:[_movie isFavourite]];
//    [_isFavouriteImage setImage:tmpImg];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger i = 1 + _movie.trailers.count + _movie.reviews.count;
    return i;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"details" forIndexPath:indexPath];
//        [cell setUserInteractionEnabled:NO];
        
        UILabel* movieRatingLabel = [cell viewWithTag:9];
        HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:[movieRatingLabel frame]];
        starRatingView.allowsHalfStars = YES;
        starRatingView.accurateHalfStars = YES;
        starRatingView.maximumValue = 10;
        starRatingView.minimumValue = 0;
        starRatingView.value = [_movie voteAverage];
        starRatingView.tintColor = [UIColor blueColor];
        starRatingView.userInteractionEnabled = NO;
        //    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:starRatingView];
        
        UIImageView* isFavouriteImage = [cell viewWithTag:8];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
        singleTap.numberOfTapsRequired = 1;
        [isFavouriteImage setUserInteractionEnabled:YES];
        [isFavouriteImage addGestureRecognizer:singleTap];
        UIImage* tmpImg = [UIImage imageNamed:[_movie isFavourite]];
        [isFavouriteImage setImage:tmpImg];
        
        UIImageView* moviePosterImage = [cell viewWithTag:6];
        NSMutableString* tmpStr = [[NSMutableString alloc] initWithString:@"https://image.tmdb.org/t/p/w600_and_h900_bestv2/"];
        //w185
        [tmpStr appendString:[_movie posterPath]];
        [moviePosterImage sd_setImageWithURL:[NSURL URLWithString:tmpStr] placeholderImage:[UIImage imageNamed:@"wait.png"]];
        
        UILabel* movieTitleLabel = [cell viewWithTag:5];
        [movieTitleLabel setText:[_movie originalTitle]];
        
        UILabel* movieDateLabel = [cell viewWithTag:7];
        [movieDateLabel setText:[_movie releaseDate]];
        
        UITextView* movieOverviewText = [cell viewWithTag:10];
        [movieOverviewText setText:[_movie overview]];
        
    } else if (_movie.trailers.count > 0)
    {
        if (indexPath.row < (1 + _movie.trailers.count))
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"trailer" forIndexPath:indexPath];
            UITextView* movieTrailerText = [cell viewWithTag:4];
            Trailer* trailer = _movie.trailers[indexPath.row - 1];
            [movieTrailerText setText:[trailer name]];
            [movieTrailerText setUserInteractionEnabled:NO];
            
            UIImageView* playImage = [cell viewWithTag:3];
            UIImage* tmpImg = [UIImage imageNamed:@"play"];
            [playImage setImage:tmpImg];
            
            printf("trailer: %s\n", [[trailer name] UTF8String]);
        } else
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"review" forIndexPath:indexPath];
            [cell setUserInteractionEnabled:NO];
            
            UITextView* movieReviewText = [cell viewWithTag:1];
            Review* review = _movie.reviews[indexPath.row - _movie.trailers.count - 1];
            [movieReviewText setText:[review content]];
            [movieReviewText setUserInteractionEnabled:NO];
            
            UILabel* movieReviewLabel = [cell viewWithTag:2];
            [movieReviewLabel setText:[review author]];
            
            printf("reviews: %s\n", [[review author] UTF8String]);
        }
    } else if (_movie.reviews.count > 0)
    {
//        if (indexPath.row < (1 + _movie.trailers.count + _movie.reviews.count))
//        {
//            printf("reviews..\n");
//        } else
//        {
//            printf("reviews..\n");
//        }
        cell = [tableView dequeueReusableCellWithIdentifier:@"review" forIndexPath:indexPath];
        [cell setUserInteractionEnabled:NO];
        
        UITextView* movieReviewText = [cell viewWithTag:1];
        Review* review = _movie.reviews[indexPath.row - _movie.trailers.count - 1];
        [movieReviewText setText:[review content]];
        [movieReviewText setUserInteractionEnabled:NO];
        
        UILabel* movieReviewLabel = [cell viewWithTag:2];
        [movieReviewLabel setText:[review author]];
        
        printf("reviews: %s\n", [[review author] UTF8String]);
    } else
    {
        printf("reviews..\n");
        cell = [tableView dequeueReusableCellWithIdentifier:@"review" forIndexPath:indexPath];
    }
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 554.0;
    }
    if (_movie.trailers.count > 0)
    {
        if (indexPath.row < (1 + _movie.trailers.count))
        {
            return 80.0;
        } else
        {
            return 300.0;
        }
    } else if (_movie.reviews.count > 0)
    {
        if (indexPath.row < (1 + _movie.trailers.count + _movie.reviews.count))
        {
            return 300.0;
        } else
        {
            return 80.0;
        }
    }
    return 80.0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 550.0;
    }
    if (_movie.trailers.count > 0)
    {
        if (indexPath.row < (1 + _movie.trailers.count))
        {
            return 90.0;
        } else
        {
            return 300.0;
        }
    } else if (_movie.reviews.count > 0)
    {
        if (indexPath.row < (1 + _movie.trailers.count + _movie.reviews.count))
        {
            return 300.0;
        } else
        {
            return 90.0;
        }
    }
    return 90.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_movie.trailers.count > 0)
    {
        if (indexPath.row < (1 + _movie.trailers.count) &&
            indexPath.row > 0)
        {
            Trailer* trailer = _movie.trailers[indexPath.row-1];
            NSString* tmpStr = [NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@",trailer.key];
            printf("%s\n", [tmpStr UTF8String]);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tmpStr] options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    printf("trailer on youtube\n");
                }
            }];
        }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
