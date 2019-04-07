//
//  ViewController.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 3/30/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <HCSStarRatingView.h>
#import "MovieContract.h"
#import "MovieDetailsPresenter.h"

@interface ViewController : UIViewController <IMovieView>
@property (weak, nonatomic) IBOutlet UIImageView *isFavouriteImage;

@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRatingLabel;
@property (weak, nonatomic) IBOutlet UITextView *movieOverviewText;
@property Movie* movie;

@end

