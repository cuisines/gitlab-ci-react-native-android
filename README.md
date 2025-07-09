# gitlab-ci-react-native-android
## Android 34.0.0, Java 17, Node.js 18 LTS, Gradle 8.5, and Latest Fastlane
This Docker image contains react-native and the Android SDK and most common packages necessary for building Android apps in a CI tool like GitLab CI. 

**Updated for 2024:**
- Ubuntu 22.04 LTS
- Android SDK 34.0.0 with command line tools
- Java 17 (OpenJDK)
- Node.js 18 LTS
- Gradle 8.5
- Yarn latest
- Fastlane latest 

A `.gitlab-ci.yml` with caching of your project's dependencies would look like this:

```
image: webcuisine/gitlab-ci-react-native-android

stages:
- build

cache:
  key: ${CI_PROJECT_ID}
  paths:
  - android/.gradle/

build:
  stage: build
  script:
  - yarn
  - cd android
  - chmod +x ./gradlew
  - ./gradlew assembleDebug
  artifacts:
    paths:
    - android/app/build/outputs/apk/
```
or like this [example with fastlane](./exampleWithFastlane.md)

## Automated Docker Hub Publishing

This repository uses GitHub Actions to automatically build and push the Docker image to Docker Hub whenever changes are made. The image is available at:

- **Latest**: `webcuisine/gitlab-ci-react-native-android:latest`
- **Versioned**: `webcuisine/gitlab-ci-react-native-android:android-34.0.0`

See [GITHUB_ACTIONS_SETUP.md](./GITHUB_ACTIONS_SETUP.md) for setup instructions.

## Detached testing
Build locally
```
docker build -t webcuisine/gitlab-ci-react-native-android:android-34.0.0 .
```
or run from remote
```
	docker run -it -d webcuisine/gitlab-ci-react-native-android /bin/bash
	docker attach HASH
	docker stop 3c854ac65f64d424c097e639c002b50431454e839b5c551ec2a929dcbecb7176
	
````
