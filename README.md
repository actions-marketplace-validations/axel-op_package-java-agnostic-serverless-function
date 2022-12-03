# Agnostic Serverless Functions in Java: Package Action

An [agnostic serverless function](https://github.com/axel-op/agnostic-serverless-functions-java) is a serverless function whose configuration is not linked to a particular FaaS framework.

This action performs the packaging steps needed before deploying a Java function to a specific FaaS provider.

## Usage

```yml
name: Example workflow

on: push

jobs:
  example-job:
    
    env:
      FAAS_PROVIDER: gcloud # can be: aws, azure, gcloud
      MAVEN_SERVER_ID: github-packages # this is the id set in pom.xml

    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up JDK and Maven settings
        uses: actions/setup-java@v1
        with:
          java-version: 11
          server-id: ${{ env.MAVEN_SERVER_ID }}
          server-username: MAVEN_USERNAME
          server-password: MAVEN_PASSWORD
      - name: Package
        env:
          MAVEN_USERNAME: ${{ secrets.MAVEN_USERNAME }}
          MAVEN_PASSWORD: ${{ secrets.MAVEN_PASSWORD }}
        uses: axel-op/package-java-agnostic-serverless-function@main
        with:
          function-name: name-of-your-function
          faas-provider: ${{ env.FAAS_PROVIDER }}
        # working-directory: . # required if different from $GITHUB_WORKSPACE

```

### Inputs

- `function-name`: the name of the function that will be deployed.
- `faas-provider`: the provider the function will be packaged for. Accepted values are: `aws`, `azure`, `gcloud` (more providers to come).

### Outputs

- `deployment-directory`: the absolute path of the directory containing the files to be deployed.

### About Maven settings

Building an agnostic function [requires Maven artifacts](https://github.com/axel-op/agnostic-serverless-functions-java#configuration) hosted on GitHub Packages. [This README](https://github.com/axel-op/maven-packages) explains how to add them in the dependencies of your Maven project. To retrieve them during the workflow, [the Maven settings file](https://maven.apache.org/settings.html) must contain your credentials to GitHub Packages.

The example above uses [`actions/setup-java`](https://github.com/actions/setup-java) to tell Maven to use the environment variables `MAVEN_USERNAME` and `MAVEN_PASSWORD` as credentials. These environment variables are only set during the packaging step.

## Full example

Check out [this workflow](https://github.com/axel-op/agnostic-serverless-functions-java-example/blob/main/.github/workflows/deployment.yml) for a complete example of a deployment workflow using this action.
