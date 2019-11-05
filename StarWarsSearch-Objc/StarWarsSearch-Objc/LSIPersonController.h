//
//  LSIPersonController.h
//  StarWarsSearch-Objc
//
//  Created by Jake Connerly on 11/5/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSIPersonController : NSObject

// Public properties
// Public instance variables


- (void)searchForPeopleWithSearchTerm:(NSString *)searchTerm
                           completion:(void (^)(NSArray *people, NSError *error))completion;


@end

