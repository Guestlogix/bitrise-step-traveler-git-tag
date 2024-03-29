#!/bin/bash
# set -ex

if git rev-parse "$CORE_VERSION_NAME" >/dev/null 2>&1; then
    echo "Tag, $CORE_VERSION_NAME, already exists";
else
	cd traveler_core_kit/
	../gradlew bintrayUpload
	cd ..
    git tag $CORE_VERSION_NAME
fi

if git rev-parse "$UI_VERSION_NAME" >/dev/null 2>&1; then
    echo "Tag, $UI_VERSION_NAME, already exists";
else
	cd traveler_ui_kit/
	../gradlew bintrayUpload
	cd ..
    git tag $UI_VERSION_NAME
fi

if git rev-parse "$STRIPE_VERSION_NAME" >/dev/null 2>&1; then
    echo "Tag, $STRIPE_VERSION_NAME, already exists";
else
	cd traveler_stripe_payment_provider/
	../gradlew bintrayUpload
	cd ..
    git tag $STRIPE_VERSION_NAME
fi

if git rev-parse "$APP_VERSION_NAME" >/dev/null 2>&1; then
    echo "Tag, $APP_VERSION_NAME, already exists";
else
    git tag $APP_VERSION_NAME
fi
git push --tags

#
# --- Export Environment Variables for other Steps:
# You can export Environment Variables for other Steps with
#  envman, which is automatically installed by `bitrise setup`.
# A very simple example:
# envman add --key EXAMPLE_STEP_OUTPUT --value 'the value you want to share'
# Envman can handle piped inputs, which is useful if the text you want to
# share is complex and you don't want to deal with proper bash escaping:
#  cat file_with_complex_input | envman add --KEY EXAMPLE_STEP_OUTPUT
# You can find more usage examples on envman's GitHub page
#  at: https://github.com/bitrise-io/envman

#
# --- Exit codes:
# The exit code of your Step is very important. If you return
#  with a 0 exit code `bitrise` will register your Step as "successful".
# Any non zero exit code will be registered as "failed" by `bitrise`.
