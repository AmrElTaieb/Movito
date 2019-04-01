//
//  MoviePresenter.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "MoviePresenter.h"

@implementation MoviePresenter

-(instancetype)initWithMovieView:(id<IMovieView>)movieView
{
    self = [super init];
    if (self) {
        _movieView = movieView;
    }
    return self;
}

-(void)getMovie
{
    [_movieView showLoading];
    MoviesService *movieService = [MoviesService new];
    [movieService getMovie:self];
}

-(void)onSuccess:(Movie *)movie
{
    [_movieView renderMovieWithObject:movie];
    [_movieView hideLoading];
}

- (void)onFail:(NSString *)errorMessage
{
    [_movieView showErrorMessage:errorMessage];
    [_movieView hideLoading];
}

@end
