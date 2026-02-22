# ElderQuest

ElderQuest is a collection of mini games built in Flutter. The codebase focuses on clean architecture, readable UI, and reusable game components while keeping each game small and focused.

## Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Folder Structure](#folder-structure)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)

## Overview
ElderQuest ships multiple mini games such as Tap Me, Stop It, and Hold It. Each game has its own domain and application logic, while shared UI and theme utilities live under `core` and `presentation`.

## Installation
1. Install Flutter SDK (3.10+).
2. Run `flutter pub get`.
3. Run `flutter run`.

## Folder Structure
```
lib
|-- bootstrap.dart
|-- main.dart
|-- application
|   |-- root_bloc_scope.dart
|   |-- app
|   |   |-- initialize_app.dart
|   |   `-- load_user_profile.dart
|   `-- games
|       |-- balance_it
|       |-- hold_it
|       |   |-- hold_it_bloc.dart
|       |   |-- hold_it_event.dart
|       |   `-- hold_it_state.dart
|       |-- stop_it
|       |   |-- stop_it_bloc.dart
|       |   |-- stop_it_event.dart
|       |   `-- stop_it_state.dart
|       `-- tapme
|           |-- tapme_bloc.dart
|           |-- tapme_event.dart
|           `-- tapme_state.dart
|-- core
|   |-- audio
|   |   |-- audio_levels.dart
|   |   |-- audio_permissions.dart
|   |   |-- audio_service.dart
|   |   `-- game_audio_player.dart
|   |-- component
|   |   |-- app_back_button.dart
|   |   |-- game_page_card.dart
|   |   `-- header.dart
|   |-- localization
|   |   |-- l10n.dart
|   |   `-- arb
|   |       |-- app_en.arb
|   |       |-- app_es.arb
|   |       `-- app_hi.arb
|   |-- storage
|   |   `-- shared_prefs_keys.dart
|   |-- theme
|   |   |-- app_colors.dart
|   |   |-- app_radius.dart
|   |   |-- app_spacing.dart
|   |   |-- app_text_styles.dart
|   |   `-- app_theme.dart
|   `-- ui
|       |-- components
|       `-- widgets
|-- domain
|   |-- game_engine
|   |   |-- game_result.dart
|   |   `-- score.dart
|   `-- games
|       |-- balance_it
|       |-- hold_it
|       |   |-- hold_it_game.dart
|       |   |-- hold_it_scoring.dart
|       |   |-- hold_it_status.dart
|       |   `-- score.dart
|       |-- stop_it
|       |   |-- score.dart
|       |   |-- stop_it_game.dart
|       |   |-- stop_it_scoring.dart
|       |   `-- stop_it_status.dart
|       `-- tapme
|           |-- tapme_game.dart
|           `-- tapme_status.dart
`-- presentation
    |-- app
    |   |-- elder_quest_app.dart
    |   |-- home
    |   |   |-- home_page.dart
    |   |   `-- widgets
    |   |       |-- home_body.dart
    |   |       |-- home_grid.dart
    |   |       `-- home_tile.dart
    |   |-- loading
    |   |   `-- loading_page.dart
    |   |-- routing
    |   |   `-- app_router.dart
    |   `-- settings
    |       |-- settings_page.dart
    |       `-- widgets
    |           |-- footer_text.dart
    |           |-- header_bar.dart
    |           |-- section_title.dart
    |           |-- settings_body.dart
    |           |-- slider_row.dart
    |           `-- toggle_row.dart
    `-- games
        |-- balance_it
        |   `-- balance_it_page.dart
        |-- hold_it
        |   |-- hold_it_page.dart
        |   `-- widgets
        |       |-- jar_fill.dart
        |       |-- progress_indicator.dart
        |       `-- score_text.dart
        |-- shared
        |   |-- end_score
        |   |   |-- end_score_page.dart
        |   |   `-- widgets
        |   |       |-- end_score_actions.dart
        |   |       |-- end_score_header.dart
        |   |       `-- end_score_summary.dart
        |   `-- game_intro
        |       |-- game_intro_page.dart
        |       |-- level_config.dart
        |       `-- widgets
        |           |-- difficulty_slider.dart
        |           |-- game_intro_difficulty.dart
        |           |-- game_intro_header.dart
        |           `-- game_intro_play_button.dart
        |-- stop_it
        |   |-- stop_it_page.dart
        |   `-- widgets
        |       |-- led_display_panel.dart
        |       |-- seven_segment_display.dart
        |       |-- stop_button.dart
        |       `-- timer_display.dart
        `-- tapme
            |-- tapme_page.dart
            `-- widgets
                |-- score_text.dart
                `-- tap_button.dart
```

```
assets
|-- images
|-- json
|-- sounds
`-- fonts
```

## Dependencies
- Flutter SDK: UI framework and tooling.
- cupertino_icons: iOS-style icons.
- flutter_bloc: state management with predictable events and states.
- flutter_hooks: functional widget state and lifecycle helpers.
- go_router: declarative routing and navigation.
- share_plus: share score images and text.
- screenshot: capture game results for sharing.
- google_fonts: easy access to custom fonts.
- just_audio: background music and sound effects playback.
- shared_preferences: local persistence for settings.

## Contributing
1. Create a feature branch.
2. Keep changes focused and small.
3. Ensure the app builds with `flutter run`.

## License
This project is licensed under the MIT License. See `LICENSE` for details.
