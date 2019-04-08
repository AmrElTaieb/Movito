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
    [self checkForNetwork];
}

-(void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName{
    if ([serviceName isEqualToString:@"MovieService"]) {
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSArray *moviesDictArray = [dict objectForKey:@"results"];
        NSMutableArray* moviesArray = [NSMutableArray new];
        JSONMovieParser* parser = [JSONMovieParser new];
        DatabaseAdapter* db = [DatabaseAdapter sharedInstance];
        [db createMoviesTable];
        [db emptyMoviesTable];
        for(int i = 0; i<moviesDictArray.count; i++)
        {
            [moviesArray addObject:[parser toMovieParseJSONDictionary:moviesDictArray[i]]];
            [db insertInMoviesTableIdentifier:moviesArray[i]];
            if([moviesDictArray[i] objectForKey:@"poster_path"] == nil ||  [moviesDictArray[i] objectForKey:@"poster_path"] == (id)[NSNull null])
            {
                printf("Service: Null\n");
            } else
            {
                printf("Service: %s\n", [[moviesDictArray[i] objectForKey:@"poster_path"] UTF8String]);
            }
        }
        
//        [_moviesPresenter onSuccess:moviesArray];
        [self loadMoviesFromDatabase];
    }
}

//-(void) updateFavouritesPresenter
//{
//    printf("Service: updateFavouritesPresenter\n");
//    [_favouritesPresenter updateFavouritesView];
//}

-(void) toggleFavouriteStatus : (Movie*) movie forDetailsPresenter : (id<IMovieDetailsPresenter>) movieDetailsPresenter
{
    _movieDetailsPresenter = movieDetailsPresenter;
    DatabaseAdapter* db = [DatabaseAdapter sharedInstance];
    [db createMoviesTable];
    [db createFavouritesTable];
    if([[movie isFavourite] isEqualToString:@"notFavourite"])
    {
        movie.isFavourite = @"favourite";
        [db insertInFavouritesTableIdentifier:movie];
    } else
    {
        movie.isFavourite = @"notFavourite";
        NSString* tmpStr = [NSString stringWithFormat:@"%ld",[movie identifier]];
        [db deleteFromFavouritesTable:tmpStr];
    }
    [db updateMoviesTableIdentifier:movie];
    [_movieDetailsPresenter sendMovieToView:movie];
}

-(void)loadMoviesFromDatabase
{
    DatabaseAdapter* db = [DatabaseAdapter sharedInstance];
    [db createMoviesTable];
    NSArray* moviesArray = [db selectMoviesTable];
    [_moviesPresenter onSuccess:moviesArray];
    printf("Service: loadMoviesFromDatabase\n");
}
    
-(void)loadFavouritesFromDatabase:(id<IFavouritesPresenter>)favouritesPresenter
{
    _favouritesPresenter = favouritesPresenter;
    DatabaseAdapter* db = [DatabaseAdapter sharedInstance];
    [db createFavouritesTable];
    NSArray* favouritesArray = [db selectFavouritesTable];
//    for(int i = 0; i<favouritesArray.count; i++)
//    {
//        Movie* tmpMovie = favouritesArray[i];
//        if([tmpMovie.isFavourite isEqualToString:@"notFavourite"])
//        {
//            [favouritesArray removeObjectAtIndex:i];
////            printf("notFavourite: %s\n", [tmpMovie.originalTitle UTF8String]);
//            i--;
//        }
//    }
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

    switch (myStatus) {
        case NotReachable:
            printf("There's no internet connection at all. Getting data from database..\n");
            [self loadMoviesFromDatabase];
            break;

        case ReachableViaWWAN:
            printf("We have a 3G connection\n");
            break;

        case ReachableViaWiFi:
            printf("We have WiFi\n");
            [NetworkManager connectGetToURL:@"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=07c9e79d1ef54c1c2f9b7cb371f51725" serviceName:@"MovieService" serviceProtocol:self];
            break;

        default:
            break;
    }
//    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
//    [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                printf("We have a 3G connection\n");
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                printf("We have WiFi\n");
//                [NetworkManager connectGetToURL:@"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=07c9e79d1ef54c1c2f9b7cb371f51725" serviceName:@"MovieService" serviceProtocol:self];
//                break;
//            case AFNetworkReachabilityStatusUnknown:
//                printf("Connection status unknown. Getting data from database..\n");
//                [self loadFromDatabase];
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                printf("There's no internet connection at all. Getting data from database..\n");
//                [self loadFromDatabase];
//                break;
//            default:
//                printf("Hopa\n");
//                break;
//        }
//    }];
}

@end
