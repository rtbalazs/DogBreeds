# DogBreeds
WooliesX iOS technical assesment. Present a list of dogs and sort them.


## Requirements
Implementation Details:

- API to be consumed - https://api.thedogapi.com/v1/images/search?limit=50
- On App launch make a call to the API to retrieve the data
- Display the data in a UITableView.(At a minimum display name, life-span, image)
- A button at top of tableview allows data to be sorted ascending/descending by life-span
- Min iOS version: iOS 12 Xcode version: 11.x

## Considerations
- Network requests are based default URLSession with basic error handling for the purpose of example. 
- Image caching is basic
- ViewModel and Store object are managed by the ViewController to avoid implementing a notification mechanism upon model update from viewModel to ViewController.
- Idealy, the cell representing a dog, would have a view model as well, ommited here to keep things simple, and passed the values to be represented directly
- Unit tests are done for the models, and view models as examples. 

