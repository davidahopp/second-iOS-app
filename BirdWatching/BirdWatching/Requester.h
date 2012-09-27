#import <Foundation/Foundation.h>

@protocol RequesterDelegate
@optional
- (void)identifierDidFinishDownloading:(NSString *)identifier withJSON:(NSDictionary *)json;
@end

@interface Requester : NSObject 

//the rest string is the end of a request.
//if we wanted to send a rest request to jaynewstrom.com/test/1/55, the rest string would be /1/55.
//note the beginning slash.
@property (nonatomic, strong) NSString *restString;
@property (nonatomic, weak) id <RequesterDelegate, NSObject> delegate;
@property (nonatomic, strong) NSString *identifier;

- (id)initWithRestString:(NSString *)restString andDelegate:(id)delegate andIdentifier:(NSString *)identifier;

// data is id, but needs to be something that NSJSONSerialization can seraialize.
- (void)performHTTPMethod:(NSString *)method withData:(id)data;

@end
