# Archive

Scripts no longer in active use, kept for reference.

- **set-mouse-speed.sh** — set Logitech MX Master 3S pointer accel via `xinput`.
  Relied on X11; doesn't work on Wayland. Superseded by GNOME's built-in
  mouse speed setting (`gsettings get org.gnome.desktop.peripherals.mouse speed`).

- **auto-rotate-touchscreen.sh** + **auto-rotate-touchscreen.service** —
  kept touchscreen input orientation in sync with display rotation via
  `xinput`. Superseded by GNOME/Wayland's native libinput handling —
  confirmed touch still rotates correctly with this service stopped.
