# SpeechSummarizer
![Github License](https://img.shields.io/github/license/eveev26/SpeechSummarizer)
 ![Github Repo Size](https://img.shields.io/github/repo-size/eveev26/SpeechSummarizer)
  ![Github Issues](https://img.shields.io/github/issues/eveev26/SpeechSummarizer)

Simplify your meetings

A mobile flutter app to summarize long meetings into readable notes

![Screenshot of SpeechSummarizer in Dark Mode](assets/dark.png?raw=true)

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

## Backend Deployment (via GCP)

```bash
docker buildx build —platform linux/amd64 -t <gcr-url>
sudo gcloud auth login
sudo gcloud set project <project-name>
sudo gcloud auth activate-service-account <@devloper.gserviceaccount.com id> --key-file=<path to auth key>
sudo gcloud auth configure-docker
sudo docker push <gcr-url>
# Modify deployment.yaml to current docker image path
kubectl apply -f deployment.yaml
# Expose service by adding endpoint port and target port (found in deployment.yaml)
```
