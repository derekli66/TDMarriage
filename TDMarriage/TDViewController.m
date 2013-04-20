

#import "TDViewController.h"

@interface TDViewController ()

@end

@implementation TDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.guestsArray = [[CoreDataManager sharedManager] getAllGuests];
        
    self.searchBar.showsCancelButton = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count: %d", [self.guestsArray count]);
    return [self.guestsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SelectionCell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    TDGuest *aGuest = (TDGuest *)[self.guestsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = aGuest.name;
    cell.detailTextLabel.text = aGuest.tableID;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDGuest *aGuest = (TDGuest *)[self.guestsArray objectAtIndex:indexPath.row];
    
    if ([aGuest.checkBox integerValue] == 1) {
        cell.textLabel.textColor = [UIColor darkTextColor];
        cell.detailTextLabel.textColor = [UIColor brownColor];
    }else if([aGuest.checkBox integerValue] == 2){
        cell.textLabel.textColor = [UIColor blueColor];
        cell.detailTextLabel.textColor = [UIColor blueColor];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _selectedGuest = [_guestsArray objectAtIndex:indexPath.row];
    
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"賓客確認"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:@"已到"
                                                    otherButtonTitles:@"未到", @"取消", nil];
    [actionsheet showInView:self.view];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText != nil && [searchText length] != 0) {
        
        if ([searchText isEqualToString:@"未到"]) {
            self.guestsArray = [[CoreDataManager sharedManager] getAllAbsence];
            [self.tableView reloadData];
            return;
            
        }else if([searchText isEqualToString:@"已到"]){
            self.guestsArray = [[CoreDataManager sharedManager] getAllArrived];
            [self.tableView reloadData];
            return;
            
        }else{
            self.guestsArray = [[CoreDataManager sharedManager] getGuestListByName:searchText];
            [self.tableView reloadData];
            return;
            
        }
        
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text != nil && [searchBar.text length] != 0) {
        
        if ([searchBar.text isEqualToString:@"未到"]) {
            self.guestsArray = [[CoreDataManager sharedManager] getAllAbsence];
            [self.tableView reloadData];
                [searchBar resignFirstResponder];
            return;
            
        }else if([searchBar.text isEqualToString:@"已到"]){
            self.guestsArray = [[CoreDataManager sharedManager] getAllArrived];
            [self.tableView reloadData];
                [searchBar resignFirstResponder];
            return;
            
        }else{
            self.guestsArray = [[CoreDataManager sharedManager] getGuestListByName:searchBar.text];
            [self.tableView reloadData];
                [searchBar resignFirstResponder];
            return;
            
        }
        
    }
    
//    self.guestsArray = [[CoreDataManager sharedManager] getGuestListByName:searchBar.text];
//    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.guestsArray = [[CoreDataManager sharedManager] getAllGuests];
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

#pragma mark - UIActionSheetDelegate
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex: %d", buttonIndex);
    switch (buttonIndex) {
        case 0:
            _selectedGuest.checkBox = [NSNumber numberWithInteger:2];
            break;
        case 1:
            _selectedGuest.checkBox = [NSNumber numberWithInteger:1];
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
    
    [[[CoreDataManager sharedManager] managedObjectContext] save:nil];
    [self.tableView reloadData];
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    
}
@end
