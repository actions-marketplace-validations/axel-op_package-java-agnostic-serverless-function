#!/bin/bash

set -Eeuo pipefail

mvn --batch-mode package shade:shade

BUILD_DIR=$(mvn help:evaluate -Dexpression=project.build.directory -q -DforceStdout)

JAR_FILE=$(ls ${BUILD_DIR} | grep '.jar$' | grep -v '^original')
mkdir -p "${BUILD_DIR}/${DEPLOYMENT_DIR}"
cp "${BUILD_DIR}/${JAR_FILE}" "${BUILD_DIR}/${DEPLOYMENT_DIR}/${JAR_FILE}"

DEPLOYMENT_DIR_ABS="${BUILD_DIR}/${DEPLOYMENT_DIR}"
DEPLOYMENT_FILE_ABS="${DEPLOYMENT_DIR_ABS}/${JAR_FILE}"

echo "::set-output name=deployment-directory::${DEPLOYMENT_DIR_ABS}"
echo "::set-output name=deployment-file::${DEPLOYMENT_FILE_ABS}"
