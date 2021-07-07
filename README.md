# obd2-car-tracker

### SelectMenuView (Dark/Light Mode)
| Dark Mode | Light Mode |
| --------- | ---------- |
| <img src="https://github.com/marcomarinodev/obd2-car-tracker/blob/main/screenshots/menuDark.png" width="300"> | <img src="https://github.com/marcomarinodev/obd2-car-tracker/blob/main/screenshots/menuLight.png" width="300"> |

### TODO
- Unit Testing (Test Driven Development)
- When using the car info view and there is a dark mode switch, the UI does not changes automatically, user need to close the view and reopen it
- Create history of data in order to understand when a trouble error occurred and in which condition (low fuel pressure, ...)
- Reorganize database structure in order to support more users with more cars
- CarInfoView (UI)
     - Set some effects when model changes
- Implement Authentication
    - Implement Authentication UI
    - Authentication Model
    - For every user is reserved a space where its car info persist
        - (Optional) Every user can store multiple car data
    - Automatic log in  
    - Log in with Google, Apple

### DONE
- CarInfoViewController uses strategy pattern, so it is not responsible to draw the UI
    - Car Info Drawer is the protocol, so to create a new design and test it, you need to create a class that conforms to that protocol
- Check async connection state
- Async retrieving car info (trouble codes, engine, chassis, other)
    - when Firebase API detects some changes in the Realtime database, UI updates
- Model separated from the View
- Every time I want to add/remove/rename an attribute or a info value type. The other code does not need changes.
- MosaicMenuLayout, reusable
- Dark mode
- Transition using Delegate from SelectModeViewController and CarInfoViewController
