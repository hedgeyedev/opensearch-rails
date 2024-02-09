#! /usr/bin/env bash
#
# Example:
# bin/publish_gem.sh '1.1.0' "https://mygemserver.com"

set -e

version=$1
host=$2

tag="v$version"
git tag $tag
git push origin $tag

function publish_gem {
  local gem_name=$1
  local gem_version=$2
  local gem_host=$3

  cd $gem_name
  mkdir -p pkg

  gem build $gem_name.gemspec -o pkg/$gem_name-$gem_version.gem

  echo "Pushing gem to $host"
  gem inabox pkg/$gem_name-$version.gem --host $host
  cd ..
}

publish_gem 'opensearch-model' $version $host
publish_gem 'opensearch-persistence' $version $host
publish_gem 'opensearch-rails' $version $host
