//
//  DatabaseAdapter.m
//  Lab3SQLite
//
//  Created by Amr Mohamed Koritem on 3/24/19.
//  Copyright © 2019 Amr Mohamed Koritem. All rights reserved.
//

#import "DatabaseAdapter.h"

@implementation DatabaseAdapter

+(DatabaseAdapter*)sharedInstance
{
    static DatabaseAdapter* sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[DatabaseAdapter alloc] init];
    });
    return sharedInstance;
}

-(void)createMoviesTable
{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:                                  @"movies.db"]];
    
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS MOVIES (identifier TEXT PRIMARY KEY, posterPath TEXT, originalTitle TEXT, overview TEXT, voteAverage TEXT, releaseDate TEXT, isFavourite Text)";
        
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            printf("Failed to create table");
        }
        sqlite3_close(_contactDB);
    } else {
        printf("Failed to open/create database");
    }
}

-(void)createFavouritesTable
{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:                                  @"movies.db"]];
    
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS Favourites (identifier TEXT PRIMARY KEY, posterPath TEXT, originalTitle TEXT, overview TEXT, voteAverage TEXT, releaseDate TEXT, isFavourite Text)";
        
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            printf("Failed to create table");
        }
        sqlite3_close(_contactDB);
    } else {
        printf("Failed to open/create database");
    }
}

-(void)createTrailersTable
{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:                                  @"movies.db"]];
    
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS trailers (identifier TEXT PRIMARY KEY, name TEXT, key TEXT, movieIdentifier TEXT)";
        
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            printf("Failed to create table");
        }
        sqlite3_close(_contactDB);
    } else {
        printf("Failed to open/create database");
    }
}

-(NSArray*)selectMoviesTable
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSMutableArray* arr = [NSMutableArray new];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT identifier, posterPath, originalTitle, overview, voteAverage, releaseDate, isFavourite FROM movies"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString* identifier = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)];
                NSString* posterPath = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString* originalTitle = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString* overview = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString* voteAverage = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                NSString* releaseDate = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                NSString* isFavourite = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                Movie *movie = [[Movie alloc] initWithIdentifier:[identifier integerValue] andPosterPath:posterPath andOriginalTitle:originalTitle andOverview:overview andVoteAverage:[voteAverage doubleValue] andReleaseDate:releaseDate andIsFavourite:isFavourite];
                
                [arr addObject:movie];
//                printf("Match found\n");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    return arr;
}

-(NSArray*)selectFavouritesTable
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSMutableArray* arr = [NSMutableArray new];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT identifier, posterPath, originalTitle, overview, voteAverage, releaseDate, isFavourite FROM favourites"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString* identifier = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)];
                NSString* posterPath = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString* originalTitle = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString* overview = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString* voteAverage = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                NSString* releaseDate = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                NSString* isFavourite = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                Movie *movie = [[Movie alloc] initWithIdentifier:[identifier integerValue] andPosterPath:posterPath andOriginalTitle:originalTitle andOverview:overview andVoteAverage:[voteAverage doubleValue] andReleaseDate:releaseDate andIsFavourite:isFavourite];
                
                [arr addObject:movie];
//                printf("Match found\n");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    return arr;
}

-(NSArray*)selectTrailersTableWithIdentifier:(NSInteger)mIdentifier
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSMutableArray* arr = [NSMutableArray new];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT identifier, name, key FROM trailers WHERE movieIdentifier=\"%ld\"", mIdentifier];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString* identifier = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)];
                NSString* name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString* key = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                Trailer *trailer = [[Trailer alloc] initWithIdentifier:identifier andName:name andKey:key andMovieIdentifier:mIdentifier];
                
                [arr addObject:trailer];
//                printf("Match found\n");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    return arr;
}

-(BOOL)deleteFromMoviesTable:(NSString*)identifier
{
    BOOL ret = YES;
    sqlite3_stmt    *statement;
    const char *dbpath;
    dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *deleteSQL = [NSString stringWithFormat: @"DELETE FROM movies WHERE identifier=\"%@\"", identifier];
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            printf("movie deleted\n");
        } else {
//            printf("Failed to delete movie\n");
            ret = NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return ret;
}

-(BOOL)deleteFromFavouritesTable:(NSString*)identifier
{
    BOOL ret = YES;
    sqlite3_stmt    *statement;
    const char *dbpath;
    dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *deleteSQL = [NSString stringWithFormat: @"DELETE FROM favourites WHERE identifier=\"%@\"", identifier];
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            printf("favourite deleted\n");
        } else {
//            printf("Failed to delete favourite\n");
            ret = NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return ret;
}

-(BOOL)deleteFromTrailerssTable:(NSString*)identifier
{
    BOOL ret = YES;
    sqlite3_stmt    *statement;
    const char *dbpath;
    dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *deleteSQL = [NSString stringWithFormat: @"DELETE FROM trailers WHERE identifier=\"%@\"", identifier];
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            printf("favourite deleted\n");
        } else {
//            printf("Failed to delete favourite\n");
            ret = NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return ret;
}

-(BOOL)emptyMoviesTable
{
    _favourites = [self selectMoviesTable];
    BOOL ret = YES;
    sqlite3_stmt    *statement;
    const char *dbpath;
    dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *deleteSQL = [NSString stringWithFormat: @"DELETE FROM movies"];
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            printf("movies deleted\n");
        } else {
//            printf("Failed to delete movies\n");
            ret = NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return ret;
}

-(BOOL)insertInMoviesTableIdentifier:(Movie*)movie
{
    BOOL ret = YES;
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *insertSQL;
        insertSQL = [NSString stringWithFormat:
                     @"INSERT INTO movies (identifier, posterPath, originalTitle, overview, voteAverage, releaseDate, isFavourite) VALUES (\"%ld\", \"%@\", \"%@\", \"%@\", \"%lf\", \"%@\", \"%@\")", [movie identifier], [movie posterPath], [movie originalTitle], [movie overview], [movie voteAverage], [movie releaseDate], [movie isFavourite]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            printf("movie added\n");
        } else {
//            printf("Failed to add movie\n");
            ret = NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    for(int i = 0; i<_favourites.count; i++)
    {
        Movie* tmpMovie = _favourites[i];
        if ([tmpMovie identifier] == movie.identifier)
        {
            [self updateMoviesTableIdentifier:tmpMovie];
            [self createFavouritesTable];
            if([tmpMovie.isFavourite isEqualToString:@"favourite"])
            {
                [self insertInFavouritesTableIdentifier:tmpMovie];
            } else
            {
                NSString* tmpStr = [NSString stringWithFormat:@"%ld",[tmpMovie identifier]];
                [self deleteFromFavouritesTable:tmpStr];
            }
            break;
        }
    }
    return ret;
}

-(BOOL)insertInFavouritesTableIdentifier:(Movie*)movie
{
    BOOL ret = YES;
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *insertSQL;
        insertSQL = [NSString stringWithFormat:
                     @"INSERT INTO favourites (identifier, posterPath, originalTitle, overview, voteAverage, releaseDate, isFavourite) VALUES (\"%ld\", \"%@\", \"%@\", \"%@\", \"%lf\", \"%@\", \"%@\")", [movie identifier], [movie posterPath], [movie originalTitle], [movie overview], [movie voteAverage], [movie releaseDate], [movie isFavourite]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            printf("favourite added\n");
        } else {
//            printf("Failed to add favourite\n");
            ret = NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return ret;
}

-(BOOL)insertInTrailersTableIdentifier:(Trailer*)trailer
{
    BOOL ret = YES;
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *insertSQL;
        insertSQL = [NSString stringWithFormat:
                     @"INSERT INTO trailers (identifier, name, key, movieIdentifier) VALUES (\"%@\", \"%@\", \"%@\", \"%ld\")", [trailer identifier], [trailer name], [trailer key], [trailer movieIdentifier]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            printf("favourite added\n");
        } else {
//            printf("Failed to add favourite\n");
            ret = NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return ret;
}

-(BOOL)updateMoviesTableIdentifier:(Movie*)movie
{
    BOOL ret = YES;
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *updateSQL;
        updateSQL = [NSString stringWithFormat:
                     @"UPDATE movies SET posterPath = \"%@\", originalTitle = \"%@\", overview = \"%@\", voteAverage = \"%lf\", releaseDate = \"%@\", isFavourite = \"%@\" WHERE identifier=\"%ld\"",
                     [movie posterPath], [movie originalTitle], [movie overview], [movie voteAverage], [movie releaseDate], [movie isFavourite], [movie identifier]];
        
        const char *update_stmt = [updateSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, update_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            printf("movie updated\n");
        } else {
//            printf("Failed to update movie\n");
            ret = NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return ret;
}

@end
