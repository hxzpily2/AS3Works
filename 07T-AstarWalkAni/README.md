##A*寻路+步行动画
A星自动寻路的入门

###步行动画
从*RPG Maker*处找来的任务行走素材图，切割成16格放在一个二维数组中播放。
```
imageArr.push(AnimationFactory.imgListFactory(this.bitmapData,i,4,wid,hei));
...
img.bitmapData=imageArr[movement][currentIndex];
```
然而效果微妙...或许由于找来的素材并不能很好地切割成16份，角色走起来一顿一顿的明显不连贯。

###astar
虽然看教程原理是好理解的，但是基本的A星代码并不能应对各种情况，性能也有待优化，只是做出来一个效果并不能说明什么。