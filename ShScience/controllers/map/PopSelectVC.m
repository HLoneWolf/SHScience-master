//
//  PopSelectVC.m
//  ShScience
//
//  Created by qiya on 16/3/2第10周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "PopSelectVC.h"
#import "AutocompletionTableView.h"
#import "RecommandMapVC.h"

@interface PopSelectVC ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong) AutocompletionTableView *autoCompleter;


@end

@implementation PopSelectVC


- (AutocompletionTableView *)autoCompleter
{
    if (!_autoCompleter)
    {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:2];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];
        
        _autoCompleter = [[AutocompletionTableView alloc] initWithTextField:self.searchTextField inViewController:self withOptions:options];
        _autoCompleter.autoCompleteDelegate = self;
        _autoCompleter.suggestionsDictionary = [NSArray arrayWithObjects:@"hostel",@"caret",@"carrot",@"house",@"horse", nil];
    }
    return _autoCompleter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.searchTextField addTarget:self.autoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - AutoCompleteTableViewDelegate

- (NSArray*) autoCompletion:(AutocompletionTableView*) completer suggestionsFor:(NSString*) string{
    // with the prodided string, build a new array with suggestions - from DB, from a service, etc.

    return [NSArray arrayWithObjects:@"hostel",@"caret",@"carrot",@"house",@"horse", nil];
}

- (void) autoCompletion:(AutocompletionTableView*) completer didSelectAutoCompleteSuggestionWithIndex:(NSInteger) index{
    // invoked when an available suggestion is selected
    NSLog(@"%@ - Suggestion chosen: %ld", completer, (long)index);
    _selectId = @"hello";
    //[self dismissViewControllerAnimated:NO completion:nil];
    //[_callBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
//    _delgate
    RecommandMapVC *vc = (RecommandMapVC *)_delgate;
    [vc done:_selectId];
}

@end
