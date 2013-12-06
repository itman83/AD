
#import <Foundation/Foundation.h>
// This includes the header for the SQLite library.
#import <sqlite3.h>


@interface DBConnectionManager : NSObject {

}

+ (NSString *) getDatabaseFileName;

+ (void) createCopyOfDatabaseIfNeeded;

+ (void) initializeDatabase;

+ (sqlite3 *) getDatabaseObject;

+ (void) closeDatabase;

@end
