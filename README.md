# SwiftUICityMap

<img src="https://github.com/user-attachments/assets/a71b6b14-ce23-4474-a7e8-39876703e38f" width="50%" />

<img src="https://github.com/user-attachments/assets/7af6fed7-1eab-4538-924f-9af1d810f4c7" width="50%" />

<img src="https://github.com/user-attachments/assets/e9132dac-c9a4-4c27-9c02-16ee5f7c043e" width="50%" />

## Implementation Criteria

The architecture chosen for both features, the city list view and the map view, was based on view models, each with their respective interfaces.

In the city list view model, instances of both the Storage and Repository are injected, responsible for managing the UserDefaults preferences and the backend/BFF calls, respectively.

For the city list feature, I thought it would be a good idea to use a state machine to better leverage SwiftUI's reactivity.

The networking layer is built using async/await, as Combine is being discontinued. It has its own protocol and the performRequest method, which accepts basic parameters because the call didn't require many details—it's not adapted to receive parameters, intercept, or add headers. Basic error cases are handled, and the decodable type is also passed.

The model for a city, CityModel, was initially a struct, but as the requirements evolved—especially regarding marking a city as a favorite—I found it more useful and simpler to handle it as a class. Although the favorites are persisted using UserDefaults, it was more convenient to manage it as a reference type and take advantage of mutability rather than forcing changes on a value type.

City loading is done through infinite scrolling. From the front-end, pagination is calculated and more cities are added as the user scrolls and reaches the last item in the list. A single fetch is made to the service in the view model's initializer using a task. This way, I avoid refetching the data when going back from the map screen, and the cities are already loaded. Honestly, I didn't like this approach much, but after reviewing memory usage, it stays between 60 and 70MB, and I didn't have time to refactor it. Another option would have been to save the JSON response in local storage, customize it, and index it, already sorted by a specific criterion, and then load it in pages. Another approach could have been to have the backend ready to receive a page parameter.

Once the cities are fetched, all filter management is done using higher-order functions applied to the resulting list. Regarding search criteria, I thought that if the user types 1 or 2 letters in the search bar, the filter should be applied to the list already loaded in the view. Otherwise, the filter would be applied to the full list, and it would also be paginated.

For the views, I used a ListView. I'm not a big fan of it because I prefer using ScrollView to customize interface details, but I understand that ListView is more efficient. I read that one requirement was to add a button (besides the favorite button) to see more details about the city. Honestly, I didn't think it was necessary. First, because I didn't have an object with much more information to show, since the cell already had the city name and country in the title, and the coordinates as the subtitle. I tried a bottom sheet but later removed it, then I experimented with expandable cells but didn't like the animation. Finally, I decided to add the information as a popover from the map, from the marker, which makes more sense. Also, it's bad practice to have multiple buttons in a cell; there were three actions triggered—tapping the cell to navigate to the map, saving to favorites, and viewing info. It felt too overloaded.

What I still need to do are the tests. The reality is that two days is not enough time, and that's what I had. Of course, it was even less due to other life commitments, but I tried to cover as many aspects as I could in this short period. As a nice-to-have, it would have been great to have a tab solely for viewing the favorite cities.

It was a fun project to work on, and if you have any questions or need further clarification, feel free to reach out.
