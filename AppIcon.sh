#!/bin/sh

SRC="AppIcon-1024.png"
DST="OpeningHours/Resources/Assets.xcassets/AppIcon.appiconset"

cp "$SRC" "$DST/AppIcon-1024.png"
sips -z 167 167 "$SRC" --out "$DST/AppIcon-iPadPro@2x.png"
sips -z 152 152 "$SRC" --out "$DST/AppIcon-iPad@2x.png"
sips -z 76 76 "$SRC" --out "$DST/AppIcon-iPad@1x.png"
sips -z 180 180 "$SRC" --out "$DST/AppIcon-iPhone@3x.png"
sips -z 120 120 "$SRC" --out "$DST/AppIcon-iPhone@2x.png"

