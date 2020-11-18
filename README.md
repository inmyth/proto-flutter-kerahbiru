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
- pass a copy of the data to the next screen
- date in repo is stored as second, currently working date is stored as Integer.MAX

## Todo
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
