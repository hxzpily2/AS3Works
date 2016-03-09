﻿package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.sampler.Sample;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.engine.Kerning;
	import flash.text.engine.TextBaseline;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import org.osmf.net.SwitchingRuleBase;
	
	public class tanchishe extends Sprite
	{
		private var buttons:Button=new Button;
		private var BGM:NewBgm=new NewBgm;
		private var titleTXT:TextBlank;
		private var snkNumTXT:TextBlank;
		private var gemNumTXT:TextBlank;
		private var snkCrashTXT:TextBlank;
		private var scoreTag:TextBlank;//分数
		private var scoreTXT:TextBlank;//分数数字
		private var bgmTXT:TextBlank;//bgm名字
		private var saveTXT:TextBlank;//记录输入框
		private var saveTipTXT:TextBlank;//记录输入提示
		private var HighestTXT:TextBlank;//最高分文本
		private var date:Date=new Date;//记录日期
		
		public var BackGround:Background;
		public 	var snake1:Snake=new Snake(0xff0000,"Solid Snake");
		public var snake2:Snake=new Snake(0x00ff00,"Liquid Snake");
		public var snake3:Snake=new Snake(0x0000ff,"Solidus Snake");
		public var Gems:Gem;
		public var score:int;
		public var SO:SharedObject = SharedObject.getLocal("save");
		
		public function tanchishe()
		{
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			if(SO.data.score==undefined){
				SO.data.score=0;
				SO.data.name="???";
				SO.data.date=date;
				//初始记录
			}
			
			titleTXT=new TextBlank(false,300,5,60,200,2,"抢吃蛇");
			snkNumTXT=new TextBlank(false,100,100,90,240,2,"请选择蛇的数目");
			gemNumTXT=new TextBlank(false,100,200,90,240,2,"请选择宝石的数目");
			snkCrashTXT=new TextBlank(false,100,300,120,500,2,"是否仅在蛇出界时判定GameOver\n※为on时蛇相撞不会导致游戏结束");
			bgmTXT=new TextBlank(false,50,480,20,550,2," ");
			HighestTXT=new TextBlank(false,650,200,200,400,2," ");
			saveTipTXT=new TextBlank(false,20,100,80,200,2,"你创造了纪录！\n请输入名字：")
			saveTXT=new TextBlank(true,10,150,50,150,1," ");
			saveTXT.multiline=false;
			
			buttons.switch123.x=500;
			buttons.switch123.y=100;
			buttons.switch1to6.x=500;
			buttons.switch1to6.y=200;
			buttons.switchOnOff.x=500;
			buttons.switchOnOff.y=300;
			buttons.Restart.x=300;
			buttons.Restart.y=200;
			buttons.Restart.addEventListener(MouseEvent.CLICK,Restart);
			buttons.Start.y=400;
			buttons.Start.x=300;
			
			setTimeout(init,100);
			
			function init():void
			{
				score=0;
				
				BGM.bgmSwitch("Title");
				
				addChild(titleTXT);
				
				bgmTXT.text="BGM:《ゼノブレイド》ゴロニー９";
				addChild(bgmTXT);
				
				HighestTXT.text="record:\n"+SO.data.name+"\n"+SO.data.score+"\n"+SO.data.date;
				addChild(HighestTXT);
				
				//选择蛇数目的按钮
				addChild(snkNumTXT);
				addChild(buttons.switch123);
				
				//选择宝石数目的按钮
				addChild(gemNumTXT);
				addChild(buttons.switch1to6);
				
				//选择会不会互咬的按钮
				addChild(snkCrashTXT);	
				addChild(buttons.switchOnOff);
				
				//开始按钮
				buttons.Start.addEventListener(MouseEvent.CLICK,GameStart);
				addChild(buttons.Start);
			}
			
			function GameStart():void
			{
				
				if(buttons.switch123.fps==1){
					BGM.bgmSwitch("One Snake");
					bgmTXT.text="BGM:《おおかみの子ども雨と雪》きときと-四本足の踊り"
				}else if(buttons.switch123.fps==2){
					BGM.bgmSwitch("Two Snakes");
					bgmTXT.text="BGM:《戦場のヴァルキュリア》激戦";
				}else if(buttons.switch123.fps==3){
					BGM.bgmSwitch("Three Snakes");
					bgmTXT.text="BGM:《Final Fantasy Tarctis A2》Mad Dash";
				}
				removeChild(titleTXT);
				removeChild(snkNumTXT);
				removeChild(snkCrashTXT);
				removeChild(gemNumTXT);
				removeChild(HighestTXT);
				removeChild(buttons.Start);
				removeChild(buttons.switchOnOff);
				removeChild(buttons.switch123);
				removeChild(buttons.switch1to6);//清除按键与文本
				
				
				//分数栏
				scoreTag=new TextBlank(false,0,50,30,200,2,"Score:");
				scoreTXT=new TextBlank(false,90,30,50,200,2,String(score));
				addChild(scoreTag);
				addChild(scoreTXT);
				
				makeBG(15,20);
				makeSnake(4);
				makeGem();
			}
			
			
			function Restart():void
			{
				SO.data.name=String(saveTXT.text);
				SO.data.date=date;
				SO.data.score=score;
				SO.flush();
				removeChildren();
				init();
			}
			
			/*stage.addEventListener(KeyboardEvent.KEY_DOWN,FunctionTest);
			function FunctionTest(event:KeyboardEvent):void
			{
			if(event.keyCode==Keyboard.SPACE)//生长功能
			{
			snake1.Grow();
			addChild(snake1.snake[snake1.Length-1]);
			}else if(event.keyCode==Keyboard.ESCAPE){//重启功能
			Restart();
			}
			else if(event.keyCode==Keyboard.PAGE_DOWN)
			{	
			scoreTXT.text=String(int(scoreTXT.text)+100);
			//scoreTXT.setTextFormat(scoreTXT.format);
			}else if(event.keyCode==Keyboard.PAGE_UP)//得分功能
			{
			var a:int=0;
			for(a;a<buttons.switch1to6.fps;a++){
			removeChild(Gems.gemsARR[a]);
			}
			makeGem();
			}else if(event.keyCode==Keyboard.CONTROL){
			GameOver();
			}else if(event.keyCode==Keyboard.Z){
			//Gems.HowMuch-=1;
			}
			}*/
		}
		private function GameOver():void{
			AllSnkCtrl(false);
			BGM.bgmSwitch("Game Over");
			bgmTXT.text="BGM:《Shadow of Colossus》Swift Horse";
			if(score>SO.data.score){
				addChild(saveTipTXT);
				addChild(saveTXT);
			}
			addChild(buttons.Restart);
		}
		
		
		
		public	function TouchTest(sth:Array,sthelse:Array,type:String):Boolean
			//type "SnakeSnake" tests if snakes crash each other.
			//type "SnakeGem" test if snakes eat a gem.
			//tyep "GemSnake" tests if any gem is made on a snake.
			//sth is the moving obj.  sthelse is the tested obj. 
		{
			var IFtouch:Boolean=false;
			if(type=="Field"){
				if(sth[0].x<180 || sth[0].x>=780 || sth[0].y < 30 || sth[0].y >= 480){
					IFtouch=true;
					
				}
			}
			else if(type=="SnakeSnake"){
				for(var num:int=0;num<=sthelse.length-1;num++)
					if(sth[0].x==sthelse[num].x && sth[0].y==sthelse[num].y){
						IFtouch=true;
						break;
					}
			}
			else if(type=="SnakeGem"){
				for(var z:int=0;z<=sthelse.length-1;z++){
					if(sth[0].x==sthelse[z].x && sth[0].y==sthelse[z].y){
						IFtouch=true;
						score=score+100;
						scoreTXT.text=String(score);
						removeChild(sthelse[z]);
						sthelse.splice(z,1);
						Gems.HowMuch=Gems.HowMuch-1;
						if(Gems.HowMuch==0){
							makeGem();
						}
						break;
					}
				}
			}
			else if(type=="GemSnake"){
				for(var a:int=0;a<=sth.length-1;a++){
					for(var b:int=0;b<=sthelse.length-1;b++){
						if(sth[a].x==sthelse[b].x && sth[a].y==sthelse[b].y){
							IFtouch=true;
							break;
						}
					}
				}
			}
			return IFtouch;
		}
		
		private function makeGem():void//宝石
		{
			Gems=new Gem();
			Gems.HowMuch=buttons.switch1to6.fps;
			Gems.FirstGem();
			
			if(buttons.switch123.fps==1){
				while(TouchTest(Gems.gemsARR,snake1.snake,"GemSnake")==true){
					Gems.FirstGem();
				}
			}
			else if(buttons.switch123.fps==2){
				while(TouchTest(Gems.gemsARR,snake1.snake,"GemSnake")==true || TouchTest(Gems.gemsARR,snake2.snake,"GemSnake")==true){
					Gems.FirstGem();
				}
			}
			else if(buttons.switch123.fps==3){
				while(TouchTest(Gems.gemsARR,snake1.snake,"GemSnake")==true || TouchTest(Gems.gemsARR,snake2.snake,"GemSnake")==true || TouchTest(Gems.gemsARR,snake3.snake,"GemSnake")==true){
					Gems.FirstGem();
				}
			}//检测gem是否生成在蛇上
			var gemNum:int=0;
			for(gemNum;gemNum<buttons.switch1to6.fps;gemNum++){
				addChild(Gems.gemsARR[gemNum]);
			}
		}
		
		private function makeSnake(Length:int):void//蛇
		{
			snake1.makeSnk(Length,10,4);
			//snake1.putPad(Keyboard.UP,Keyboard.DOWN,Keyboard.LEFT,Keyboard.RIGHT);
			snake1.timer.addEventListener("timer",SnakeACT);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,snake1.Control);
			
			if(buttons.switch123.fps>=2){
				snake2.makeSnk(Length,15,4);
				//snake2.putPad(Keyboard.W,Keyboard.S,Keyboard.A,Keyboard.D);
				snake2.timer.addEventListener("timer",SnakeACT);
				stage.addEventListener(KeyboardEvent.KEY_DOWN,snake2.Control);
			}
			
			if(buttons.switch123.fps==3){
				snake3.makeSnk(Length,20,4);
				//snake3.putPad(Keyboard.I,Keyboard.K,Keyboard.J,Keyboard.L);
				snake3.timer.addEventListener("timer",SnakeACT);
				stage.addEventListener(KeyboardEvent.KEY_DOWN,snake3.Control);
			}
			
			for(var a:int=0;a<snake1.Length;a++)
			{
				addChild(snake1.snake[a]);
				if(buttons.switch123.fps>=2){
					addChild(snake2.snake[a]);
					addChild(snake2.gamePad);
				}
				if(buttons.switch123.fps==3){
					addChild(snake3.snake[a]);
					addChild(snake3.gamePad);
				}
			}
			addChild(snake1.gamePad);
			
			
			AllSnkCtrl(true);
		}
		
		private function makeBG(Height:int,Width:int):void//场地
		{
			BackGround=new Background(Height,Width);
			for(var a:int=0;a<Height;a++)
			{
				for(var b:int=0;b<Width;b++)
				{
					addChildAt(BackGround.BG[a][b],0);
				}
			}
		}
		
		public function SnakeACT(event:TimerEvent):void
		{
			if(event.currentTarget==snake1.timer)
			{
				if(TouchTest(snake1.snake,null,"Field")==true)
				{
					GameOver();
				}
				if(TouchTest(snake1.snake,Gems.gemsARR,"SnakeGem")==true)
				{
					snake1.Grow();
					addChild(snake1.snake[snake1.Length-1]);
				}
				if(buttons.switchOnOff.fps==2){
					if(buttons.switch123.fps>=2 && TouchTest(snake1.snake,snake2.snake,"SnakeSnake")==true){
						GameOver();
					}
					if(buttons.switch123.fps==3 && TouchTest(snake1.snake,snake3.snake,"SnakeSnake")==true){
						GameOver();
					}
				}
			}
			
			if(event.currentTarget==snake2.timer){
				if(TouchTest(snake2.snake,null,"Field")==true)
				{
					GameOver();
				}
				if(TouchTest(snake2.snake,Gems.gemsARR,"SnakeGem")==true){
					snake2.Grow();
					addChild(snake2.snake[snake2.Length-1]);
				}
				if(buttons.switchOnOff.fps==2){
					if(TouchTest(snake2.snake,snake1.snake,"SnakeSnake")==true){
						GameOver();
					}
					if(buttons.switch123.fps==3  && TouchTest(snake2.snake,snake3.snake,"SnakeSnake")==true){
						GameOver();
					}
				}
			}
			
			if(event.currentTarget==snake3.timer)
			{
				if(TouchTest(snake3.snake,null,"Field")==true)
				{
					GameOver();
				}
				if(TouchTest(snake3.snake,Gems.gemsARR,"SnakeGem")==true)
				{
					snake3.Grow();
					addChild(snake3.snake[snake1.Length-1]);
				}
				if(buttons.switchOnOff.fps==2){
					if(TouchTest(snake3.snake,snake1.snake,"SnakeSnake")==true || TouchTest(snake3.snake,snake2.snake,"SnakeSnake")==true)
					{
						GameOver();
					}
				}
			}
		}
		
		private function AllSnkCtrl(ctrl:Boolean):void//true=start,,false=stop
		{
			if(ctrl==true){
				snake1.timer.start();
				if(buttons.switch123.fps>=2){
					snake2.timer.start();
				}
				if(buttons.switch123.fps==3){
					snake3.timer.start();
				}
			}
			else if(ctrl==false){
				snake1.timer.stop();
				if(buttons.switch123.fps>=2){
					snake2.timer.stop();
				}
				if(buttons.switch123.fps==3){
					snake3.timer.stop();
				}
			}
		}
	}
}