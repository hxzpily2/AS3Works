##搬砖大师Himma Maestro
AS3的等角小游戏。

初看等角投影◇Isometric Projection的教程时，因为很喜欢*Final Fantay Tartics*，所以感觉要自己能做出来一个完整的什么东西的话就是用等角了，不过这个只是个2D小游戏，和*FFT*那样的3D SLG没有半毛钱关系...

对于不能旋转视角的2D等角，要怎样做到即使被方块遮住了视角也能愉快的玩耍呢？思考的结果就是这样的搬砖游戏，可以把方块搬开，也加入了在关卡开始时检视全部方块的功能等等。

游戏目的就是**把积木搬到相同颜色的格子**上

...等等这是**学龄前儿童的玩具**吗？

为了掩饰这个本质，加入了简单的道具、时间和方块种类等要素。逐渐地成为了目前做过的最复杂的东西。

*(这是看了一些设计模式教程之后的作品，尝试写了一些接口、模板之类的东西，但是不能确定是不是真的有用到位...)*


###关卡
并没有在关卡设计上下功夫，都是为了测试功能乱写的，

所以这个游戏大概实际上不能顺利游玩てへぺろ(•ω<)

配置文档的关卡信息格式是这样的
```
{
    "width": 宽多少格,
    "height": 长多少格,
    "size":格子尺寸,
    "hero":{"x": , "z":},主角的初始位置
    "timelimit":时间限制,
    "scorelimit":最低通关分数,
    "floor":
    [
    {"x": , "z": , "t":" "}得分地板坐标和颜色
    ],
    "box":
    [
    {"x": , "z": , "h": , "t":["  "] } 方块的坐标、高度、颜色，一定要x（z）小的排前面。
    ] ,
    "bird":
    [  
    {"time": , "direction": , "type":[" "], "target":{"x": , "z":} , "speed":}丢下砖头的时间、方向、颜色、目标、速度
    ]
  }
```

###菜单

玩过的应该能看得出是模仿The Phantom Pain的“道具选择-时间选择-出击”的菜单项——虽然其实只有BGM一样而已。
