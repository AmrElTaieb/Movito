// To parse this JSON:
//
//   NSError *error;
//   Review * = [Review fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class Review;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface Review : NSObject
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *url;
@property (nonatomic)   NSInteger movieIdentifier;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
-(Review*)initWithIdentifier:(NSString*)identifier andAuthor:(NSString*)author andContent:(NSString*)content andUrl:(NSString*)url andMovieIdentifier:(NSInteger)movieIdentifier;
@end

NS_ASSUME_NONNULL_END
