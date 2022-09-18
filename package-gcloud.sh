#!/bin/bash

mvn --batch-mode package shade:shade

JAR_FILE=$(ls target | grep '.jar$' | grep -v '^original')
mkdir -p "target/${DEPLOYMENT_DIR}"
cp "target/${JAR_FILE}" "target/${DEPLOYMENT_DIR}/${JAR_FILE}"

BUILD_DIR=$(mvn help:evaluate -Dexpression=project.build.directory -q -DforceStdout)
echo "::set-output name=deployment-directory::${BUILD_DIR}/${DEPLOYMENT_DIR}"
