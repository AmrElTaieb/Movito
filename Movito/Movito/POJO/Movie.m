#import "Movie.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface Movie (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface MovieGenre (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface MovieProductionCompany (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface MovieProductionCountry (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface MovieSpokenLanguage (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
        result = [NSMutableArray arrayWithCapacity:[collection count]];
        for (id x in collection) [result addObject:f(x)];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
        result = [NSMutableDictionary dictionaryWithCapacity:[collection count]];
        for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

Movie *_Nullable MovieFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [Movie fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

Movie *_Nullable MovieFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return MovieFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable MovieToData(Movie *hopa, NSError **error)
{
    @try {
        id json = [hopa JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable MovieToJSON(Movie *hopa, NSStringEncoding encoding, NSError **error)
{
    NSData *data = MovieToData(hopa, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation Movie
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"adult": @"isAdult",
        @"backdrop_path": @"backdropPath",
        @"belongs_to_collection": @"belongsToCollection",
        @"budget": @"budget",
        @"genres": @"genres",
        @"homepage": @"homepage",
        @"id": @"identifier",
        @"imdb_id": @"imdbID",
        @"original_language": @"originalLanguage",
        @"original_title": @"originalTitle",
        @"overview": @"overview",
        @"popularity": @"popularity",
        @"poster_path": @"posterPath",
        @"production_companies": @"productionCompanies",
        @"production_countries": @"productionCountries",
        @"release_date": @"releaseDate",
        @"revenue": @"revenue",
        @"runtime": @"runtime",
        @"spoken_languages": @"spokenLanguages",
        @"status": @"status",
        @"tagline": @"tagline",
        @"title": @"title",
        @"video": @"isVideo",
        @"vote_average": @"voteAverage",
        @"vote_count": @"voteCount",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return MovieFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return MovieFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[Movie alloc] initWithJSONDictionary:dict] : nil;
}

-(Movie*)initWithIdentifier:(NSInteger)identifier andPosterPath:(NSString*)posterPath andOriginalTitle:(NSString*)originalTitle andOverview:(NSString*)overview andVoteAverage:(double)voteAverage andReleaseDate:(NSString*)releaseDate andIsFavourite:(NSString*)isFavourite
{
    if (self = [super init])
    {
        self.identifier = identifier;
        self.posterPath = posterPath;
        self.originalTitle = originalTitle;
        self.overview = overview;
        self.voteAverage = voteAverage;
        self.releaseDate = releaseDate;
        self.isFavourite = isFavourite;
        return self;
    } else
    {
        return nil;
    }
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _genres = map(_genres, λ(id x, [MovieGenre fromJSONDictionary:x]));
        _productionCompanies = map(_productionCompanies, λ(id x, [MovieProductionCompany fromJSONDictionary:x]));
        _productionCountries = map(_productionCountries, λ(id x, [MovieProductionCountry fromJSONDictionary:x]));
        _spokenLanguages = map(_spokenLanguages, λ(id x, [MovieSpokenLanguage fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = Movie.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:Movie.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in Movie.properties) {
        id propertyName = Movie.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"adult": _isAdult ? @YES : @NO,
        @"genres": map(_genres, λ(id x, [x JSONDictionary])),
        @"production_companies": map(_productionCompanies, λ(id x, [x JSONDictionary])),
        @"production_countries": map(_productionCountries, λ(id x, [x JSONDictionary])),
        @"spoken_languages": map(_spokenLanguages, λ(id x, [x JSONDictionary])),
        @"video": _isVideo ? @YES : @NO,
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return MovieToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return MovieToJSON(self, encoding, error);
}
@end

@implementation MovieGenre
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[MovieGenre alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = MovieGenre.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:MovieGenre.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in MovieGenre.properties) {
        id propertyName = MovieGenre.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation MovieProductionCompany
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"logo_path": @"logoPath",
        @"name": @"name",
        @"origin_country": @"originCountry",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[MovieProductionCompany alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = MovieProductionCompany.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:MovieProductionCompany.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in MovieProductionCompany.properties) {
        id propertyName = MovieProductionCompany.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation MovieProductionCountry
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"iso_3166_1": @"iso3166_1",
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[MovieProductionCountry alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = MovieProductionCountry.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:MovieProductionCountry.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in MovieProductionCountry.properties) {
        id propertyName = MovieProductionCountry.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation MovieSpokenLanguage
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"iso_639_1": @"iso639_1",
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[MovieSpokenLanguage alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = MovieSpokenLanguage.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:MovieSpokenLanguage.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in MovieSpokenLanguage.properties) {
        id propertyName = MovieSpokenLanguage.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
