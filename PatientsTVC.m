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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObjectContext *context = [self managedObjectContext];
        Patient *patientToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];

        [context deleteObject:patientToDelete];

        //save changes

        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error %@", error);
        }
    }
}


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

#pragma mark - Fetch Results Controller Delegates

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{

    [self.tableView endUpdates];
}

//What kind of update happened? this is where we take a look at each potential change.

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{

    UITableView *tableView = self.tableView;// create temporary placeholder

    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

        case NSFetchedResultsChangeUpdate: {
            Patient *changePatient = [self.fetchedResultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = changePatient.patientLastName;

        }
            break;

            case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];

            break;

        default:
            break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{

    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;

        default:
            break;
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
