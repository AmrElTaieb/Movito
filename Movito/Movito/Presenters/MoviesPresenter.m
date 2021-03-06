//
//  MoviePresenter.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "MoviesPresenter.h"

@implementation MoviesPresenter

-(instancetype)initWithMovieView:(id<IMovieCollectionView>)movieCollectionView
{
    self = [super init];
    if (self) {
        _movieCollectionView = movieCollectionView;
    }
    return self;
}

-(void)getMovie:(BOOL)isByPopularity
{
    [_movieCollectionView showLoading];
    MoviesService *movieService = [MoviesService new];
    movieService.isByPopularity = isByPopularity;
    [movieService getMovie:self];
}

//-(void) getTrailers: (Movie*) movie
//{
//    TrailersService *trailerService = [TrailersService new];
//    [trailerService getTrailer:movie];
//}

-(void)onSuccess:(NSArray *)movie
{
    [_movieCollectionView supplyMovieArrayWithObject:movie];
    [_movieCollectionView hideLoading];
}

- (void)onFail:(NSString *)errorMessage
{
    [_movieCollectionView showErrorMessage:errorMessage];
    [_movieCollectionView hideLoading];
}

//-(void) updateFavouritesService
//{
//    MoviesService *movieService = [MoviesService new];
//    [movieService updateFavouritesPresenter];
//}

@end
