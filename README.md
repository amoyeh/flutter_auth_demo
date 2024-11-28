### flutter_auth project

This is a simple Flutter project designed to manage user authentication and control user access with path routing, with the following features:

-  `bloc` to manage global member state
-  `Hydrated_bloc` to persist member state (states are saved in platform-specific storage)
-  `go_router` to handle route management
-  `StatefulShellRoute` to maintain a bottom navigation bar across different pages
-  Integration of `bloc` with `go_router` to redirect users to member-only or guest-only pages based on state changes
   -  if user is already signed in when page loads and remains on then sign-in page, redirect them to member path /me page
   -  if user is not signed in and tries to load member only pages, redirect them to the front page

Cheers ! 🍺
