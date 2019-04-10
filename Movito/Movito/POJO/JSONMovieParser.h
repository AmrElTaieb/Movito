//
//  JSONMovieParser.h
//  Movito
//
//  Created by Amr Mohamed Koritem on 4/5/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "Trailer.h"
#import "Review.h"

@interface JSONMovieParser : NSObject

-(Movie*)toMovieParseJSONDictionary:(NSDictionary*)dictionary;
-(Trailer*)toTrailerParseJSONDictionary:(NSDictionary*)dictionary ofMovie:(Movie*)movie;
-(Review*)toReviewParseJSONDictionary:(NSDictionary*)dictionary ofMovie:(Movie*)movie;

@end

