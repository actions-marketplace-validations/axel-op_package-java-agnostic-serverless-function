#!/bin/bash

mvn --batch-mode -DappName="${APP_NAME}" package com.microsoft.azure:azure-functions-maven-plugin:package

BUILD_DIR=$(mvn help:evaluate -Dexpression=project.build.directory -q -DforceStdout)
echo "::set-output name=deployment-directory::${BUILD_DIR}/azure-functions/${APP_NAME}"
