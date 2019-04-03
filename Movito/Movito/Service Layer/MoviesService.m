//
//  MoviesService.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "MoviesService.h"

@implementation MoviesService

-(void)getMovie:(id<IMoviePresenter>)moviePresenter
{
    _moviePresenter = moviePresenter;
    [NetworkManager connectGetToURL:@"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=07c9e79d1ef54c1c2f9b7cb371f51725" serviceName:@"MovieService" serviceProtocol:self];
}

-(void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName{
    if ([serviceName isEqualToString:@"MovieService"]) {
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSArray *moviesDictArray = [dict objectForKey:@"results"];
        NSMutableArray* moviesArray = [NSMutableArray new];
//        for(int i = 0; i<moviesDictArray.count; i++)
//        {
//            [moviesArray addObject:[[Movie alloc] initWithIdentifier:[moviesDictArray[i] objectForKey:@"id"] andPosterPath:[moviesDictArray[i] objectForKey:@"poster_path"] andOriginalTitle:[moviesDictArray[i] objectForKey:@"original_title"] andOverview:[moviesDictArray[i] objectForKey:@"identifier"] andVoteAverage:[moviesDictArray[i] objectForKey:@"vote_average"] andReleaseDate:[moviesDictArray[i] objectForKey:@"release_date"] andIsFavourite:[moviesDictArray[i] objectForKey:@"identifier"]]];
//        }
        
        [_moviePresenter onSuccess:moviesDictArray];
    }
}

-(void)handleFailWithErrorMessage:(NSString *)errorMessage
{
    [_moviePresenter onFail:errorMessage];
}

@end
