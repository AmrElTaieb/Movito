//
//  JSONMovieParser.m
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/5/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "JSONMovieParser.h"

@implementation JSONMovieParser

-(Movie*)toMovieParseJSONDictionary:(NSDictionary*)dictionary
{
    NSInteger identifier;
    //    NSString* posterPath;
    //    NSString* originalTitle;
    //    NSString* overview;
    double voteAverage;
    //    NSString* releaseDate;
    //    NSString* isFavourite;
    
    identifier = ([dictionary objectForKey:@"id"] == nil) ? -1:[[dictionary objectForKey:@"id"] integerValue];
    
    voteAverage = ([dictionary objectForKey:@"vote_average"] == nil) ? 11.0:[[dictionary objectForKey:@"vote_average"] doubleValue];
    
    Movie* movie = [[Movie alloc] initWithIdentifier: identifier andPosterPath:[dictionary objectForKey:@"poster_path"] andOriginalTitle:[dictionary objectForKey:@"original_title"] andOverview:[dictionary objectForKey:@"overview"] andVoteAverage:voteAverage andReleaseDate:[dictionary objectForKey:@"release_date"] andIsFavourite:@"notFavourite"];
    
    return movie;
}

-(Trailer*)toTrailerParseJSONDictionary:(NSDictionary*)dictionary ofMovie:(Movie*)movie
{
    Trailer* trailer = [[Trailer alloc] initWithIdentifier:[dictionary objectForKey:@"id"] andName:[dictionary objectForKey:@"name"] andKey:[dictionary objectForKey:@"key"] andMovieIdentifier:[movie identifier]];
    return trailer;
}

-(Review*)toReviewParseJSONDictionary:(NSDictionary*)dictionary ofMovie:(Movie*)movie
{
    Review* review = [[Review alloc] initWithIdentifier:[dictionary objectForKey:@"id"] andAuthor:[dictionary objectForKey:@"author"] andContent:[dictionary objectForKey:@"content"] andUrl:[dictionary objectForKey:@"url"] andMovieIdentifier:[movie identifier]];
    return review;
}

@end
