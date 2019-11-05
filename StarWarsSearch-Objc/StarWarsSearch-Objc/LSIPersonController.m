//
//  LSIPersonController.m
//  StarWarsSearch-Objc
//
//  Created by Jake Connerly on 11/5/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIPersonController.h"
#import "LSIPerson.h"

@implementation LSIPersonController

static NSString *const baseURLString = @"https://swapi.co/api/people";

- (void)searchForPeopleWithSearchTerm:(NSString *)searchTerm
                            //completion(nil, nil) // call the completion "BLOCK" ( same thing as a closure in Swift)
                           completion:(void (^)(NSArray *people, NSError *error))completion {
    
    //constructing URL
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *searchItem = [NSURLQueryItem queryItemWithName:@"search" value:searchTerm];
    [components setQueryItems:@[searchItem]];
    
    NSURL *url = [components URL];
    NSLog(@"url: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Make our request URLSession
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"Search Results");
        
    // Check for error, call completion
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            completion(nil, [[NSError alloc] init]);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if(jsonError) {
            completion(nil, error);
            return;
        }
        
        // Check for data, parse it
        if(![json isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a top level dictionary as expected");
            completion(nil, [[NSError alloc] init]);
        }
        
        // Loop through the data and transform from a dictionary to LSIPerson
        NSArray *results = json[@"results"];
        NSMutableArray *people = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dictionary in results) {
            LSIPerson *person = [[LSIPerson alloc] initWithDictionary:dictionary];
            [people addObject:person];
        }
        completion(people, nil);
    }];
    [task resume];
    
}

@end
