#!/usr/bin/groovy

node {
  def root = pwd()

  stage('Setup') {
    git url: 'https://github.com/StatEngine/kibana', branch: 'combined-styling'
  }

  stage('Archive') {
    sh """
      test -f /etc/runtime && source /etc/runtime
      sudo yum -y install ruby-devel rpm rpm-build
      sudo gem install pleaserun -v 0.0.24
      sudo gem install fpm -v 1.8.1
      sudo ln -s /user/bin/sha1sum /usr/bin/shasum

      chmod +x build.sh
      ./build.sh

      mkdir -p artifacts
      rm -rf artifacts/*
      #tar --exclude artifacts/* -cjf artifacts/statengine.tar.bz2 .
      #export ARTIFACT=artifacts/statengine.tar.bz2
      #./bin/s3Push.sh
    """
  }
}
