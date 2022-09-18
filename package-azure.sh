#!/bin/bash

mvn --batch-mode -DappName="${APP_NAME}" package com.microsoft.azure:azure-functions-maven-plugin:package
