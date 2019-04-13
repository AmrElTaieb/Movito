//
//  AllCollectionViewController.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MovieContract.h"
#import "MoviesPresenter.h"
#import "../POJO/Review.h"

@interface AllCollectionViewController : UICollectionViewController <IMovieCollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property NSArray* movies;

@end

