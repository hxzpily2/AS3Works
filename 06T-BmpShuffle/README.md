##洗牌效果

学习使用bitmap、bitmapdata、matrix等图像相关类的使用。

只是练习实现一些图像效果，代码写的比较杂乱。

###洗牌
1000张牌的同轴、随机速度、距离的洗牌效果，可以拖动1张牌。
同轴转动用的是flash pro那边的matrixtransfromer，比flash builder的matrix好用，不需要做太多矩阵计算。
```
MatrixTransformer.rotateAroundExternalPoint
(转动对象 ，轴x ， 轴y ， 转动速度);
```

###光球
原本是想做光球向上飘浮的柔和、虚幻的效果。

结果却变成了一堆白球很鬼畜地向上窜...なにがおかしいと思う...

按z键可开关光球效果。

###测试

cpu是i53230，牌面图案分辨率很低（原图太大），只有洗牌时50fps，加上光球40。



