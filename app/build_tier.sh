#!/bin/bash
TIER=$1

if [ -z "$TIER" ]; then
  echo "Usage: ./build_tier.sh base|pro|premium"
  exit 1
fi

cp pubspec_${TIER}.yaml pubspec.yaml
flutter pub get
flutter build apk --flavor notes-${TIER} --target lib/main_${TIER}.dart --release