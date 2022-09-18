#!/bin/bash

mvn --batch-mode package shade:shade
JAR_FILE=$(ls target | grep '.jar$' | grep -v '^original')
mkdir -p "target/${DEPLOYMENT_DIR}"
cp "target/${JAR_FILE}" "target/${DEPLOYMENT_DIR}/${JAR_FILE}"
