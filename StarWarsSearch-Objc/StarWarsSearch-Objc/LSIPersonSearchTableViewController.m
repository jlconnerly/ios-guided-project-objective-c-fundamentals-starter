//
//  LSIPersonSearchTableViewController.m
//  Star Wars Search ObjC
//
//  Created by Spencer Curtis on 10/1/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "LSIPersonSearchTableViewController.h"
#import "LSIPersonTableViewCell.h"
#import "LSIPersonController.h"
#import "LSIPerson.h"

@interface LSIPersonSearchTableViewController ()

@property LSIPersonController *controller;
@property NSArray *people;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation LSIPersonSearchTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _controller = [[LSIPersonController alloc] init];
    }
    return self;
}

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchBar setDelegate:self];
    
//    // Class type
//    NSDictionary *dictionary = @{ @"name" : @"Paul" };
//    NSArray *array = @[ @"Blue", @"Green", @"Orange"];
//    
//    NSLog(@"Dictionary: is it a Dictionary? %d", [dictionary isKindOfClass:[NSDictionary class]]);
//    NSLog(@"Dictionary: is it a String? %d", [dictionary isKindOfClass:[NSString class]]);
//    NSLog(@"Array: is it a Dictionary? %d", [array isKindOfClass:[NSDictionary class]]);
//    NSLog(@"Array: is it a Array? %d", [array isKindOfClass:[NSArray class]]);
//    
//    NSObject *object = array;
//    
//    // JSON -> (Array or Dictionary)
//    NSLog(@"object: is it a Dictionary? %d", [object isKindOfClass:[NSDictionary class]]);
//    NSLog(@"object: is it a Array? %d", [object isKindOfClass:[NSArray class]]);
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.controller searchForPeopleWithSearchTerm:searchBar.text completion:^(NSArray *people, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // set the people
            self.people = people;
            // Update UI
            [self.tableView reloadData];
        });
    }];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


	return self.people.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSIPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell" forIndexPath:indexPath];
    
    LSIPerson *person = self.people[indexPath.row];
    
    cell.person = person;
    
    return cell;
}

@end
