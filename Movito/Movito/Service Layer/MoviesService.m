//
//  MoviesService.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/1/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "MoviesService.h"
#import "JSONMovieParser.h"

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
        JSONMovieParser* parser = [JSONMovieParser new];
        for(int i = 0; i<moviesDictArray.count; i++)
        {
            [moviesArray addObject:[parser toMovieParseJSONDictionary:moviesDictArray[i]]];
            if([moviesDictArray[i] objectForKey:@"poster_path"] != nil)
            {
                printf("Service %s: \n", [[moviesDictArray[i] objectForKey:@"poster_path"] UTF8String]);
            }
        }
        
        [_moviePresenter onSuccess:moviesArray];
    }
}

-(void)handleFailWithErrorMessage:(NSString *)errorMessage
{
    [_moviePresenter onFail:errorMessage];
}

@end
