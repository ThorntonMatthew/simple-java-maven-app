#!/usr/bin/env bash

echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'
set -x
mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'The following command extracts the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
set -x
NAME=`mvn -q -Dexec.executable=echo -Dexec.args='${project.name}' --non-recursive exec:exec`
set +x

echo 'The following command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'
set -x
VERSION=`mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec`
set +x

echo 'Name:'
echo $NAME

echo 'Version:'
echo $VERSION

echo 'The following command runs and outputs the execution of your Java'
echo 'application (which Jenkins built using Maven) to the Jenkins UI.'
set -x
java -jar target/${NAME}-${VERSION}.jar
