# obd2-car-tracker

### TODO

- CarInfoView (UI)
    - Set some effects when model changes
- Implement Authentication
    - Implement Authentication UI
    - Authentication Model
    - For every user is reserved a space where its car info persist
    - Automatic log in  
    - Log in with Google, Apple

### DONE

- Check async connection state
- Async retrieving car info (trouble codes, engine, chassis, other)
- Separate the Model from the View
- Every time I want to add/remove/rename an attribute or a info value type. The other code does not need changes.
- model changes => automatically the CarInfoViewController changes the view
