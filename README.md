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
1. Install Flutter Version Manager.
2. Run `fvm flutter pub get`.
3. Run `fvm flutter run`.

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
|   |   |-- app_sounds.dart
|   |   |-- audio_levels.dart
|   |   |-- audio_permissions.dart
|   |   |-- audio_service.dart
|   |   `-- game_audio_player.dart
|   |-- component
|   |   |-- app_back_button.dart
|   |   |-- game_page_card.dart
|   |   `-- header.dart
|   |-- enums
|   |   `-- end_score_screen_color.dart
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
|   |-- games
|   |   |-- balance_it
|   |   |-- hold_it
|   |   |   |-- hold_it_game.dart
|   |   |   |-- hold_it_scoring.dart
|   |   |   |-- hold_it_status.dart
|   |   |   `-- score.dart
|   |   |-- stop_it
|   |   |   |-- score.dart
|   |   |   |-- stop_it_game.dart
|   |   |   |-- stop_it_scoring.dart
|   |   |   `-- stop_it_status.dart
|   |   `-- tapme
|   |       |-- tapme_game.dart
|   |       `-- tapme_status.dart
|   `-- game_engine
|       |-- game_result.dart
|       `-- score.dart
`-- presentation
    |-- app
    |   |-- elder_quest_app.dart
    |   |-- home
    |   |   |-- home_page.dart
    |   |   `-- widgets
    |   |       |-- home_body.dart
    |   |       |-- home_grid.dart
    |   |       `-- home_tile.dart
    |   |-- intro
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
    |   `-- splash
    `-- games
        |-- balance_it
        |   |-- balance_it_animator.dart
        |   |-- balance_it_page.dart
        |   |-- balance_it_utils.dart
        |   `-- widgets
        |       |-- balance_it_board.dart
        |       |-- ball_widget.dart
        |       |-- scale_painter.dart
        |       |-- seesaw_base.dart
        |       `-- seesaw_plank.dart
        |-- hold_it
        |   |-- hold_it_page.dart
        |   `-- widgets
        |       |-- jar_fill.dart
        |       |-- jar_fill_markings_painter.dart
        |       |-- progress_indicator.dart
        |       `-- score_text.dart
        |-- shared
        |   |-- end_score
        |   |   |-- end_score_page.dart
        |   |   `-- widgets
        |   |       |-- end_score_actions.dart
        |   |       |-- end_score_action_text.dart
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
                |-- tapme_view_body.dart
                |-- tap_burst.dart
                `-- tap_button.dart
```

```
assets
|-- fonts
|   |-- Idiqlat-2.000
|   `-- Idiqlat-2.000.zip
|-- icons
|   |-- bg.svg
|   `-- clock.svg
|-- images
|   |-- balance_it.png
|   |-- beaker_hold_it.png
|   |-- licenses.txt
|   |-- logo.png
|   |-- stop_it_clock.png
|   |-- tap_it_click.png
|   `-- game_screenshots
|       |-- hold_it.jpg
|       |-- stop_it.jpg
|       `-- tap_me.jpg
|-- json
|   |-- data
|   |-- data.json
|   `-- level_config.json
`-- sounds
    |-- 90s-game-ui-6-185099.mp3
    |-- 90s-game-ui-7-185100.mp3
    |-- balance_it.mp3
    |-- bg.mp3
    |-- bg2.mp3
    |-- flip.mp3
    |-- flipcard.mp3
    |-- game-start-6104.mp3
    |-- out.mp3
    |-- robot-compute-beeps-1-171532.mp3
    |-- start.mp3
    |-- tapping.mp3
    |-- tick_tick.mp3
    `-- water_filling.mp3
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
3. Ensure the app builds with `fvm flutter run`.

## License
This project is licensed under the MIT License. See `LICENSE` for details.
