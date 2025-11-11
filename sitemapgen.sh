#!/bin/bash

# 絶対パスでコマンドを指定
FIND="/usr/bin/find"
ECHO="/bin/echo"

# 保存先ディレクトリ
TARGET_DIR="/var/www/html"
# 出力ファイル
OUTPUT_FILE="$TARGET_DIR/sitemap.xml"
# ベースURL
BASE_URL="https://kntnkmr.f5.si"

# ヘッダを書き込み
$ECHO '<?xml version="1.0" encoding="UTF-8"?>' > "$OUTPUT_FILE"
$ECHO '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' >> "$OUTPUT_FILE"

# 再帰的に .html ファイルを探して URL を書き込み
$FIND "$TARGET_DIR" -type f -name "*.html" | while read -r file; do
    # ファイルパスからベースURLに対応する相対パスを生成
    relative_path="${file#$TARGET_DIR}"
    # URL を生成
    url="$BASE_URL$relative_path"
    $ECHO "  <url><loc>$url</loc></url>" >> "$OUTPUT_FILE"
done

# フッタを書き込み
$ECHO '</urlset>' >> "$OUTPUT_FILE"

$ECHO "sitemap.xml を作成しました: $OUTPUT_FILE"
