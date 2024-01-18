# LabelMe
LabelMeの操作関連

# 使用するライブラリ
[LabelMe](https://github.com/labelmeai/labelme)

- install : `pip install labelme`

# 使い方

1. LabelMeでアノテーション
2. jsonからマスク画像を作成する


## 1. LabelMeでアノテーション

- 起動:`run_labelme.bat`

```
labelme --labels labels.txt --autosave
```

- `labels.txt`

jsonから画像に変換するときに`__ignore__`、`_background_`が先頭にいるようなので追加しておく。
```
__ignore__
_background_
任意のタグ
```

- 使い方は本家で調べる

## 2. jsonからマスク画像を作成する:`json_to_png.bat`

`labelme_json_to_dataset`を使用するのがお手軽
  - `labels.txt`に`__ignore__`、`_background_`が先頭にいるので注意
    ```
    labelme_json_to_dataset <json_to_path> --out <output_image_dir>
    ```
  - 制御したい場合は[labelme2voc.py](https://github.com/labelmeai/labelme/blob/main/examples/instance_segmentation/labelme2voc.py)を参考にして書く。


デフォルトでは、ラベル毎に色が異なる。  
黒以外の背景を白にした画像も作成する（学習するライブラリによる？）  
`replace_black_to_white.py`

