# Fastlane Reactnative Gitlab-ci example

```
buildPushAndroid: 
    stage: buildPushAndroid
    only:
     - master
    tags:
      - docker
    image: cuisines/gitlab-ci-react-native-android:latest
    script:
      - yarn 
      - fastlane android alpha
 stages:
   - buildPushAndroid
```

In the current way you will better upload aab (android app bundle)

Here an exmaple Fastlane Fastfile (The fastlane folder is directly at the Rootfolder): 

```
platform :android do
  desc 'Build the Android application.'
  private_lane :build do
    gradle(task: 'clean', project_dir: 'android/')
    gradle(task: 'bundle', build_type: 'Release', project_dir: 'android/')
  end
  desc 'Ship to Playstore Alpha.'
  lane :alpha do
    build
    supply(track: 'alpha', track_promote_to: 'alpha', aab: 'android/app/build/outputs/bundle/release/app.aab')
    
  end
end

```

Thats it! 