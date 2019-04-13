//
//  MoviesService.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "MoviesService.h"
#import "JSONMovieParser.h"
#import "../Network Layer/Reachability.h"
//#import <AFNetworking.h>
#import "../DataBase/DatabaseAdapter.h"

@implementation MoviesService

-(void)getMovie:(id<IMoviesPresenter>)moviePresenter
{
    _moviesPresenter = moviePresenter;
    _counter = 0;
    _serviceName = @"MovieService";
    if(_isByPopularity)
    {
        printf("Service: YES\n");
    } else
    {
        printf("Service: NO\n");
    }
    [self checkForNetwork];
}

-(void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"MovieService"])
    {
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSArray *moviesDictArray = [dict objectForKey:@"results"];
        NSMutableArray* moviesArray = [NSMutableArray new];
        JSONMovieParser* parser = [JSONMovieParser new];
//        DatabaseAdapter* db = [DatabaseAdapter sharedInstance];
//        [db createMoviesTable];
//        [db emptyMoviesTable];
        for(int i = 0; i<moviesDictArray.count; i++)
        {
            [moviesArray addObject:[parser toMovieParseJSONDictionary:moviesDictArray[i]]];
//            [db insertInMoviesTableIdentifier:moviesArray[i]];
            _moviesArray = moviesArray;
        }
        [self loadMoviesFromDatabase];
    } else if ([serviceName isEqualToString:@"TrailerService"])
    {
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSArray *trailersDictArray = [dict objectForKey:@"results"];
        NSMutableArray* trailersArray = [NSMutableArray new];
        JSONMovieParser* parser = [JSONMovieParser new];
        for(int i = 0; i<trailersDictArray.count; i++)
        {
            [trailersArray addObject:[parser toTrailerParseJSONDictionary:trailersDictArray[i] ofMovie:_movie]];
        }
        [_movie setTrailers:trailersArray];
        _counter++;
        if (_counter<_moviesArray.count)
        {
            _movie = _moviesArray[_counter];
            [self checkForNetwork];
        } else
        {
            _counter = 0;
            _serviceName = @"ReviewService";
            _movie = _moviesArray[_counter];
            [self checkForNetwork];
        }
    } else if ([serviceName isEqualToString:@"ReviewService"])
    {
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSArray *reviewsDictArray = [dict objectForKey:@"results"];
        NSMutableArray* reviewsArray = [NSMutableArray new];
        JSONMovieParser* parser = [JSONMovieParser new];
        for(int i = 0; i<reviewsDictArray.count; i++)
        {
            [reviewsArray addObject:[parser toReviewParseJSONDictionary:reviewsDictArray[i] ofMovie:_movie]];
        }
        [_movie setReviews:reviewsArray];
        _counter++;
        if (_counter<_moviesArray.count)
        {
            _movie = _moviesArray[_counter];
            [self checkForNetwork];
        } else
        {
            [_moviesPresenter onSuccess:_moviesArray];
        }
    }
}

-(void) toggleFavouriteStatus : (Movie*) movie forDetailsPresenter : (id<IMovieDetailsPresenter>) movieDetailsPresenter
{
    _movieDetailsPresenter = movieDetailsPresenter;
    DatabaseAdapter* db = [DatabaseAdapter sharedInstance];
    [db createMoviesTable];
    [db createFavouritesTable];
    [db createTrailersTable];
    [db createReviewsTable];
    if([[movie isFavourite] isEqualToString:@"notFavourite"])
    {
        movie.isFavourite = @"favourite";
        [db insertInFavouritesTableIdentifier:movie];
        NSArray* trailersArray = movie.trailers;
        for(int i = 0; i<trailersArray.count; i++)
        {
            [db insertInTrailersTableIdentifier:trailersArray[i]];
        }
        NSArray* reviewsArray = movie.reviews;
        for(int i = 0; i<reviewsArray.count; i++)
        {
            [db insertInReviewsTableIdentifier:reviewsArray[i]];
        }
    } else
    {
        movie.isFavourite = @"notFavourite";
        NSString* tmpStr = [NSString stringWithFormat:@"%ld",[movie identifier]];
        [db deleteFromFavouritesTable:tmpStr];
        NSArray* trailersArray = movie.trailers;
        for(int i = 0; i<trailersArray.count; i++)
        {
            Trailer* trailer = trailersArray[i];
            [db deleteFromTrailersTable:trailer.identifier];
        }
        NSArray* reviewsArray = movie.reviews;
        for(int i = 0; i<reviewsArray.count; i++)
        {
            Review* review = reviewsArray[i];
            [db deleteFromTrailersTable:review.identifier];
        }
    }
    [db updateMoviesTableIdentifier:movie];
    [_movieDetailsPresenter sendMovieToView:movie];
}

-(void)loadMoviesFromDatabase
{
    DatabaseAdapter* db = [DatabaseAdapter sharedInstance];
//    [db createMoviesTable];
    [db createFavouritesTable];
//    NSArray* moviesArray = [db selectMoviesTable];
    NSArray* favouritesArray = [db selectFavouritesTable];
    for (int i = 0; i<favouritesArray.count; i++) {
        for (int j = 0; j<_moviesArray.count; j++) {
            Movie* favMovie = favouritesArray[i];
            Movie* movie = _moviesArray[j];
            if(favMovie.identifier == movie.identifier)
            {
                movie.isFavourite = @"favourite";
            }
        }
    }
    _serviceName = @"TrailerService";
//    _moviesArray = moviesArray;
    _movie = _moviesArray[_counter];
    [self checkForNetwork];
    printf("Service: loadMoviesFromDatabase\n");
}

-(void)loadFavouritesFromDatabase:(id<IFavouritesPresenter>)favouritesPresenter
{
    _favouritesPresenter = favouritesPresenter;
    DatabaseAdapter* db = [DatabaseAdapter sharedInstance];
    [db createFavouritesTable];
    NSArray* favouritesArray = [db selectFavouritesTable];
    for(int i = 0; i<favouritesArray.count; i++)
    {
        Movie* tmpMovie = favouritesArray[i];
        NSArray* trailersArray = [db selectTrailersTableWithIdentifier:[tmpMovie identifier]];
        tmpMovie.trailers = trailersArray;
        NSArray* reviewsArray = [db selectReviewsTableWithIdentifier:[tmpMovie identifier]];
        tmpMovie.reviews = reviewsArray;
    }
    [_favouritesPresenter sendMovieToView:favouritesArray];
    printf("Service: loadFavouritesFromDatabase\n");
}

-(void)handleFailWithErrorMessage:(NSString *)errorMessage
{
    [_moviesPresenter onFail:errorMessage];
}

- (void)checkForNetwork
{
    // check if we've got network connectivity
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"themoviedb.org"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
//    printf("Service: %s\n", [_serviceName UTF8String]);
    NSString* tmpStr;
    if ([_serviceName isEqualToString:@"MovieService"])
    {
        if (_isByPopularity) {
            tmpStr = @"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=07c9e79d1ef54c1c2f9b7cb371f51725";
            printf("check: popularity\n");
        } else
        {
            tmpStr = @"https://api.themoviedb.org/3/discover/movie?sort_by=vote_average.desc&api_key=07c9e79d1ef54c1c2f9b7cb371f51725";
            printf("check: vote_average\n");
        }
    } else if ([_serviceName isEqualToString:@"TrailerService"])
    {
        tmpStr = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%ld/videos?api_key=07c9e79d1ef54c1c2f9b7cb371f51725", (long)[_movie identifier]];
    } else if ([_serviceName isEqualToString:@"ReviewService"])
    {
        tmpStr = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%ld/reviews?api_key=07c9e79d1ef54c1c2f9b7cb371f51725&language=en-US&page=1", (long)[_movie identifier]];
    }
    [NetworkManager connectGetToURL:tmpStr serviceName:_serviceName serviceProtocol:self];
//    switch (myStatus) {
//        case NotReachable:
//            printf("There's no internet connection at all. Getting data from database..\n");
//            [self loadMoviesFromDatabase];
//            break;
//
//        case ReachableViaWWAN:
//            printf("We have a 3G connection\n");
//            break;
//
//        case ReachableViaWiFi:
//            printf("We have WiFi\n");
//            [NetworkManager connectGetToURL:tmpStr serviceName:_serviceName serviceProtocol:self];
//            break;
//
//        default:
//            break;
//    }
}

@end
