#!/bin/sh

PROJECT_NAME=$1
JOB_ID=$2
PAGES_URL=$3
env=$4
service=$5
test_type=$6
pipeline_URL=$7

find=".io"
replaceWith=".io\/-"
newUrl=$(echo "$PAGES_URL" | sed "s/$find/$replaceWith/")
newUrl="$newUrl/-/jobs/$JOB_ID/artifacts/target/site/allure-maven-plugin/index.html"

message="In $PROJECT_NAME for pipeline-$pipeline_URL environment-$env, service-$service, $test_type test results are $newUrl"
curl --location --request POST 'https://hooks.slack.com/services/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' \
--header 'Content-Type: application/json' \
--data-raw "{ \"text\": \"$message\", \"channel\": \"qa-subscription-automation-report\"}"
