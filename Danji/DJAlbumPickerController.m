//
//  DJAlbumPickerController.m
//  Danji
//
//  Created by miyaeyo on 2015. 10. 27..
//  Copyright (c) 2015년 miyaeyo. All rights reserved.
//

#import "DJAlbumPickerController.h"
#import "DJAssetPickerController.h"

@implementation DJAlbumPickerController
{
    ALAssetsLibrary                     *mLibrary;
    NSMutableArray                      *mAssetGroups;
    __weak id<DJAssetSelectionDelegate> mDelegate;
    NSUInteger                          mIndexForSegue;
}

@synthesize delegate = mDelegate;

#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViewAttributes];
    
    mAssetGroups = [[NSMutableArray alloc] init];
    mLibrary = [[ALAssetsLibrary alloc] init];
    
    [[self tableView] setDataSource:self];
    [[self tableView] setDelegate:self];
    
    [self loadAlbums];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    mLibrary = nil;
    mAssetGroups = nil;
   // mDelegate = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:ALAssetsLibraryChangedNotification object:nil];
    
    [self reloadTableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALAssetsLibraryChangedNotification object:nil];
}

#pragma mark - table view

- (void)reloadTableView
{
    [[self tableView] reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mAssetGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"albumCell"];
    
    ALAssetsGroup *assetGroup = [mAssetGroups objectAtIndex:[indexPath row]];
    [assetGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger assetCount = [assetGroup numberOfAssets];
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ (%ld)", [assetGroup valueForProperty:ALAssetsGroupPropertyName], assetCount]];
    UIImage *albumThumbnail = [UIImage imageWithCGImage:[assetGroup posterImage]];
    albumThumbnail = [self resizeImage:albumThumbnail toNewSize:CGSizeMake(78, 78)];
    [[cell imageView] setImage:albumThumbnail];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    mIndexForSegue = [indexPath row];
    [self performSegueWithIdentifier:@"openAlbum" sender:self];
}


#pragma mark - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"openAlbum"])
    {
        id destController = [[[segue destinationViewController] viewControllers] objectAtIndex:0];
        [destController setDelegate:self];
        [destController setAssetGroup:[mAssetGroups objectAtIndex:mIndexForSegue]];
    }
}


- (void)selectedAssets:(NSArray *)assets
{
    [mDelegate selectedAssets:assets];
}


#pragma mark action

- (IBAction)calcelButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark - private

- (void)setupViewAttributes
{
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)loadAlbums
{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^
    {
        @autoreleasepool
        {
            void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
            {
                if (group == nil)
                {
                    NSLog(@"group nil");
                    return;
                }
                
                NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                
                if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos)
                {
                    [mAssetGroups insertObject:group atIndex:0];
                }
                else
                {
                    [mAssetGroups addObject:group];
                }
                
                [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
                
            };
            
            void (^assetGroupEnumeratorFailure)(NSError *) = ^(NSError *error)
            {
                if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied)
                {
                    [[[UIAlertView alloc] initWithTitle:@"Acess Denied"
                                                message:@"This app does not have access to your photos"
                                               delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil, nil] show];
                }
                else
                {
                    [[[UIAlertView alloc] initWithTitle:@"Album Error"
                                                message:[NSString stringWithFormat: @"%@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]]
                                               delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil, nil] show];
                }
                
                [[self navigationItem] setTitle:nil];
                NSLog(@"%@", [error description]);
            };
            [mLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:assetGroupEnumerator failureBlock:assetGroupEnumeratorFailure];
        }
    });
    
}

- (UIImage *)resizeImage:(UIImage *)image toNewSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
