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
    [NetworkManager connectGetToURL:@"https://api.androidhive.info/contacts/" serviceName:@"ContactService" serviceProtocol:self];
}

-(void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName{
    if ([serviceName isEqualToString:@"ContactService"]) {
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSArray *contactsArray = [dict objectForKey:@"contacts"];
        
        NSDictionary *contactDict = contactsArray[0];
        
        Movie *movie = [Movie new];
        [movie setName:[contactDict objectForKey:@"name"]];
        [movie setEmail:[contactDict objectForKey:@"email"]];
        
        [_moviePresenter onSuccess:movie];
    }
}

-(void)handleFailWithErrorMessage:(NSString *)errorMessage
{
    [_moviePresenter onFail:errorMessage];
}

@end
