#import "Review.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface Review (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

#pragma mark - JSON serialization

Review *_Nullable ReviewFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [Review fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

Review *_Nullable ReviewFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return ReviewFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable ReviewToData(Review *hopa, NSError **error)
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

NSString *_Nullable ReviewToJSON(Review *hopa, NSStringEncoding encoding, NSError **error)
{
    NSData *data = ReviewToData(hopa, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation Review
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"author": @"author",
        @"content": @"content",
        @"id": @"identifier",
        @"url": @"url",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return ReviewFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return ReviewFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[Review alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = Review.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:Review.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in Review.properties) {
        id propertyName = Review.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return ReviewToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return ReviewToJSON(self, encoding, error);
}

-(Review*)initWithIdentifier:(NSString*)identifier andAuthor:(NSString*)author andContent:(NSString*)content andUrl:(NSString*)url andMovieIdentifier:(NSInteger)movieIdentifier
{
    if (self = [super init])
    {
        self.identifier = identifier;
        self.author = author;
        self.content = content;
        self.url = url;
        self.movieIdentifier = movieIdentifier;
        return self;
    } else
    {
        return nil;
    }
}

@end

NS_ASSUME_NONNULL_END
