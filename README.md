# obd2-car-tracker

### TODO

- Create SelectMode UI
     - add shadow to cells
     - dark mode only
     - adjust icons of imageView inside mosaic tiles
- Create history of data in order to understand when a trouble error occurred and in which condition (low fuel pressure, ...)
- CarInfoView (UI)
     - Use Strategy Pattern to show a specific UI where:
        - Object using a Strategy: CarInfoViewController
        - Strategy Protocol: ModeSelector <<Protocol>>
        - Concrete Strategies: (Telemetry View, Hystorical View, Current Data view, Trouble Codes View, ...)  
     - Set some effects when model changes
- Implement Authentication
    - Implement Authentication UI
    - Authentication Model
    - For every user is reserved a space where its car info persist
        - (Optional) Every user can store multiple car data
    - Automatic log in  
    - Log in with Google, Apple

### DONE

- Check async connection state
- Async retrieving car info (trouble codes, engine, chassis, other)
- Separate the Model from the View
- Every time I want to add/remove/rename an attribute or a info value type. The other code does not need changes.
- model changes => automatically the CarInfoViewController changes the view
- MosaicMenuLayout
- Allowed portrait mode only
