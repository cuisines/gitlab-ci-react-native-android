#
# GitLab CI react-native-android v0.1
#
# https://hub.docker.com/r/webcuisine/gitlab-ci-react-native-android/
# https://github.com/cuisines/gitlab-ci-react-native-android
#

FROM jangrewe/gitlab-ci-android
MAINTAINER Sascha-Matthias Kulawik <sascha@kulawik.de>

ENV FASTLANE_VERSION=2.29.0

RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get update && apt-get install git yarn nodejs build-essential -qqy --no-install-recommends

RUN apt-get install ruby ruby-dev -qqy --no-install-recommends

RUN gem install fastlane -NV

ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 3.3
ARG GRADLE_DOWNLOAD_SHA256=0b7450798c190ff76b9f9a3d02e18b33d94553f708ebc08ebe09bdf99111d110

RUN apt-get -qq update && apt-get install -qqy --no-install-recommends wget

RUN set -o errexit -o nounset \
	&& echo "Downloading Gradle" \
	&& wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
	\
	&& echo "Installing Gradle" \
	&& unzip gradle.zip \
	&& rm gradle.zip \
	&& mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
	&& ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle
