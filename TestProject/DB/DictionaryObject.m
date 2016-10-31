//
//  DictionaryObject.m
//  ums
//
//
//
//

#import "DictionaryObject.h"
#import <objc/runtime.h>

@interface DictionaryObject ()

@end


@implementation DictionaryObject

+ (instancetype)sharedObject {
    
    static DictionaryObject *_sharedDictionaryObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedDictionaryObject = [[self alloc] init];
        
    });
    
    return _sharedDictionaryObject;
}


static const char *getPropertyType(objc_property_t property)
{
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    
    while ((attribute = strsep(&state, ",")) != NULL)
    {
        if(strchr(attribute, '@'))
        {
            if (attribute[0] == 'T')
                return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
            else
                break;
        } else
            break;
    }
    
    return NULL;
}
//NMObject array -> NSDictionary array
+ (NSArray*)arrayFromObjectArray:(NSArray*)objectArray
{
    NSMutableArray *arrays = [NSMutableArray arrayWithCapacity:objectArray.count];
    for(id value in objectArray)
    {
        if([value isKindOfClass:[DictionaryObject class]])
            [arrays addObject:[value dictionary]];
        else
            [arrays addObject:value];
    }
    
    return [NSArray arrayWithArray:arrays];
}

+ (id)object
{
    return [[self alloc] init];
}

+ (id)blankObjectFromType:(NSString*)propertyType
{
    id blankObject = [NSNull null];
    if([propertyType isEqualToString:@"NSNumber"])
        blankObject = [NSNumber numberWithInt:0];
    else if([propertyType isEqualToString:@"NSString"])
        blankObject = [NSString string];
    else if([propertyType isEqualToString:@"NSDate"])
        blankObject = [NSDate date];
    else if([propertyType isEqualToString:@"NSArray"])
        blankObject = [NSArray array];
    else if([propertyType isEqualToString:@"NSDictionary"])
        blankObject = [NSDictionary dictionary];
    else
    {
        NSLog(@"blankObjectFromType %@", propertyType);
    }
    
    return blankObject;
}

+ (id)objectFromDictionary:(NSDictionary*)dictionary
{
    if(dictionary == nil)
        return nil;
    
    id object = [[[self class] alloc] init] ;
    
    
    for(NSString *key in dictionary)
    {
        @try
        {
            id value = [dictionary objectForKey:key];
            objc_property_t property = class_getProperty(self, [key UTF8String]);
            
            if(!property)
                property = class_getProperty(self, [[NSString stringWithFormat:@"_%@", key] UTF8String]);
            
            if(!property)
            {
                NSLog(@"!!!Warring!!! \nCann't found Property(%@) in Class(%@)", key, [self class]);
                continue;
            }
            
            const char *type = getPropertyType(property);
            if(type != NULL)
            {
//                NSString *propertyType = [NSString stringWithUTF8String:type];
//                if([value isKindOfClass:[NSNull class]] || value == nil)
//                {
//                    [object setValue:[[self class] blankObjectFromType:propertyType] forKey:key];
//                }
//                else
                    [object setValue:value forKey:key];
                
            }
        }
        @catch (NSException * e)
        {
            //NSLogM(@"Exception Error: [key:%@ value:%@] %@ %@", key, [dictionary objectForKey:key], [e name], [e reason]);
            NSAssert(FALSE, @"");
        }
        @finally
        {
        }
    }
    
    
    return object;
}


- (id)init
{
    if(self = [super init])
    {
        unsigned int propertyCount = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
        
        for(unsigned int i = 0; i < propertyCount; ++i)
        {
            objc_property_t property = properties[i];
            
            const char *name = property_getName(property);
            const char *type = getPropertyType(property);
            
            if(type!=NULL)
            {
                NSString *propertyType = [NSString stringWithUTF8String:type];
                NSString *propertyName = [NSString stringWithUTF8String:name];
                [self setValue:[[self class] blankObjectFromType:propertyType] forKey:propertyName];
            }
        }
        free(properties);
    }
    
    return self;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for(unsigned int i = 0; i < propertyCount; ++i)
    {
        objc_property_t property = properties[i];
        
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        const char *type = getPropertyType(property);
        
        if(type != NULL)
        {
            NSString *propertyType = [NSString stringWithUTF8String:type];
            id value = [self valueForKey:propertyName];
            
//            NSLog(@"n:%@ t:%@ v:%@", propertyName, propertyType, value);
            if([propertyName characterAtIndex:0] == '_')
                propertyName = [propertyName substringFromIndex:1];
            
            if([value isKindOfClass:[NSNull class]] || value == nil)
                value = [[self class] blankObjectFromType:propertyType];
            
            [dictionary setObject:value forKey:propertyName];
        }
    }
    free(properties);
    
    //NMObject propertys -> framework array,dictionary
    for(id key in dictionary.allKeys)
    {
        id object = [dictionary objectForKey:key];
        
        if([object isKindOfClass:[NSArray class]])
        {
            [dictionary setObject:[DictionaryObject arrayFromObjectArray:object] forKey:key];
        }
        if([object isKindOfClass:[DictionaryObject class]])
            [dictionary setObject:[object dictionary] forKey:key];
    }
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (NSString *)description
{
    return [[self dictionary] description];
}
@end

