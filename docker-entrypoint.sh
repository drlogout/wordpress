#!/bin/bash

if [ ! -z ${LOCAL_USER_NAME} ]; then
  userName=${LOCAL_USER_NAME}
  userID=$(id -u ${LOCAL_USER_NAME})
  user_exists=$(getent passwd ${userName} >/dev/null 2>&1)

  if [ $? -ne 0 ]; then
    echo "Creating user ${userName}"
    useradd --shell /bin/bash -u ${userID} -o -c "" -m ${userName}
    export HOME=/home/${userName}
  fi

  echo "Starting wit UID : ${userID}"
  exec /usr/local/bin/gosu ${userName} "${@}"
  exit 0
fi

exec "${@}"

