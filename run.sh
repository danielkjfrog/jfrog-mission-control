#!/usr/bin/env bash

downloadMissionControl(){
    if [[ $MC_VERSION == *"SNAPSHOT"* ]];then
        SOURCE_REPO=mc-snapshot-local
    else
        SOURCE_REPO=mc-release-local
    fi
    echo "Downloading Mission Control ${MC_VERSION}..."
    curl -o /tmp/jfrog-mission-control-${MC_VERSION}.zip -u${ARTIFACTORY_USER}:${ARTIFACTORY_PASSWORD} \
    https://repo.artifactoryonline.com/artifactory/${SOURCE_REPO}/org/jfrog/mc/jfrog-mission-control/${MC_VERSION}/jfrog-mission-control-${MC_VERSION}.zip
}

extractMissionControl(){
    echo "Extracting Mission Control ${MC_VERSION}..."
    unzip /tmp/jfrog-mission-control-${MC_VERSION}.zip -d /var/opt/jfrog
}

startMissionControl(){
    echo "Starting Mission Control..."
    bash /var/opt/jfrog/mission-control-${MC_VERSION}/bin/mission-control.sh
}

if [ -v ARTIFACTORY_USER ] && [ -v ARTIFACTORY_PASSWORD ] && [ -v MC_VERSION ]; then
    downloadMissionControl
    extractMissionControl
    startMissionControl
else
    echo "Make sure you provided ALL ENVIRONMENT VARIABLES: ARTIFACTORY_USER, ARTIFACTORY_PASSWORD, MC_VERSION."
    exit 1
fi