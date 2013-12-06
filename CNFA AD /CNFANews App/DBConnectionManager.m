
#import "DBConnectionManager.h"


@implementation DBConnectionManager

// Opaque reference to the SQLite database.
static sqlite3 *m_database = nil;

+ (NSString *) getDatabaseFileName {
	
	return @"Add_NewsDB.sqlite";
}

// Creates a writable copy of the bundled default database in the application Documents directory.
+ (void) createCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:[DBConnectionManager getDatabaseFileName]];
	
	success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
    {
        NSLog(@"SUCCESSSSSSSSSSS");
    return;
	}
    // The writable database does not exist, so copy the default to the appropriate location.
   // NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[DBConnectionManager getDatabaseFileName]];
    NSString *defaultDBPath = [[NSBundle mainBundle] pathForResource:@"Add_NewsDB" ofType:@"sqlite"];
    
    
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        //NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
         NSLog(@"NOOOOO   SUCCESSSSSSSSSSS");
    }
    
    
    
    
  
    
    
}

// Open the database connection and retrieve minimal information for all objects.
+ (void) initializeDatabase {
    // The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[DBConnectionManager getDatabaseFileName]];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &m_database) == SQLITE_OK) {
        NSLog(@"OPEN DATABASE");
		// Database connection open successfully	
    } 
	else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(m_database);
        //NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(m_database));
	}
}

+ (sqlite3 *) getDatabaseObject {
	return m_database;
}

+ (void) closeDatabase {
	// Close the database.
    if (sqlite3_close(m_database) != SQLITE_OK) {
		//NSAssert1(0, @"Error: failed to close database with message '%s'.", sqlite3_errmsg(m_database));
	}
}

@end
