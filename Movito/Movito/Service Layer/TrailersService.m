//
//  TrailersService.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/9/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "TrailersService.h"
#import "JSONMovieParser.h"
#import "../Network Layer/Reachability.h"
#import "../DataBase/DatabaseAdapter.h"

@implementation TrailersService

-(void) getTrailer : (Movie*) movie
{
    _movie = movie;
    [self checkForNetwork];
}

-(void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName{
    if ([serviceName isEqualToString:@"TrailerService"]) {
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSArray *trailersDictArray = [dict objectForKey:@"results"];
        NSMutableArray* trailersArray = [NSMutableArray new];
        JSONMovieParser* parser = [JSONMovieParser new];
        DatabaseAdapter* db = [DatabaseAdapter sharedInstance];
//        [db createMoviesTable];
//        [db emptyMoviesTable];
        for(int i = 0; i<trailersDictArray.count; i++)
        {
            [trailersArray addObject:[parser toTrailerParseJSONDictionary:trailersDictArray[i] ofMovie:_movie]];
//            [db insertInMoviesTableIdentifier:trailersArray[i]];
            //
        }
//        [self loadMoviesFromDatabase];
    }
}

-(void) handleFailWithErrorMessage : (NSString*) errorMessage
{
//    [_moviesPresenter onFail:errorMessage];
}

-(void)loadTrailersFromDatabase
{
    DatabaseAdapter* db = [DatabaseAdapter sharedInstance];
//    [db createMoviesTable];
//    NSArray* moviesArray = [db selectMoviesTable];
//    [_moviesPresenter onSuccess:moviesArray];
    printf("Service: loadMoviesFromDatabase\n");
}

- (void)checkForNetwork
{
    // check if we've got network connectivity
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"themoviedb.org"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    NSString* tmpStr = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%ld/videos?api_key=07c9e79d1ef54c1c2f9b7cb371f51725", (long)[_movie identifier]];
    switch (myStatus) {
        case NotReachable:
            printf("There's no internet connection at all. Getting data from database..\n");
//            [self loadMoviesFromDatabase];
            break;
            
        case ReachableViaWWAN:
            printf("We have a 3G connection\n");
            break;
            
        case ReachableViaWiFi:
            printf("We have WiFi\n");
            [NetworkManager connectGetToURL:tmpStr serviceName:@"TrailerService" serviceProtocol:self];
            break;
            
        default:
            break;
    }
}

@end
