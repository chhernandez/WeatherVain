//
//  cdkClosetViewController.m
//  FashionExample
//
//  Created by Carlos Hernandez on 3/2/14.
//  Copyright (c) 2014 Carlos Hernandez. All rights reserved.
//

#import "cdkClosetViewController.h"
#import "cdkCellType.h"
#import "cdkMasterViewController.h"

@interface cdkClosetViewController ()

@end

@implementation cdkClosetViewController


-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;

}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.typeArray.count;
    
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    cdkCellType * aCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    aCell.myNewLabel.text = self.typeArray[indexPath.row];
    
 //   aCell.myNewLabel.text = [NSString stringWithFormat:@"Rating: "];

    //aCell.myTypeLabel.text = self.typeArray[indexPath.row];
    
    // to add image to the cell, add images with suffix numbering and use this code template:
    //aCell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"myImageIcon%d.jpg", imageNumber]];
    
    return aCell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.typeArray = @[@"Tops", @"Outerwear", @"Bottoms", @"Accessories", @"Shoes", @"One Piece"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    cdkMasterViewController *myListViewController = (cdkMasterViewController *)segue.destinationViewController;
    myListViewController.TypeList = [self.typeArray objectAtIndex:indexPath.row];
    
}

@end
