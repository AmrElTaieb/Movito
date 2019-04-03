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
    [NetworkManager connectGetToURL:@"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=07c9e79d1ef54c1c2f9b7cb371f51725" serviceName:@"ContactService" serviceProtocol:self];
}

-(void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName{
    if ([serviceName isEqualToString:@"ContactService"]) {
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSArray *contactsArray = [dict objectForKey:@"results"];
        
        NSDictionary *contactDict = contactsArray[0];
        
        Movie *movie = [Movie new];
        [movie setTitle:[contactDict objectForKey:@"title"]];
        
        [_moviePresenter onSuccess:contactsArray];
    }
}

-(void)handleFailWithErrorMessage:(NSString *)errorMessage
{
    [_moviePresenter onFail:errorMessage];
}

@end
