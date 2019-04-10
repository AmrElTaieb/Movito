//
//  DetailsViewController.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/10/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <HCSStarRatingView.h>
#import "MovieContract.h"
#import "MovieDetailsPresenter.h"

@interface DetailsViewController : UITableViewController <IMovieView>

@property Movie* movie;

@end
