// Trailer.m

#import "Trailer.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface Trailer (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

#pragma mark - JSON serialization

Trailer *_Nullable TrailerFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [Trailer fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

Trailer *_Nullable TrailerFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return TrailerFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable TrailerToData(Trailer *hopa, NSError **error)
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

NSString *_Nullable TrailerToJSON(Trailer *hopa, NSStringEncoding encoding, NSError **error)
{
    NSData *data = TrailerToData(hopa, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation Trailer
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
                                                    @"id": @"identifier",
                                                    @"iso_639_1": @"iso639_1",
                                                    @"iso_3166_1": @"iso3166_1",
                                                    @"key": @"key",
                                                    @"name": @"name",
                                                    @"site": @"site",
                                                    @"size": @"size",
                                                    @"type": @"type",
                                                    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return TrailerFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return TrailerFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[Trailer alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = Trailer.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:Trailer.properties.allValues] mutableCopy];
    
    // Rewrite property names that differ in JSON
    for (id jsonName in Trailer.properties) {
        id propertyName = Trailer.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }
    
    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return TrailerToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return TrailerToJSON(self, encoding, error);
}

-(Trailer*)initWithIdentifier:(NSString*)identifier andName:(NSString*)name andKey:(NSString*)key andMovieIdentifier:(NSInteger)movieIdentifier
{
    if (self = [super init])
    {
        self.identifier = identifier;
        self.name = name;
        self.key = key;
        self.movieIdentifier = movieIdentifier;
        return self;
    } else
    {
        return nil;
    }
}

@end

NS_ASSUME_NONNULL_END

