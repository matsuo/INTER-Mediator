#!/bin/sh

DIR="$( cd "$( dirname "$0" )" && pwd )"

IMPATH="${DIR}/../src/INTER-Mediator"
SAMLPATH="${IMPATH}/vendor/simplesamlphp/simplesamlphp"

if [ -d "${SAMLPATH}" ]; then
  cp "${DIR}/acl.php" "${SAMLPATH}/config"
  cp "${DIR}/authsources.php" "${SAMLPATH}/config"
  cp "${DIR}/config.php" "${SAMLPATH}/config"
  cp "${DIR}/saml20-idp-remote.php" "${SAMLPATH}/metadata"
fi

IMPATH="${DIR}/../INTER-Mediator"
SAMLPATH="${IMPATH}/vendor/simplesamlphp/simplesamlphp"

if [ -d "${SAMLPATH}" ]; then
  cp "${DIR}/acl.php" "${SAMLPATH}/config"
  cp "${DIR}/authsources.php" "${SAMLPATH}/config"
  cp "${DIR}/config.php" "${SAMLPATH}/config"
  cp "${DIR}/saml20-idp-remote.php" "${SAMLPATH}/metadata"
fi
