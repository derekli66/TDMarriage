

#import <UIKit/UIKit.h>

@interface TDViewController : UIViewController
<UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate,
UIActionSheetDelegate>
{
    TDGuest *_selectedGuest;
}
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *guestsArray;
@end
