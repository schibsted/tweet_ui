# Changelog
All notable changes to Tweet UI project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- Updated video_player, photo_view, url_launcher, chewie
- Updates JSON examples

## [1.2.0] - 28.02.2020 
### Added
- Added possibility to change the created timestamp date format.
### Changed
- Converting time when tweet was created to local time.

## [1.1.0] - 05.02.2020 
### Changed
- Added displaying time when tweet was created. For now only 24H format
- Updated intl, video_player, photo_view
### Fixed
- Fixed default tweet text color when entities array was empty

## [1.0.0] - 03.01.2020 
- Updated cached_network_image, video_player and url_launcher
- Updated JSON examples

## [0.2.0-rc.1] - 25.11.2019 
### Changed
- Updated cached_network_image, video_player, photo_view and url_launcher

## [0.1.1+7] - 25.10.2019 
### Changed
- Revert updating cached_network_image, photo_view packages

## [0.1.1+6] - 25.10.2019 
(version bump)

## [0.1.1+5] - 25.10.2019
### Changed
- Fix cached_network_image and photo_view dependency version range

## [0.1.1+4] - 25.10.2019
### Changed
- Updated cached_network_image, photo_view, url_launcher packages

## [0.1.1+3] - 21.10.2019
### Changed
- Updated cached_network_image, video_player, chewie, photo_view, url_launcher packages
- Updated JSON examples

## [0.1.1+2] - 13.09.2019
### Changed
- Updated video_player, chewie and photo_view packages

## [0.1.1+1] - 28.08.2019
### Changed
- Updated video_player and intl packages

## [0.1.1] - 16.08.2019
### Added
- Custom onTapImage callback

## [0.1.0+3] - 13.08.2019
### Added
- Standard, compact and quote Tweet views
- Support for 1, 2, 3, 4 photos, GIFs (which are .mp4 files in the Twitter API) and videos.
- Showing if a user is verified
- Opening links to user profile, symbols, hashtags, mentions and URLs, tweet, quote tweet