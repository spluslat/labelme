import sys
from PIL import Image

def replace_non_black_with_white(image_path, output_path):
    print(f'image_path:{image_path}, output_path:{output_path}')
    # 画像を読み込む
    with Image.open(image_path) as img:
        # RGBAに変換する（透明度を扱うため）
        img = img.convert("RGBA")
        
        # 画像のデータを取得する
        data = img.getdata()

        # 新しい画像データのリストを作成する
        new_data = []
        for item in data:
            # 黒（0, 0, 0）以外の場合は白（255, 255, 255）にする
            if item[0] != 0 or item[1] != 0 or item[2] != 0:
                new_data.append((255, 255, 255, item[3]))  # 白に変更
            else:
                new_data.append(item)  # 変更しない

        # 新しい画像データをセットする
        img.putdata(new_data)
        
        # 画像を保存する
        img.save(output_path)

def main():
    # コマンドライン引数を取得する
    # sys.argv[0] はスクリプトの名前で、引数は sys.argv[1] から始まる
    if len(sys.argv) < 3:
        print("引数が足りません。image_path と output_path の2つの引数を指定してください。")
        sys.exit(1)  # 引数が足りない場合はエラーとして終了する

    replace_non_black_with_white(sys.argv[1], sys.argv[2])

if __name__ == "__main__":
    main()