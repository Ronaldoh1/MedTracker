//
//  Prescription+CoreDataProperties.h
//  MedTracker
//
//  Created by Ronald Hernandez on 11/25/15.
//  Copyright © 2015 HardCoders. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Prescription.h"

NS_ASSUME_NONNULL_BEGIN

@interface Prescription (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *prescriptionName;
@property (nullable, nonatomic, retain) NSString *prescriptionInstruction;
@property (nullable, nonatomic, retain) NSManagedObject *patient;

@end

NS_ASSUME_NONNULL_END
