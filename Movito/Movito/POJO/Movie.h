// To parse this JSON:
//
//   NSError *error;
//   Movie * = [Movie fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class Movie;
@class MovieGenre;
@class MovieProductionCompany;
@class MovieProductionCountry;
@class MovieSpokenLanguage;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface Movie : NSObject
@property (nonatomic, strong)         NSArray *trailers;
@property (nonatomic, strong)         NSArray *reviews;
@property (nonatomic, copy)           NSString *isFavourite;
@property (nonatomic, assign)         BOOL isAdult;
@property (nonatomic, copy)           NSString *backdropPath;
@property (nonatomic, nullable, copy) id belongsToCollection;
@property (nonatomic, assign)         NSInteger budget;
@property (nonatomic, copy)           NSArray<MovieGenre *> *genres;
@property (nonatomic, copy)           NSString *homepage;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, copy)           NSString *imdbID;
@property (nonatomic, copy)           NSString *originalLanguage;
@property (nonatomic, copy)           NSString *originalTitle;
@property (nonatomic, copy)           NSString *overview;
@property (nonatomic, assign)         double popularity;
@property (nonatomic, copy)           NSString *posterPath;
@property (nonatomic, copy)           NSArray<MovieProductionCompany *> *productionCompanies;
@property (nonatomic, copy)           NSArray<MovieProductionCountry *> *productionCountries;
@property (nonatomic, copy)           NSString *releaseDate;
@property (nonatomic, assign)         NSInteger revenue;
@property (nonatomic, assign)         NSInteger runtime;
@property (nonatomic, copy)           NSArray<MovieSpokenLanguage *> *spokenLanguages;
@property (nonatomic, copy)           NSString *status;
@property (nonatomic, copy)           NSString *tagline;
@property (nonatomic, copy)           NSString *title;
@property (nonatomic, assign)         BOOL isVideo;
@property (nonatomic, assign)         double voteAverage;
@property (nonatomic, assign)         NSInteger voteCount;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
-(Movie*)initWithIdentifier:(NSInteger)identifier andPosterPath:(NSString*)posterPath andOriginalTitle:(NSString*)originalTitle andOverview:(NSString*)overview andVoteAverage:(double)voteAverage andReleaseDate:(NSString*)releaseDate andIsFavourite:(NSString*)isFavourite;
@end

@interface MovieGenre : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *name;
@end

@interface MovieProductionCompany : NSObject
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, nullable, copy) NSString *logoPath;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, copy)           NSString *originCountry;
@end

@interface MovieProductionCountry : NSObject
@property (nonatomic, copy) NSString *iso3166_1;
@property (nonatomic, copy) NSString *name;
@end

@interface MovieSpokenLanguage : NSObject
@property (nonatomic, copy) NSString *iso639_1;
@property (nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
