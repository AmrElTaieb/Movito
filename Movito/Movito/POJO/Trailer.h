// Trailer.h

// To parse this JSON:
//
//   NSError *error;
//   Trailer * = [Trailer fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class Trailer;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface Trailer : NSObject
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, copy)   NSString *iso639_1;
@property (nonatomic, copy)   NSString *iso3166_1;
@property (nonatomic, copy)   NSString *key;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *site;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic)   NSInteger movieIdentifier;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
-(Trailer*)initWithIdentifier:(NSString*)identifier andName:(NSString*)name andKey:(NSString*)key andMovieIdentifier:(NSInteger)movieIdentifier;
@end

NS_ASSUME_NONNULL_END
