//
//  DBManager.h
//  Created by scpark on 13. 2. 26..
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "TestDBTag.h"
@interface TestDBManager : NSObject

@property (nonatomic, retain) FMDatabase    *database;

+ (TestDBManager *)sharedDBManager;

// 저장 경로
- (NSString *)getSavePath;

-(BOOL)closeAllDB;

-(BOOL)isExist:(NSString*)testStr;



- (BOOL)insertTest:(NSString *)str
           context:(NSString*)context
             image:(UIImage*)image
              date:(NSDate*)date;


- (NSMutableArray*)selectAllList;

- (NSMutableArray*)selectWithIdx:(NSNumber*)idx;



- (BOOL)updateWhtiIdx:(NSNumber*)idx
                  str:(NSString *)str
              context:(NSString*)context
                image:(UIImage*)image
                 date:(NSDate*)date;

- (BOOL)deleteAllDatas;

- (BOOL)deleteWithIdx:(NSNumber*)idx;
@end
