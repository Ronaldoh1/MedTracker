//
//  PatientsTVC.m
//  MedTracker
//
//  Created by Ronald Hernandez on 11/25/15.
//  Copyright © 2015 HardCoders. All rights reserved.
//

#import "PatientsTVC.h"
#import "AppDelegate.h"
#import "AddPatientVC.h"

@interface PatientsTVC ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


//We perform a fetch request

@end

@implementation PatientsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    //Implement the FetchRequest.

    NSError *error = nil;

    if (![[self fetchedResultsController]performFetch:&error]) {
        NSLog(@"Error! %@", error);
        abort();
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - Core Data Methods

-(NSManagedObjectContext *)managedObjectContext{

    return [(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectContext];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections]objectAtIndex:section];

    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...

    Patient *patient = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = patient.patientLastName;
    cell.detailTextLabel.text = patient.patientFirstName;

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    //ask Segue identiferi
    UINavigationController *nav = segue.destinationViewController;
     //AddPatientVC *addPatientVC = (AddPatientVC *)[segue destinationViewController];


    if ([segue.identifier isEqualToString:@"addPatient"]) {
        


        Patient *addPatient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:[self managedObjectContext]];

        AddPatientVC *addPatientVC = (AddPatientVC *)[nav topViewController];

        addPatientVC.addPatient = addPatient;
    }


}


#pragma mark - Fetched Results Controller Section 

-(NSFetchedResultsController *)fetchedResultsController{

    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    //if you dont have one, you have to create it.

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];

    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Patient" inManagedObjectContext:context];

    [fetchRequest setEntity:entity];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"patientLastName" ascending:YES];

    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];


    fetchRequest.sortDescriptors = sortDescriptors;

    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];


    _fetchedResultsController.delegate = self;

    return _fetchedResultsController;
}

@end
