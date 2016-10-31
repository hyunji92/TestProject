//
//  DictionaryObject.h
//  UMS
//
//

#import <Foundation/Foundation.h>

@interface DictionaryObject : NSObject

//초기화되어 있는 object반환
+ (id)object;

+ (instancetype)sharedObject;

//dictionary를 이용하여 object반환
+ (id)objectFromDictionary:(NSDictionary*)dictionary;

//dictionary로 전환
- (NSDictionary*)dictionary;


+ (NSArray*)arrayFromObjectArray:(NSArray*)objectArray;

@end
