#
# GitLab CI react-native-android v0.2
#
# https://hub.docker.com/r/webcuisine/gitlab-ci-react-native-android/
# https://github.com/cuisines/gitlab-ci-react-native-android
#

FROM ubuntu:22.04
MAINTAINER Sascha-Matthias Kulawik <sascha@kulawik.de>

RUN echo "Android SDK 34.0.0"
ENV VERSION_SDK_TOOLS="10406996"

ENV ANDROID_HOME="/sdk"
ENV PATH="$PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/cmdline-tools/latest/bin"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends \
      bzip2 \
      curl \
      git \
      html2text \
      openjdk-17-jdk \
      gnupg2 \
      unzip \
      ca-certificates \
      software-properties-common \
      wget \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -f /etc/ssl/certs/java/cacerts; \
    /var/lib/dpkg/info/ca-certificates-java.postinst configure

RUN curl -s https://dl.google.com/android/repository/commandlinetools-linux-${VERSION_SDK_TOOLS}_latest.zip > /sdk.zip && \
    unzip /sdk.zip -d /tmp && \
    rm -v /sdk.zip && \
    mkdir -p ${ANDROID_HOME}/cmdline-tools && \
    mv /tmp/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest

RUN mkdir -p $ANDROID_HOME/licenses/ \
  && echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > $ANDROID_HOME/licenses/android-sdk-license \
  && echo "84831b9409646a918e30573bab4c9c91346d8abd" > $ANDROID_HOME/licenses/android-sdk-preview-license

ADD packages.txt /sdk
RUN mkdir -p /root/.android && \
  touch /root/.android/repositories.cfg && \
  ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --update 

RUN while read -r package; do PACKAGES="${PACKAGES}${package} "; done < /sdk/packages.txt && \
    yes | ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager ${PACKAGES}

RUN echo "Installing Node.JS 18 LTS" \
	&& curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
	&& apt-get install -y nodejs

RUN echo "Installing Yarn" \
	&& npm install -g yarn

ENV BUILD_PACKAGES="git build-essential imagemagick librsvg2-bin ruby ruby-dev libcurl4-openssl-dev"
RUN echo "Installing Additional Libraries" \
	 && rm -rf /var/lib/gems \
	 && apt-get update && apt-get install $BUILD_PACKAGES -qqy --no-install-recommends

RUN echo "Installing latest Fastlane" \
	&& gem install fastlane badge -N \
	&& gem cleanup

ENV GRADLE_HOME=/opt/gradle
ENV GRADLE_VERSION=8.5

RUN echo "Downloading Gradle" \
	&& wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"

RUN echo "Installing Gradle" \
	&& unzip gradle.zip \
	&& rm gradle.zip \
	&& mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
	&& ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle
