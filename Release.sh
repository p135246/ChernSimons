#!/bin/sh
# Creates the GitHub release of the deployed paclet on the mirror p135246/ChernSimons:
# reads the version from PacletInfo.wl, downloads the archive Publish.wls uploaded, and attaches it.
set -e
dir=$(cd "$(dirname "$0")" && pwd)
version=$(sed -n 's/.*"Version" -> "\([0-9.]*\)".*/\1/p' "$dir/PacletInfo.wl")
archive="${TMPDIR:-/tmp}/ChernSimons-$version.paclet"
resource="https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons"
curl -s -L --fail -o "$archive" "https://www.wolframcloud.com/obj/hajek_pavel/s1paper/ChernSimons.paclet"
unzip -p "$archive" "ChernSimons-$version/PacletInfo.wl" | grep -q "\"Version\" -> \"$version\"" || { echo "the cloud archive is not $version"; exit 1; }
echo "archive: $archive ($(wc -c < "$archive") bytes)"
gh release create "v$version" "$archive" --repo p135246/ChernSimons --title "ChernSimons $version" \
  --notes "The paclet resource with its documentation: $resource

Install with PacletInstall[ResourceObject[\"$resource\"], ForceVersionInstall -> True], or install the attached archive directly."
