//
//  MovieDetailsPresenter.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/6/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "MovieDetailsPresenter.h"

@implementation MovieDetailsPresenter

-(instancetype)initWithMovieView:(id<IMovieView>)movieView
{
    self = [super init];
    if (self) {
        _movieView = movieView;
    }
    return self;
}

-(void) toggleFavourites : (Movie*) movie
{
    MoviesService *movieService = [MoviesService new];
    [movieService toggleFavouriteStatus:movie forDetailsPresenter:self];
}

-(void) sendMovieToView : (Movie*) movie
{
    [_movieView rebindFavouriteStatus:movie];
}

@end
