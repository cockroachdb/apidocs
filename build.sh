#!/bin/bash -x

# This script was created by @mikeCRL as a way to chain the tools Widdershins and Slate to convert
# an OpenAPI spec document to Markdown format and then serve that Markdown as API documentation.
#
# This process uses a fork (https://github.com/dracula/slate) of the popular https://github.com/slatedocs/slate repo.
# Slate is an implementation of the Middleman static-site generator. For more information, see https://github.com/slatedocs/slate/wiki.
# Slate builds the site based on a single specially formated Markdown file that contains all details of the API.
# A tool to convert an OpenAPI spec document into that Markdown file is called Widdershins (https://github.com/Mermade/widdershins).
#
# The intent of this script and instructions is to offer a consistent environment where it is easy to test
# OpenAPI spec file changes and view the result in the built doc site. This script could be adapted for
# production use. For example, each time the main doc site builds, re-build this as a subpath of that site.
#
# An example site built using this script is available at https://slatetest.netlify.app.

# NOTE:
# - There are warnings when running the Middleman server that "URI.unescape is obsolete".
#   This is fixed in a later Middleman release "https://github.com/middleman/middleman/issues/2312#issuecomment-692393682".
#    - This is already in Slate (current version 2.9.2 https://github.com/slatedocs/slate/blob/main/CHANGELOG.md)
#      but not yet in the Dracula fork (current version 2.7.0 https://github.com/dracula/slate/blob/master/CHANGELOG.md)

# INITIAL SETUP
#
# 1. Create a directory (e.g. /apidocs/) and place this script inside it.
# 2. In the apidocs directory, clone https://github.com/Mermade/widdershins, creating a `widdershins` directory with the repo's contents inside. 
#      2a. Follow the instructions in the Prerequisites section here https://mermade.github.io/widdershins/ConvertingFilesBasicCLI.html.
#      2b. Use the recommended installation method: in the `widdershins` directory, run `npm install -g widdershins`.
# 3. In the apidocs directory, clone https://github.com/dracula/slate, creating a `slate` directory with the repo's contents inside.
#      3a. Follow the instructions in the Dependencies section here https://github.com/slatedocs/slate/wiki/Using-Slate-Natively.
#      3b. In the `slate` directory, run `bundle install`.
# 4. Create a `specs` directory. This can contain various OpenAPI spec files, e.g. iterations when testing changes.
#    Only the spec file name that's passed in the argument when calling the script will be used.
# Note: The script will also create the following subdirectories:
#    /archive/ - Holds timestamped copies of all spec files used, for rollback purposes when testing. All start with `openapi`; renamed from original spec.
#    /archive/current - Keeps original spec filename so that it's clear what the latest one is, because otherwise they're all renamed to `openapi`.

# INSTRUCTIONS
#
# 1. Place your OpenAPI spec file in /specs.
# 2. If necessary, edit this script to choose which `bundle exec` command to comment out or uncomment (see the last several lines), and save any changes.
# 3. Run the script. For example, if you want to process /specs/spec.json:
#        ./build.sh specs/spec.json
#    Note: When you run the script, `slate` must be a subdirectory of the current directory. If you run it again in the same terminal window, you may need to `cd ..` first.
# 4. If running the Middleman server, you'll see a message to `View your site at "http://localhost:4567", "http://127.0.0.1:4567"`.

# WHEN YOU RUN THE SCRIPT
#
# - spec.json (or your chosen file) is copied into the `slate/source` directory, renamed to openapi.json for consistency, and backed up to /archive/current/spec(timestamp).json.
# - openapi.json is converted by Widdershins into a suitable Markdown format and stored as /slate/source/index.html.md. Slate always looks for this file when it is run.
# - Slate builds and/or serves an HTML site based on that markdown file.
# - You can opt to manually edit the markdown file. Kill the Middleman server (if running) and rerun the applicable `bundle exec middleman` command to view changes.
# - At the beginning of the next script run, the json and md in /slate/source/ are moved to the archive directory.
# - Your folder structure should match the following. Review the setup instructions if it does not.
#   - archive
#   - archive/current
#   - slate
#   - specs
#   - widdershins

# - - -

# BEGIN SCRIPT

# Create directories if they don't already exist.
mkdir specs
mkdir archive
mkdir archive/current

# Set $SPEC as the filename passed into the script.
SPEC=$1;

# Archive the openapi.json and index.html.md files that are already in the widdershins directory.
mv "slate/source/openapi.json" "archive/openapi_$(date +%Y.%m.%d-%H.%M.%S).json"
cp "slate/source/index.html.md" "archive/index_$(date +%Y.%m.%d-%H.%M.%S).html.md"

# Copy $SPEC to Widdershins path as openapi.json.
cp "$SPEC" "slate/source/openapi.json"

# Preserve original $SPEC filename, identified as current one in use.
cp "$SPEC" "archive/current/$SPEC$(date +%Y.%m.%d-%H.%M.%S).json"

# Run widdershins from within slate dir against openapi.json.
widdershins --language_tabs 'shell:curl' --summary slate/source/openapi.json -o slate/source/index.html.md

# OPTION 1 (Comment one out): Run Slate's Middleman build (See https://github.com/slatedocs/slate/wiki/Deploying-Slate#publishing-your-docs-to-your-own-server)
# cd slate && bundle exec middleman build --clean

# OPTION 2 (Comment one out): Run Slate's local Middleman server
cd slate && bundle exec middleman server
