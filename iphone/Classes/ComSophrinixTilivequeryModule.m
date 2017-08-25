/**
 * TiLiveQuery
 *
 * Created by Your Name
 * Copyright (c) 2017 Your Company. All rights reserved.
 */

#import "ComSophrinixTilivequeryModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation ComSophrinixTilivequeryModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"fae0c022-6f03-43fb-8de4-c92d608b08c0";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.sophrinix.tilivequery";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[DEBUG] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)initializeWithConfiguration:(id)args
{
	[Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
			configuration.applicationId = @"cfEqijsSr9AS03FR76DJYM374KHH5GddQSQvIU7H";
			configuration.clientKey = @"F9dLUvMhb8D7aMCAukUDMFae630qhhlYTki6dGxP";
			configuration.server = @"https://parseapi.back4app.com";
			configuration.localDatastoreEnabled = YES; // If you need to enable local data store
	}]];
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(id)newClient:(id)value
{
	self.liveQueryClient = [[PFLiveQueryClient alloc] initWithServer:@"wss://livequeryexample.back4app.io" applicationId:@"cfEqijsSr9AS03FR76DJYM374KHH5GddQSQvIU7H" clientKey:@"F9dLUvMhb8D7aMCAukUDMFae630qhhlYTki6dGxP"];
	self.msgQuery = [PFQuery queryWithClassName:@"Message"];
	[self.msgQuery whereKey:@"destination" equalTo:@"pokelist"];
	self.subscription = [self.liveQueryClient subscribeToQuery:self.msgQuery];
	[self.subscription addCreateHandler:^(PFQuery<PFObject *> * _Nonnull query, PFObject * _Nonnull object) {
			[self alert:@"You have been poked" title:@"Poke"];
	}];
}

-(id)message:(id)args
{
	PFObject* poke = [PFObject objectWithClassName:@"Message"];
	poke[@"content"] = @"poke";
	poke[@"destination"] = @"pokelist";
	[poke saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
			NSLog(@"Poke sent");
	}];
}

@end
