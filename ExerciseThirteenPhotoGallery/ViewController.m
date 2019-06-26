//
//  ViewController.m
//  ExerciseThirteenPhotoGallery
//
//  Created by Дмитрий Ванюшкин on 08/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "ViewController.h"
#import "GRPFiltersFactory.h"

@interface ViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView* photoResult;
@property (nonatomic, strong) UITableView* filtersTable;
@property (nonatomic, copy) NSArray<GRPFiltersModel*> *filtersArray;
@property (nonatomic, strong) GRPFiltersFactory *filtersFactory;
@property (nonatomic, strong) CIContext *context;
@property (nonatomic, assign) CIImage *beginImage;

@end

@implementation ViewController

//@dynamic beginImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _photoResult = [[UIImageView alloc] init];
    [self.view addSubview:_photoResult];
    
    self.photoResult.backgroundColor = UIColor.lightGrayColor;
    
    _filtersTable = [UITableView new];
    
    [self setAllFilters];
    
    [self.filtersTable registerClass:UITableViewCell.self forCellReuseIdentifier:@"cell"];
    
    self.context = [CIContext contextWithOptions:nil];
    
    self.filtersTable.delegate = self;
    self.filtersTable.dataSource = self;
    
    [self.view addSubview:self.filtersTable];
    
    [self setupNavigationBar];
    [self setupConstraints];
    // Do any additional setup after loading the view.
}

#pragma mark setup Appearance

-(void) setupNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(savePhoto)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Photo" style:UIBarButtonItemStyleDone target:self action:@selector(makePhoto)];
                                
}

-(void) setAllFilters
{
    _filtersFactory = [GRPFiltersFactory new];
    _filtersArray = [NSArray arrayWithObjects:[self.filtersFactory createMaskToAlpha], [self.filtersFactory createPhotoEffectTransferMode], [self.filtersFactory createGaussianBlur], [self.filtersFactory createNoirEffect], [self.filtersFactory createSmoothLinearGradient],[self.filtersFactory createFalseColor],nil];
}

-(void) setupConstraints
{
    self.photoResult.translatesAutoresizingMaskIntoConstraints = NO;
    self.filtersTable.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.photoResult.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.photoResult.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [self.photoResult.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    [self.photoResult.heightAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    
    [self.filtersTable.topAnchor constraintEqualToAnchor: self.photoResult.bottomAnchor].active = YES;
    [self.filtersTable.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [self.filtersTable.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    [self.filtersTable.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    
    
    
}

#pragma mark Actions for buttons

-(void) savePhoto
{
    
    if (self.photoResult.image != nil)
    {
//        UIImageWriteToSavedPhotosAlbum(self.photoResult.image, self, @selector(ouputShit), nil);
        UIImageWriteToSavedPhotosAlbum(self.photoResult.image, nil, nil, nil);
    }

}

-(void) ouputShit
{
    NSLog(@"FREEEE");
}

-(void) makePhoto
{
    
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if ([UIImagePickerController isSourceTypeAvailable:type])
    {
        UIImagePickerController *controller = [UIImagePickerController new];
        controller.sourceType = type;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:type];
//        [self presentViewController:controller animated:YES completion:nil];
        [self.navigationController presentViewController:controller animated:YES completion:^{}];
        controller.delegate = self;
        
    }

//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//          [self presentViewController:controller animated:YES completion:nil];
//    }
//
}
#pragma mark presenting and saving images

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info
{
    
    UIImage* chosenImage = info[UIImagePickerControllerOriginalImage];
    self.photoResult.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    GRPFiltersModel* currentModel = self.filtersArray[indexPath.row];
    
    cell.textLabel.text = currentModel.name;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filtersArray.count;
}

-(void)setBeginImage:(CIImage *)beginImage
{
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GRPFiltersModel* currentFilter = self.filtersArray[indexPath.row];
    
    if (self.photoResult.image != nil)
    {
        
        UIImageOrientation originalOrientation = self.photoResult.image.imageOrientation;
        
        CGImageRef startCGImage = self.photoResult.image.CGImage;
        CGImageRetain(startCGImage);
        CIImage* beginImage = [CIImage imageWithCGImage:startCGImage];

        CIContext *context = self.context; //
        
        NSMutableDictionary<NSString *, id> *params = [currentFilter.parameters mutableCopy];
        [params setObject: beginImage forKey:kCIInputImageKey];
        CIFilter *filter = [CIFilter filterWithName:currentFilter.name withInputParameters:params];
        
        CIImage *resultCIImage =  [filter outputImage];
        
        CGImageRef cgImg = [context createCGImage:resultCIImage fromRect:[resultCIImage extent]];
        
        
        UIImage* editedImage = [UIImage imageWithCGImage:cgImg scale:1.0 orientation:originalOrientation];
        self.photoResult.image = editedImage;
        
        CGImageRelease(cgImg);
        CGImageRelease(startCGImage);
        
    }
    
}

@end
