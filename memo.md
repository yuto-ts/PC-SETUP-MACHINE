# memo
## ffmpeg の使い方
### 連番画像から動画を作成する
ffmpeg で gif 動画を生成する。`%04d.png` は 連番の数字
> ffmpeg -i prog/processing/test/frames/%04d.png -pix_fmt rgb24 -f gif path/{filename}.gif

ffmpeg で avi 動画を生成する。
> ffmpeg -r 1 -i figs/overlap_0s_%03d.png -qscale 0 out.avi

参考: https://kenyu-life.com/2019/02/13/ffmpeg/
