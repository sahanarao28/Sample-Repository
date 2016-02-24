//
//  DPQuotationTableViewController.m
//  DemoProject
//
//  Created by Niranjan K N on 15/07/14.
//  Copyright (c) 2014 Mindtree. All rights reserved.
//

#import "DPQuotationTableViewController.h"
#import "DPServiceManager.h"
#import "DPConstants.h"
#import "DPQuotation.h"

@interface DPQuotationTableViewController ()

@property (nonatomic,retain) NSMutableArray * quotationInformation;

@end


@implementation DPQuotationTableViewController

@synthesize quotationInformation;


#pragma mark - Initialization method

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DPServiceManager sendSyncRequestWithURL:vLatestQuotationOrderURL method:DPServiceReqestHTTPMethodPOST body:nil header:nil completionBlock:^(BOOL iSucceeded, id iResponseObject) {
        
        LOG("Service request did Succeed? : %d", iSucceeded);
		LOG("Response is : %@", iResponseObject);
        
        quotationInformation = [iResponseObject objectForKey:@"quotation Information"];
        LOG("%@",quotationInformation);
        
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [quotationInformation count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DPQuotation * quotationData = [[DPQuotation alloc]init];
    quotationData.quotationID = [[quotationInformation objectAtIndex:indexPath.row] valueForKey:@"ID"];
    quotationData.status = [[quotationInformation objectAtIndex:indexPath.row] valueForKey:@"Status"];
    
    static NSString *cellIdentifier=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    // Configure the cell...
    UILabel *quotationInformationIDLabel = (UILabel*)[cell viewWithTag:1];
    UILabel *quotationInformationStatusLabel = (UILabel*)[cell viewWithTag:2];
    
    quotationInformationIDLabel.text = quotationData.quotationID;
    quotationInformationStatusLabel.text = quotationData.status;
    
    return cell;
}

@end
