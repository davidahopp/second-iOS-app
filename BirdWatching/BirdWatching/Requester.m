#import "Requester.h"

@interface Requester()<NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURL *url;

@end

@implementation Requester

@synthesize restString = _restString;
@synthesize delegate = _delegate;
@synthesize identifier = _identifier;

@synthesize connection = _connection;
@synthesize responseData = _responseData;
@synthesize url = _url;

static NSInteger connectionCount;

- (id)initWithRestString:(NSString *)restString andDelegate:(id)delegate andIdentifier:(NSString *)identifier
{
	if (self = [super init])
	{
		self.restString = restString;
		self.delegate = delegate;
		self.identifier = identifier;
	}
	
	return self;
}

#define SERVER_URL @"http://birdwatching.davidahopp.com/"

- (void)setRestString:(NSString *)restString
{
    _restString = restString;
    self.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SERVER_URL, restString]]; 
}

- (NSString *)identifier
{
	if (_identifier == nil) {
		_identifier = @"";
	}
	
	return _identifier;
}

#pragma mark - NSURLConnectionDelegate 

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
{
    [self.responseData appendData:data];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
{
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:(NSData *)self.responseData options:NSJSONReadingMutableContainers error:nil];
	
    if (--connectionCount <= 0) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
	
    if ([self.delegate respondsToSelector:@selector(identifierDidFinishDownloading:withJSON:)]) {
        [self.delegate identifierDidFinishDownloading:self.identifier withJSON:json];
    }
    
    self.delegate = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (--connectionCount <= 0) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
														message:@"We were not able to access the server. Please try again later."
													   delegate:nil
											  cancelButtonTitle:@"Okay"
											  otherButtonTitles:nil];
	[alertView show];
    
    self.delegate = nil;
}

#pragma mark - Custom Instance Methods

- (void)performHTTPMethod:(NSString *)method withData:(id)data
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
    [request setHTTPMethod:method];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    if (data) {
        NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
        [request setHTTPBody:body];
    }
	
    self.responseData = [[NSMutableData alloc] init];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    connectionCount++;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

@end
