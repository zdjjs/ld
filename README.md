# Laravel用Docker環境

## インストール
1. `$ git clone https://github.com/zdjjs/ld.git`
2. `$ cd ld`
3. `$ cp .env.sample .env`
4. Dockerの.env編集
	- PROJECT_ROOT
		- ホスト機でlaravelをインストールする場所
	- DOMAIN
		- 開発環境のエンドポイント
5. `$ docker-compose build`
6. Dockerの起動 `$ docker-compose up -d`
7. `$ docker-compose run proxy hosts` で出力された情報をホスト機のhostsに追加
8. Dockerのコンテナに入る `$ docker-compose exec work bash`
9. `$ ~/.composer/vendor/bin/laravel new`
10. Laravelの.env編集
	```dotenv
	APP_URL=https://(Dockerの.envのDOMAIN)
	DB_CONNECTION=pgsql
	DB_HOST=postgres
	DB_PORT=5432
	DB_DATABASE=postgres
	DB_USERNAME=postgres
	DB_PASSWORD=password
	MAIL_HOST=mailhog
	MAIL_PORT=1025
	```
11. http://(Dockerの.envのDOMAIN) にアクセス

## 2回目以降
1. `$ docker-compose up -d`
2. `$ docker-compose exec work bash`

## オブジェクトストレージを使う
1. `$ composer require league/flysystem-aws-s3-v3 ~1.0`
2. (S3の代わりにMinioを使う場合) `config/filesystems.php` の `disks` に以下を追加
	```php
	'minio' => [
		'driver' => 's3',
		'endpoint' => env('MINIO_ENDPOINT', 'http://127.0.0.1:9000'),
		'use_path_style_endpoint' => true,
		'key' => env('AWS_KEY'),
		'secret' => env('AWS_SECRET'),
		'region' => env('AWS_REGION'),
		'bucket' => env('AWS_BUCKET'),
	],
	```
3. Laravelの.env編集
	```dotenv
	#minio例
	FILESYSTEM_DRIVER=minio
	MINIO_ENDPOINT=http://minio.(Dockerの.envのDOMAIN)
	AWS_KEY=AKIAIOSFODNN7EXAMPLE
	AWS_SECRET=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
	AWS_REGION=ap-northeast-1
	AWS_BUCKET=storage
	```

## Redisを使う
1. Laravelの.env編集
   ```dotenv
    REDIS_HOST=redis
    REDIS_PASSWORD=null
    REDIS_PORT=6379
    ```
2. 使いたい部分で使えるように設定してください

## SSLを有効にする
1. `./proxy/certificates` の(Dockerの.envのDOMAIN).crtを信頼
2. httpsでアクセス

## 機能
- メール(MailHog)
    - http://mail.(Dockerの.envのDOMAIN)
    - Laravelから送られたメールは実際には送信されず、全てMailHogが受信します
- DBビュワー
    - http://pg.(Dockerの.envのDOMAIN)
    - PostgreSQLのテーブルを閲覧出来ます
- S3(Minio)
    - http://minio.(Dockerの.envのDOMAIN)
    - S3の代替
