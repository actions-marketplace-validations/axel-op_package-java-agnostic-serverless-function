#!/bin/bash

mvn --batch-mode package shade:shade

BUILD_DIR=$(mvn help:evaluate -Dexpression=project.build.directory -q -DforceStdout)

JAR_FILE=$(ls ${BUILD_DIR} | grep '.jar$' | grep -v '^original')
mkdir -p "${BUILD_DIR}/${DEPLOYMENT_DIR}"
cp "${BUILD_DIR}/${JAR_FILE}" "${BUILD_DIR}/${DEPLOYMENT_DIR}/${JAR_FILE}"

echo "::set-output name=deployment-directory::${BUILD_DIR}/${DEPLOYMENT_DIR}"
