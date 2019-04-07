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
    [self setGesture];
    [self renderMovieDataToView];
}

-(void) renderMovieDataToView
{
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

-(void)setGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [_isFavouriteImage setUserInteractionEnabled:YES];
    [_isFavouriteImage addGestureRecognizer:singleTap];
}

-(void) tapDetected
{
    if([[_movie isFavourite] isEqualToString:@"notFavourite"])
    {
        _movie.isFavourite = @"favourite";
    } else
    {
        _movie.isFavourite = @"notFavourite";
    }
    UIImage* tmpImg = [UIImage imageNamed:[_movie isFavourite]];
    [_isFavouriteImage setImage:tmpImg];
    printf("image tapped\n");
}

//- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
//    UIGraphicsBeginImageContext(size);
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return destImage;
//}

@end
