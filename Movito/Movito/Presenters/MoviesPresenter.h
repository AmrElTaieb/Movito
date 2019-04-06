//
//  MoviePresenter.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieContract.h"
#import "MoviesService.h"


@interface MoviesPresenter : NSObject <IMoviesPresenter>

@property id<IMovieCollectionView> movieCollectionView;

-(instancetype) initWithMovieView : (id<IMovieCollectionView>) movieCollectionView;

@end
