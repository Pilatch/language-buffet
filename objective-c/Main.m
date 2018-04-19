#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (assign) NSString* name;
@property (nonatomic) float winPercentage;
-(id)initWithJSON :(NSString*)json;
@end

@implementation Player
@synthesize name;
@synthesize  winPercentage;

-(id)initWithJSON: (NSString*)json {

NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
NSDictionary *dict = [NSJSONSerialization
                            JSONObjectWithData:jsonData
                            options:kNilOptions
                            error:nil];

// you can't directly check if a key exists
[self setName:[dict objectForKey:@"name"]]; // nil if no key
float defaultWin = ([dict objectForKey:@"winPercentage"] == nil) ? 0.0f : [[dict objectForKey:@"winPercentage"] floatValue];
[self setWinPercentage:defaultWin]; // 0.0f if no key

return self;

}
@end

int main(int argc, const char * argv[]) {
    NSString *json = [NSString stringWithContentsOfFile:@"./rad.json"
                                            encoding:NSUTF8StringEncoding
                                               error:nil];
    Player *p = [[Player alloc] initWithJSON:json];
    NSLog(@"name is %@", p.name);
    return 0;
}
