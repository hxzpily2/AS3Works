###抢食蛇

最多可以同时控制3条蛇的贪吃蛇游戏。

*（但是场地没法做得很大，真的玩起3条蛇来根本就是無理ゲーム...挑战一下吧）*

这里学习了SharedObject和Sound相关类的使用，成为**第一个有BGM**和记录功能的作品。
开始会自己写类，而且做得比较完整，标题菜单+游戏+game set处理都有了，还有一些设置项，做的比以前的作品复杂得多。

还在继续练习使用数组，碰撞情况并没有俄罗斯方块复杂，但是写多条蛇的碰撞检测时还是很笨拙地用了很长的判断语句
```
while(
TouchTest(Gems.gemsARR,snake1.snake,"GemSnake")==true 
|| TouchTest(Gems.gemsARR,snake2.snake,"GemSnake")==true 
|| TouchTest(Gems.gemsARR,snake3.snake,"GemSnake")==true)
```
*(如果再多加几条蛇的话我大概会一直写下去...)*





