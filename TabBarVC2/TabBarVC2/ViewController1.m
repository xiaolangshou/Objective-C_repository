//
//  ViewController1.m
//  TabBarVC2
//
//  Created by Liu Tao on 2020/2/19.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController1.h"
#import "Utility.m"

@interface ViewController1 ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation ViewController1

+ (id)sharedInstance {
    static ViewController1 *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"init with coder...");
    }
    return self;
}

// loadView 不能直接调用
- (void)loadView {
    [super loadView];
    NSLog(@"loadView...");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"view did load...");
    
    self.view.backgroundColor = UIColor.blueColor;
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"view will appear...");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"view did appear...");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSLog(@"view will layout sub views...");
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSLog(@"view did layout subviews...");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"view will disappear...");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"view did disappear...");
}

- (void)setupView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, getRectNavAndStatusHight, screenWidth, screenHeight - getRectNavAndStatusHight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataArr = [NSMutableArray arrayWithObjects: @"a",@"b",@"c",@"d",nil];

}

// datasource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    
    cell.textLabel.text = [self.dataArr[indexPath.row] stringByAppendingString:@"--"];
    cell.detailTextLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
@end
