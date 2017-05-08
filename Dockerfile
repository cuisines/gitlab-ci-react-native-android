#
# GitLab CI react-native-android v0.1
#
# https://hub.docker.com/r/webcuisine/gitlab-ci-react-native-android/
# https://github.com/cuisines/gitlab-ci-react-native-android
#

FROM jangrewe/gitlab-ci-android
MAINTAINER Sascha-Matthias Kulawik <sascha@kulawik.de>

RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get update && apt-get install git yarn nodejs build-essential -qqy --no-install-recommends
