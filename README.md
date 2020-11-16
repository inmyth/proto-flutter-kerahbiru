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
    - setState will trigger rebuild on any widget that holds reference to the data. If stateless screenA passes data to stateful screenB and there the data is modified inside setState then the widget in screeA is also rebuilt.
- pass a copy of the data to the next screen

## Todo
- splash screen
- new user registration
    - could use stepper
- theme
- locale
