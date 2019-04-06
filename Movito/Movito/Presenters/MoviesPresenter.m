//
//  MoviePresenter.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "MoviesPresenter.h"
#import "ViewController.h"

@implementation MoviesPresenter

-(instancetype)initWithMovieView:(id<IMovieCollectionView>)movieCollectionView
{
    self = [super init];
    if (self) {
        _movieCollectionView = movieCollectionView;
    }
    return self;
}

-(void)getMovie
{
    [_movieCollectionView showLoading];
    MoviesService *movieService = [MoviesService new];
    [movieService getMovie:self];
}

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

@end
