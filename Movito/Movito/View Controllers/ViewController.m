//
//  ViewController.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 3/30/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self renderMovieDataToView];
}

-(void) renderMovieDataToView
{
    [self setStars];
    [self setGesture];
    
    NSMutableString* tmpStr = [[NSMutableString alloc] initWithString:@"https://image.tmdb.org/t/p/w600_and_h900_bestv2/"];
    //w185
    [tmpStr appendString:[_movie posterPath]];
    [_moviePosterImage sd_setImageWithURL:[NSURL URLWithString:tmpStr] placeholderImage:[UIImage imageNamed:@"wait.png"]];
    
    NSNumber *tmpNum = [NSNumber numberWithDouble:[_movie voteAverage]];
    [_movieRatingLabel setText:[tmpNum stringValue]];
    
    UIImage* tmpImg = [UIImage imageNamed:[_movie isFavourite]];
    [_isFavouriteImage setImage:tmpImg];
    
    [_movieTitleLabel setText:[_movie originalTitle]];
    [_movieDateLabel setText:[_movie releaseDate]];
    [_movieOverviewText setText:[_movie overview]];
}

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

-(void)setStars
{
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:[_movieRatingLabel frame]];
    starRatingView.allowsHalfStars = YES;
    starRatingView.accurateHalfStars = YES;
    starRatingView.maximumValue = 10;
    starRatingView.minimumValue = 0;
    starRatingView.value = [_movie voteAverage];
    starRatingView.tintColor = [UIColor blueColor];
    starRatingView.userInteractionEnabled = NO;
//    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:starRatingView];
}
    
-(void)setGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [_isFavouriteImage setUserInteractionEnabled:YES];
    [_isFavouriteImage addGestureRecognizer:singleTap];
}

-(void) tapDetected
{
    MovieDetailsPresenter* presenter = [[MovieDetailsPresenter alloc] initWithMovieView:self];
    [presenter toggleFavourites:_movie];
    printf("image tapped\n");
}

-(void) rebindFavouriteStatus : (Movie*) movie
{
    _movie = movie;
    UIImage* tmpImg = [UIImage imageNamed:[_movie isFavourite]];
    [_isFavouriteImage setImage:tmpImg];
}

//- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
//    UIGraphicsBeginImageContext(size);
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return destImage;
//}

@end
