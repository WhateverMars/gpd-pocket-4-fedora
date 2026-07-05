# GPD Pocket 4 Fedora Fixes

Scripts and systemd services to fix common issues with the GPD Pocket 4 running Fedora.

## Dependencies

```bash
sudo dnf install iio-sensor-proxy gnome-monitor-config
```

## Installation

**With git:**
```bash
git clone https://github.com/WhateverMars/gpd-pocket-4-fedora.git
cd gpd-pocket-4-fedora
bash install.sh
```

**Without git:**

Download the latest release zip, extract it, open a terminal in the folder and run:
```bash
bash install.sh
```

The install script will ask which components to install so you can pick which ones are relevant or all.

The script uses `sudo` only for:
- Copying `fix-orientation-resume.service` to `/etc/systemd/system/`
- Enabling it with `systemctl`

## Components

### Orientation Fix on Resume
Updates the screen rotation to match orientation after waking from suspend/hibernate via `gnome-monitor-config`.
Runs as a system-level oneshot service triggered by sleep targets.

### Auto Rotate Screen
The panel is physically portrait (1600x2560 native) but used in landscape,
which means the accelerometer orientation labels are offset 90° from what
you'd expect — `right-up` is the normal working position, not `normal`.

Uses `monitor-sensor` (via `iio-sensor-proxy`) to watch for orientation
changes and calls `gnome-monitor-config` to apply the correct transform.
Runs as a systemd user service targeting `graphical-session.target`.

Also enables the onscreen keyboard when in either portrait orientation.

Note: GNOME's built-in auto-rotate toggle does not appear on this device
as it lacks a tablet mode switch (`SW_TABLET_MODE`). This service replicates
that behaviour manually as much as possible.

## Archive
The `archive/` folder contains retired scripts no longer in active use,
kept for reference.
