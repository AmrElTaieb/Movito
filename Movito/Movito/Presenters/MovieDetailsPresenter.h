//
//  MovieDetailsPresenter.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/6/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoviesService.h"
#import "../POJO/Movie.h"
#import "../MVP Movies/MovieContract.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailsPresenter : NSObject <IMovieDetailsPresenter>

@property id<IMovieView> movieView;

-(instancetype) initWithMovieView : (id<IMovieView>) movieView;

@end

NS_ASSUME_NONNULL_END
