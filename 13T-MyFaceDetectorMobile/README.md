###面部识别

用网上找到的OpenCV移植到AS3的人脸识别工具做的小东西。

没有太深入研究图像算法，只是简单地用FileReference读取图片进行

识别。

要让图片以合适大小显示在界面上还写了一个更改图片尺寸的类。


```
bmp.bitmapData=resizer.changeImgSize( bmp.bitmapData );
detector.detect(tmp);			
```

准确度微妙...无论是先适配尺寸再检测还是反过来都会有不准确的情况。