# Public Version
*Private Version contains personally identifiable information*

# KCTracker
A GTK project used to see King County (WA, USA) bus transit.

## Installation
_Installation will only work on the Linux operating system or on Windows Subsystem for Linux (not tested)_
### REQUIREMENTS
- Flatpak

### Installation Process
1. Download the .flatpak equivalent to your CPU's architecture (either ARM/AARCH or x86)
2. Double click on the downloaded file in your file explorer to download with your software manager
   - Alternatively, open a terminal and cd into the directory which the folder is downloaded in (typically Downloads: ``cd Downloads``)
   - Then, run flatpak install [filename.flatpak]
     - Example: ``flatpak install x86.me.flagmaster.kctracker.flatpak``
3. Done! Just look up kctracker as an app or run ``flatpak run me.flagmaster.kctracker``


## Full Map Example
<img src="data/images/fullMapView.png" alt="map" width="800"/>

## Example of a "Rapid Ride"-type Bus Info
<img src="data/images/RapidRideExample.png" alt="map" width="800"/>

## Example of a "Express Bus"-type Bus Info
<img src="data/images/expressRouteExample.png" alt="map" width="800"/>

## Example of a "Metro Bus"-type Bus Info
<img src="data/images/metroBusExample.png" alt="map" width="800"/>

