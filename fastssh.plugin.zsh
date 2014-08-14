# For myself
FASTSSH_CONF_DIR=$ZSH_CUSTOM/plugins/$plugin/conf.d

function fssh {
  profile=$FASTSSH_CONF_DIR/$1.conf
  if [ -s $profile ] ; then
    source $profile
    if [ "$SSH_HOST" != "" ] && [ "$SSH_PORT" != "" ] && [ "$SSH_USER" != "" ] ; then
      if [ "$SSH_PASS" != "" ] ; then
        sshpass -p "$SSH_PASS" ssh -p $SSH_PORT $SSH_USER@$SSH_HOST
      elif [ "$SSH_KEY" != "" ] ; then
        ssh -i $SSH_KEY -p $SSH_PORT $SSH_USER@$SSH_HOST
      fi
    fi
  fi
}

function fscpu {
  profile=$FASTSSH_CONF_DIR/$1.conf
  local_path=$2
  remote_path=$3

  if [ -s $profile ] ; then
    source $profile
    if [ "$SSH_HOST" != "" ] && [ "$SSH_PORT" != "" ] && [ "$SSH_USER" != "" ] ; then
      if [ "$SSH_PASS" != "" ] ; then
        sh -c "sshpass -p '$SSH_PASS' scp -P $SSH_PORT $local_path $SSH_USER@$SSH_HOST:$remote_path"
      elif [ "$SSH_KEY" != "" ] ; then
        sh -c "scp -i $SSH_KEY -P $SSH_PORT $local_path $SSH_USER@$SSH_HOST:$remote_path"
      fi
    fi
  fi
}

function fscpd {
  profile=$FASTSSH_CONF_DIR/$1.conf
  remote_path=$2
  local_path=$3

  if [ -s $profile ] ; then
    source $profile
    if [ "$SSH_HOST" != "" ] && [ "$SSH_PORT" != "" ] && [ "$SSH_USER" != "" ] ; then
      if [ "$SSH_PASS" != "" ] ; then
        sh -c "sshpass -p '$SSH_PASS' scp -P $SSH_PORT $SSH_USER@$SSH_HOST:$remote_path $local_path"
      elif [ "$SSH_KEY" != "" ] ; then
        sh -c "scp -i $SSH_KEY -P $SSH_PORT $SSH_USER@$SSH_HOST:$remote_path $local_path"
      fi
    fi
  fi
}
