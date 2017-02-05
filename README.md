## 概要

### Laravel5 on PHP7 ,Apache2.4, CentOS7

- Laravel5.X.X（日本語化）
- Systemd導入
- Crond導入
- コンテナ内OSの設定なども可能な部分はロケールを日本に
- タイムゾーンを東京へ変更
- gitインストール
- Apache2.4
- PHP7

## 使い方（docker-composeの一例）

```
httpd:
  image: takashiabe/centos7-apache-laravel
  container_name : laravel5-httpd
  hostname: laravel5-httpd
  privileged: true
  ports:
    - 80:80
  volumes_from:
    - data
  links:
    - db:mysql
  restart: always
  command: "/sbin/init"
db:
  image: mysql:5.7
  container_name : laravel5-db
  ports:
    - 13306:3306
  volumes_from:
    - data
  environment:
    - MYSQL_USER=root
    - MYSQL_ROOT_PASSWORD=rootdbpass
    - MYSQL_DATABASE=laravel_dbname
  restart: always
data:
  image: busybox
  container_name : laravel5-data
  volumes:
    - /var/lib/mysql
    - /var/www/html
```

Laravel最新バージョンは5.4.9です。5.3、5.2を利用する際はタグを指定してください。

自前のLaravelプロジェクトファイルを使う場合（その場合がほとんどでしょうが）、
httpdコンテナの/var/www/laravelにマウントさせてください。

./var/www/laravelにプロジェクトファイルがあるとすれば、httpd:に

```
  volumes:
    - ./var/www/laravel:/var/www/laravel:rw
```

こんな感じで。

Apacheのdocument_root は /var/www/html です。
このコンテナでは/var/www/laravel/publicへのシンボリックリンクを張っています。
ということで、ホストにマウントした場合はプロジェクトファイルのpublicディレクトリがドキュメントルートになります。

systemdが動きますので、ホストからのApacheの（リロード|リスタート）は

```
docker exec -it laravel5-httpd systemctl (reload|restart) httpd.service
```

です。


## License
MIT