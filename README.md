# SpeechSummarizer
![Github License](https://img.shields.io/github/license/eveev26/SpeechSummarizer)
 ![Github Repo Size](https://img.shields.io/github/repo-size/eveev26/SpeechSummarizer)
  ![Github Issues](https://img.shields.io/github/issues/eveev26/SpeechSummarizer)

Simplify your meetings

![Screenshot of SpeechSummarizer in Dark Mode](assets/dark.png?raw=true)

A flutter mobile app to summarize long meetings into readable notes

## Setup

Please provide your own API keys for google cloud bucket

## Build

### iOS

```bash
flutter build ios --release --no-codesign -v
mkdir Payload
cp build/ios/iphoneos/Runner.app Payload
zip -r Payload.zip Payload
mv Payload.zip SpeechSummarizer.ipa
```

### Android

```bash
flutter build apk --split-per-abi --release -v
flutter build appbundle --release -v
```