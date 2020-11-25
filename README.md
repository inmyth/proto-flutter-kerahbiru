# KerahBiru Flutter Prototype

Uses **Provided**design pattern. Guides:
- [Change Notifier + Provider Example](https://github.com/brianegan/flutter_architecture_samples).
- [Simple State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)

## Architecture guideline
- screen : reloads / get complete data from API
- sub-screen: patch / partial upload, optimistic update (local update only with positive result assumed)
- model : the model
- entity : model used by repository
- state :  model used by view to store and manage state
    - extends (ChangeNotifier)[https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple]
    - broadcasts updates with notifyListeners
- stateful widget : widget that changes on UI state, read [this](https://stackoverflow.com/questions/51931017/update-ui-after-removing-items-from-list)
    - setState will trigger rebuild on any widget that holds reference to the data.
    - parent-child relations : parent cannot call child but triggers change due to child using parent (widget.) [read](https://stackoverflow.com/questions/48481590/how-to-set-update-state-of-statefulwidget-from-other-statefulwidget-in-flutter)
- semi-optimistic approach A
    - consider two pages: main, ephemeral
    - main pages fetch data from repo, stores it in local.
    - ephemeral pages use local data. any rest interaction here is assumed successful and modifies local data.
    - in main page, do reload to refetch data from API
    - requires back intercept positioning
```
  Profile -> sends a copy of experience list to -> Edit Profile -> opens a -> New Profile

  new Profile -> sends an REST patch, adds an item of list in -> Edit Profile Screen -> triggers reload in -> Profile
```
- semi-optimistic approach B
    - upload object with pending id
    - object is assumed live in app
    - on API callback, remove or preserve
- date in repo is stored as second, currently working date is stored as Integer.MAX
- reload page depending on new updates
    - updating state object in State (ChangeNotifier) triggers any Selector that monitors it
    - use WillPopScope to intercept device's back button
- pages that depend on same inheritance object should be generalized (see CommonItem)

## Todo
- [x] complete prototype of approach A (Experience item)
    - complete ir for the rest of the items
- [x] reload if new updates
- [x] page animation proto (profile -> edit)
- page animation (edit -> new or form)
- refactor edit returned models
- refactor extracted views
- date picker for exp end date
    - [x] has upper limit(a month before now) and lower limit
    - [x] "currently working" checkbox will disable End Date and its date picker
    - [x] validates start date < end date
- global keys
- global formats (date, currency, etc)
- [x] splash screen
- new user registration
    - could use stepper
- theme
- locale
