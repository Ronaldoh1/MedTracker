//
//  PatientsTVC.h
//  MedTracker
//
//  Created by Ronald Hernandez on 11/25/15.
//  Copyright © 2015 HardCoders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "PrescriptionTVC.h"


@interface PatientsTVC : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) Patient *patient;


@end
