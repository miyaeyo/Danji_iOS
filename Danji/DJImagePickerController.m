//
//  DJImagePicker.m
//  Danji
//
//  Created by miyaeyo on 2015. 11. 2..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "DJImagePickerController.h"
#import "DJAsset.h"


@implementation DJImagePickerController
{
    __weak id<DJImagePickerControllerDelegate> mDelegate;
    NSInteger mMaxSelectionCount;
}

@synthesize imageDelegate = mDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[[self viewControllers] objectAtIndex:0] setDelegate:self];
    
    mMaxSelectionCount = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - asset selection delegate

- (void)selectedAssets:(NSArray *)assets
{
    NSMutableArray *returnImages = [[NSMutableArray alloc] init];
    
    for (DJAsset *aAsset in assets)
    {
        ALAsset *asset = [aAsset asset];
        
        id object = [asset valueForProperty:ALAssetPropertyType];
        if (!object)
        {
            continue;
        }
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        CLLocation *location = [asset valueForProperty:ALAssetPropertyLocation];
        if (location)
        {
            [dictionary setObject:location forKey:ALAssetPropertyLocation];
        }
        
        [dictionary setObject:object forKey:UIImagePickerControllerMediaType];
        
        ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
        
        if (assetRepresentation)
        {
            CGImageRef imageRef = [assetRepresentation fullScreenImage];
            UIImage *image = [UIImage imageWithCGImage:imageRef
                                                 scale:1.0f
                                           orientation:UIImageOrientationUp];
            
            [dictionary setObject:image forKey:UIImagePickerControllerOriginalImage];
            [dictionary setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]]
                           forKey:UIImagePickerControllerReferenceURL];
            
            [returnImages addObject:dictionary];
        }
    }
    
    if (mDelegate != nil && [mDelegate respondsToSelector:@selector(DJImagePickerController:didFinishPickingImages:)])
    {
        [mDelegate performSelector:@selector(DJImagePickerController:didFinishPickingImages:)
                        withObject:self
                        withObject:returnImages];
    }
}


@end
