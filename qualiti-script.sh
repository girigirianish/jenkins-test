#!/bin/bash
 
set -ex
 
PROJECT_ID='332'
API_KEY='C3GVjpEWgX5mSTBh7XcmV4AMqcBTrGst2W65FKal'
CLIENT_ID='f2b2cea4ac9980f694f7c254ea33e2f9'
SCOPES=['"ViewTestResults"','"ViewAutomationHistory"']
API_URL='https://7iggpnqgq9.execute-api.us-east-2.amazonaws.com/udbodh/api'
INTEGRATION_JWT_TOKEN='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwcm9qZWN0X2lkIjozMzIsImFwaV9rZXlfaWQiOjI0ODMsIm5hbWUiOiIiLCJkZXNjcmlwdGlvbiI6IiIsImljb24iOiIiLCJpbnRlZ3JhdGlvbl9uYW1lIjoiR2l0bGFiIiwib3B0aW9ucyI6e30sImlhdCI6MTYxNjE1NjI2OX0.F4C59OAbjnhoA9OK_5MRoDlbL-4AVNiu3rD0S6Khj7c'
INTEGRATIONS_API_URL='http://3b4a618862d1.ngrok.io'
 
sudo apt-get update -y
sudo apt-get install -y jq
sudo apt-get install curl

#Trigger test run
TEST_RUN_ID="$( \
  curl -X POST -G ${INTEGRATIONS_API_URL}/api/integrations/gitlab/${PROJECT_ID}/events \
    -d 'token='$INTEGRATION_JWT_TOKEN''\
    -d 'triggerType=Deploy'\
    -d 'projectId='$PROJECT_ID''\
  | jq -r '.test_run_id')"

AUTHORIZATION_TOKEN="$( \
  curl -X POST -G ${API_URL}/auth/token \
  -H 'x-api-key: '${API_KEY}'' \
  -H 'client_id: '${CLIENT_ID}'' \
  -H 'scopes: '${SCOPES}'' \
  | jq -r '.token')"

# Wait until the test run has finished
while : ; do
   RESULT="$( \
   curl -X GET ${API_URL}/automation-history?project_id=${PROJECT_ID}\&test_run_id=${TEST_RUN_ID} \
   -H 'token: Bearer '$AUTHORIZATION_TOKEN'' \
   -H 'x-api-key: '${API_KEY}'' \
  | jq '[.[] | .finished] | .[1]')"
  # echo $RESULT
  if [ "$RESULT" != null ]; then
    echo "the result is not null : $RESULT"
    break;
  fi
    echo "the result is : $RESULT"
    sleep 15;
done

# # Once finished, verify the test result is created and that its passed
TEST_RUN_RESULT="$( \
  curl -X GET ${API_URL}/test-results?test_run_id=${TEST_RUN_ID}\&project_id=${PROJECT_ID} \
    -H 'token: Bearer '$AUTHORIZATION_TOKEN'' \
    -H 'x-api-key: '${API_KEY}'' \
  | jq -r '.[0].status' \
)"
echo "Qualiti E2E Tests ${TEST_RUN_RESULT}"
