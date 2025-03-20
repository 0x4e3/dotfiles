#!/usr/bin/env bash

echo "Setup macOS defaults"

# disable auto-correction
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool "false"
# show character accents menu
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "true"
# add a quit option to the Finder
defaults write com.apple.finder "QuitMenuItem" -bool "true"
# show all file extensions in the Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
# show path bar in the bottom of the Finder windows
defaults write com.apple.finder "ShowPathbar" -bool "true"
# set default Finder view style to column
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
# don't warn on file extension change
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
# expand save panel by default
defaults write NSGlobalDomain "NSNavPanelExpandedStateForSaveMode" -bool "true"
defaults write NSGlobalDomain "NSNavPanelExpandedStateForSaveMode2" -bool "true"
# expand print pannel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool "true"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool "true"
# show Finder status bar
defaults write com.apple.finder ShowStatusBar -bool "true"
# avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool "true"
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool "true"
# disable all Finder animations
defaults write com.apple.finder DisableAllAnimations -bool "true"
# don't show any drives on desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool "false"
defaults write com.apple.finder ShowMountedServersOnDesktop -bool "false"
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool "false"
# minimize windows into their application docks icons
defaults write com.apple.dock minimize-to-application -bool "true"
# don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool "false"
# don’t show recent applications in dock
defaults write com.apple.dock show-recents -bool "false"
# dock position
defaults write com.apple.dock "orientation" -string "bottom"
# auto-hide dock
defaults write com.apple.dock autohide -bool "true"
# auto-hide top menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool "true"
# don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool "false"
defaults write com.apple.Safari SuppressSearchSuggestions -bool "true"
# press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool "true"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool "true"
# show the full URL in the address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool "true"
# allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool "true"
# enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool "true"
# enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool "true"
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool "true"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool "true"
# don't automatically open new downloads
defaults write com.apple.Safari AutoOpenSafeDownloads -bool "false"
# don't try to use newly mounted disks for TimeMachine backups
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool "true"

echo "Restarting Finder"
killall Finder
