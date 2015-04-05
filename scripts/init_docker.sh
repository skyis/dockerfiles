#! /bin/sh

# 環境変数 設定
if [ $RUN_MODE ]; then
  echo "" >> /etc/profile ;
  echo "APPLICATION_ENV=$RUN_MODE" >> /etc/profile ;
  echo "export APPLICATION_ENV" >> /etc/profile ;
fi

# Supervisor 起動
/usr/bin/supervisord ;

