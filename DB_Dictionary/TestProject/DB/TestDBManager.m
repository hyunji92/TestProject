//
//  DBManager.m
//
//  Created by scpark on 13. 2. 26..
//

#define checkDBError(database)\
{\
if ([database hadError]) \
{\
NSLog(@"DBManagerError(%d)[%d at %s] %@", [database lastErrorCode], __LINE__, __FUNCTION__, [database lastErrorMessage]);\
}\
}

#import "TestDBManager.h"


static TestDBManager *_sharedDBManager = nil;

@interface TestDBManager()
@property (nonatomic, retain) NSDateFormatter   *dateFormatter;
@end

@implementation TestDBManager

@synthesize database;
@synthesize dateFormatter;

#pragma mark ===============================================================
#pragma mark - methods
+ (TestDBManager *)sharedDBManager
{
	@synchronized(self) //
    {
		if(_sharedDBManager == nil) //db가 없다면 새로 만든다.
			_sharedDBManager = [[self alloc] initWithDBName:DB_FILENAME];
	}
	return _sharedDBManager;
}

- (id)initWithDBName:(NSString*)DBName
{
	return [self initWithDBName:DBName designedDate:[NSDate dateWithTimeIntervalSince1970:0]];
}

- (id)initWithDBName:(NSString*)DBName designedDate:(NSDate*)designedDate
{
	if(self = [super init])
	{
        NSFileManager *fileManager = [NSFileManager defaultManager];
		NSError *error=nil;
        
		NSString *documentsDirectory = [self getSavePath];
		NSString *commonDBDirectory = [documentsDirectory stringByAppendingPathComponent:@""];
		NSString *DBFilePath = [commonDBDirectory stringByAppendingPathComponent:DBName];
        
        BOOL isDirectory=FALSE;
		BOOL exist = [fileManager fileExistsAtPath:commonDBDirectory isDirectory:&isDirectory];
		if(!isDirectory || !exist)
		{
			NSLog(@"Create DB path: %@", commonDBDirectory);
			if(![fileManager createDirectoryAtPath:commonDBDirectory  withIntermediateDirectories:YES attributes:nil error:&error])
				NSLog(@"%@", error);
		}
        
		if([fileManager fileExistsAtPath:DBFilePath])
		{
			NSDictionary *attribute = [fileManager attributesOfItemAtPath:DBFilePath error:&error];
			NSLog(@"%@", error);
			
			NSDate *fileCreationDate = [attribute fileCreationDate];
			NSLog(@"initWithDBName - fileCreationDate:%@ designedDate:%@", fileCreationDate, designedDate);
			
			if([fileCreationDate laterDate:designedDate] == designedDate)
			{
				[fileManager removeItemAtPath:DBFilePath error:&error];
				NSLog(@"%@", error);
			}
		}
        
		self.database = [FMDatabase databaseWithPath:DBFilePath];
		
		if (![database open])
		{
			NSLog(@"DBManger-init : Could not open DB");
			return self;
		}
		
		[database setShouldCacheStatements:NO];
		
		self.dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
		[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        
        // create tables
        [self createTables];
	}
	
	return self;
}


// DB 닫음
-(BOOL)closeAllDB
{
    BOOL result = [database close];
    _sharedDBManager = nil;
    return  result;
}


// 쿼리 array로 리턴
- (NSMutableArray*)getAllRowsFromResultSet:(FMResultSet*)rs
{
    NSMutableArray *array = [NSMutableArray array];
    
    while([rs next])
    {
        [array addObject:[rs resultDictionary]];
    }
    return array;
}

// 저장 경로
- (NSString *)getSavePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [NSString stringWithString:[paths objectAtIndex:0]];
    
    
    NSLog(@"######### documentsDirectory [ %@ ]  ###########",documentsDirectory);
    
    return documentsDirectory;
}

#pragma mark ===============================================================
#pragma mark - create
// create tables
-(BOOL)createTables
{
    BOOL queryResult = NO;

    NSMutableString *sql = [NSMutableString string];
    [sql appendString:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS `%@` (",DB_TABLE]];
    [sql appendString:[NSString stringWithFormat:@"`%@` INTEGER PRIMARY KEY AUTOINCREMENT,",DB_COLUMN_IDX]];
    [sql appendString:[NSString stringWithFormat:@"`%@` TEXT NOT NULL,",DB_COLUMN_TEST_TITLE]];
    [sql appendString:[NSString stringWithFormat:@"`%@` CONTEXT NOT NULL,",DB_COLUMN_TEST_CONTEXT]];
    [sql appendString:[NSString stringWithFormat:@"`%@` BLOB,",DB_COLUMN_TEST_IMAGE]];
    [sql appendString:[NSString stringWithFormat:@"`%@` DATETIME",DB_COLUMN_TEST_DATE]];

    [sql appendString:@");"];
    
    queryResult = [database executeUpdate:sql];
    checkDBError(database);

    if(!queryResult)
    {
        NSLog(@"Creating table fail");
        return NO;
    }


    return queryResult;
}

-(BOOL)isExist:(NSString*)testStr;
{
    
    BOOL isExist = NO;
    FMResultSet *rs = [database executeQuery:@"SELECT * from "DB_TABLE " WHERE " DB_COLUMN_TEST_TITLE"=?",testStr];
    
    checkDBError(database);
    
    if(![rs next])
    {
        isExist = YES;
    }

    [rs close];


    return isExist;
}



- (BOOL)insertTest:(NSString *)str context:(NSString*)context image:(UIImage*)image date:(NSDate*)date
{
    BOOL isSuccess = NO;
    
    
    NSData   *imgBlobData = UIImageJPEGRepresentation(image, 1.0);
    
    isSuccess = [database executeUpdate:@"INSERT INTO "DB_TABLE " ("
         
         DB_COLUMN_TEST_TITLE ","
         DB_COLUMN_TEST_CONTEXT ","
         DB_COLUMN_TEST_IMAGE","
         DB_COLUMN_TEST_DATE
         ")  VALUES (?,?,?,?)",
         str,
         context,
         imgBlobData,
         date
    ];
    
    checkDBError(database);
    
    return isSuccess;
}


- (NSMutableArray*)selectAllList
{

    NSMutableArray *array;
    FMResultSet *rs = [database executeQuery:@"SELECT * from " DB_TABLE ];
    
    checkDBError(database);
    
    array = [self getAllRowsFromResultSet:rs];
    [rs close];
    
    return array;
}

- (NSMutableArray*)selectWithIdx:(NSNumber*)idx
{
    
    NSMutableArray *array;
    FMResultSet *rs = [database executeQuery:@"SELECT * from " DB_TABLE " WHERE "DB_COLUMN_IDX"=?",idx];
    
    checkDBError(database);
    
    array = [self getAllRowsFromResultSet:rs];
    [rs close];
    
    return array;
}



- (BOOL)updateWhtiIdx:(NSNumber*)idx str:(NSString *)str context:(NSString *)context image:(UIImage*)image date:(NSDate*)date
{
    
    BOOL isSuccess;
    
    NSData   *imgBlobData = UIImageJPEGRepresentation(image, 1.0);
    
    isSuccess = [database executeUpdate:@"UPDATE "DB_TABLE " SET "
     
     DB_COLUMN_TEST_TITLE "=?,"
     DB_COLUMN_TEST_CONTEXT"=?,"
     DB_COLUMN_TEST_IMAGE"=?,"
     DB_COLUMN_TEST_DATE"=? "
     " WHERE "
     DB_COLUMN_IDX"=?",
     str,
     context,
     imgBlobData,
     date,
     idx
     
     ];
    
    checkDBError(database);
    
    return isSuccess;
    
    
}
- (BOOL)deleteAllDatas
{
    BOOL isSuccess;
    isSuccess = [database executeUpdate:@"DELETE FROM " DB_TABLE];
    checkDBError(database);
    return isSuccess;
    
}
- (BOOL)deleteWithIdx:(NSNumber*)idx
{
    BOOL isSuccess;
    isSuccess = [database executeUpdate:@"DELETE FROM " DB_TABLE " WHERE "DB_COLUMN_IDX"=?",idx];
    checkDBError(database);
    return isSuccess;
    
} 
@end
