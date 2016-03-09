package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.OutputProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.Video;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	
	public class tetris extends Sprite
	{
		private var ARR:Array
		private var SQARR:Array;
		private var sqadd:Array;
		private var CELLARR:Array;
		private var sqfalling:Boolean;
		private var isbottom:Boolean;
		private var lefttest:Boolean;
		private var righttest:Boolean;
		private var spintest:Boolean;
		private var WIDTH:int;
		private var LENGTH:int;
		private var txt:TextField;
		private var score:int;
		private var txtstyle:TextFormat=new TextFormat;
		private var speed:int;
		private var timer:Timer;
		
		
		public function tetris()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;	
			setTimeout(stageinit,200);
			
			function stageinit():void{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,control);
			timer.start();
			}
			
			WIDTH=10;
			LENGTH=20;
			ARR=new Array();
			for (var y:int=0;y<LENGTH;y++ )
			{
				var arr:Array=new Array();
				for(var x:int=0; x<WIDTH; x++ )
				{	
					arr[x]= 0 ;
					arr[0]=2;
					arr[WIDTH-1]=2;
				}	
				ARR[y]=arr;
//				trace(ARR[y]);
			}
			var bottom:Array=new Array;
			for(x=0; x<WIDTH; x++ )
			{
				bottom[x]=1;
			}
			ARR[LENGTH]=bottom;
//			trace(ARR[LENGTH]);
			score=0;
			txtstyle.size=25;
			txt=new TextField;
			txt.border=true;
			txt.height=30;
			txt.width=200;
			txt.x=320;
			txt.text="SCORE:"+score*100;
			txt.setTextFormat(txtstyle);
			addChild(txt);
			newmap();
			sqfalling=false;
			timer=new Timer(250) ;			
			timer.addEventListener("timer",fall)
			function fall(event:TimerEvent):void
			{						
				if(sqfalling==false)
				{					
					
					SQARR=new Array;
					var sqarr1:Array=new Array;
					createsq(sqarr1);	
					SQARR=sqarr1;
					SQARR.x=1;
					SQARR.y=0;
					var nextsq:Array=new Array;
					var sqarr2:Array=new Array;
					createsq(sqarr2);
					nextsq=sqarr2;
					nextsq.x=15;
					nextsq.y=5;
					
					sqadd=new Array;
					for(var sqnum:int=0;sqnum<4;sqnum++)
					{
						var sq:Sprite=new Sprite();			
						sq.graphics.lineStyle(2,0xFFFFFF,1);
						sq.graphics.beginFill(0x000000);
						sq.graphics.drawRect(0,0,30,30);
						sqadd[sqnum]=sq;
						addChild(sqadd[sqnum]);
					}
					
					sqfalling=true;
				}	
				SQARR.y=SQARR.y+1;	
				sqnum=0;
				for(var a:int=0;a<4;a++)
				{
					for(var b:int=0;b<4;b++)
					{
						if (SQARR[a][b]==1)
						{
							sqadd[sqnum].x=(SQARR.x+b)*30;
							sqadd[sqnum].y=(SQARR.y+a)*30;
							sqnum=sqnum+1;
						}
					}
				}
				
				bottomtest(SQARR);
				isbottom=false;
				lefttest=false;
				righttest=false;
				spintest=false;
			}
			
			var upbtn:UPbtn=new UPbtn;
			upbtn.addEventListener(MouseEvent.CLICK,GOup);
			function GOup(event:MouseEvent):void{
				var SPINARR:Array=new Array;
				SPINARR.x=SQARR.x;
				SPINARR.y=SQARR.y;
				for(var g:int=0;g<4;g++)
				{
					var spinarr:Array=new Array;
					for(var h:int=0;h<=3;h++)
					{
						spinarr[h]=SQARR[3-h][g];	
						
					}	
					SPINARR[g]=spinarr;
				}
				SPINTEST(SPINARR);
				if(spintest==false){
					SQARR=SPINARR; 
				}		
			}
			upbtn.x=400;
			upbtn.y=300;
			addChild(upbtn);
			var downbtn:DOWNbtn=new DOWNbtn;
			downbtn.addEventListener(MouseEvent.CLICK,GOdown);
			function GOdown(eevent:MouseEvent):void{
				timer.delay=150;
			}
			downbtn.x=400;
			downbtn.y=390;
			addChild(downbtn);
			var leftbtn:LEFTbtn=new LEFTbtn;
			leftbtn.addEventListener(MouseEvent.CLICK,GOleft);
			function GOleft(event:MouseEvent):void
			{
				
				xmovetest(SQARR);
				if(lefttest==false ){
					SQARR.x=SQARR.x-1;
				}
			}
			leftbtn.x=355;
			leftbtn.y=345;
			addChild(leftbtn);
			var rightbtn:RIGHTbtn=new RIGHTbtn;
			rightbtn.addEventListener(MouseEvent.CLICK,GOright);
			function GOright(event:MouseEvent):void{
				xmovetest(SQARR);
				if(righttest==false){
					SQARR.x=SQARR.x+1;
				}
			}
			rightbtn.x=445;
			rightbtn.y=345;
			addChild(rightbtn);
		}
		private function createsq(sqarr:Array):void
		{
			var sqtype:int=int(Math.random()*7);
			
			
			if(sqtype==0){
				sqarr[0]=[0,1,0,0];
				sqarr[1]=[0,1,0,0];
				sqarr[2]=[0,1,0,0];
				sqarr[3]=[0,1,0,0];               
			}//I
			else if(sqtype==1){
				sqarr[0]=[0,0,0,0];
				sqarr[1]=[0,1,0,0];
				sqarr[2]=[1,1,1,0];	
				sqarr[3]=[0,0,0,0];      
			}//A
			else if(sqtype==2){
				sqarr[0]=[0,0,0,0];
				sqarr[1]=[0,1,1,0];
				sqarr[2]=[1,1,0,0];	
				sqarr[3]=[0,0,0,0]; 
			}//S
			else if(sqtype==3){
				sqarr[0]=[0,0,0,0];
				sqarr[1]=[1,1,0,0];
				sqarr[2]=[0,1,1,0];	
				sqarr[3]=[0,0,0,0]; 
			}//Z
			else if(sqtype==4){
				sqarr[0]=[0,0,0,0];
				sqarr[1]=[0,1,0,0];
				sqarr[2]=[0,1,0,0];	
				sqarr[3]=[0,1,1,0]; 
			}//L
			else if(sqtype==5){
				sqarr[0]=[0,0,0,0];
				sqarr[1]=[0,0,1,0];
				sqarr[2]=[0,0,1,0];	
				sqarr[3]=[0,1,1,0]; 
			}//J
			else if(sqtype==6){
				sqarr[0]=[0,0,0,0];
				sqarr[1]=[0,1,1,0];
				sqarr[2]=[0,1,1,0];	
				sqarr[3]=[0,0,0,0]; 
			}//O
			
		}
		
		
		private function bottomtest(SQARR:Array):void
		{
			for(var a:int=0;a<=3;a++)
			{
				for(var b:int=0;b<=3;b++)
				{
					if(SQARR[a][b]==1 && ARR[SQARR.y+a+1][SQARR.x+b]==1)
					{
						isbottom=true;
					}
				}
			}
			if(isbottom==true){
				printblack();
				clear();
				for(var i:String in sqadd)
				{
					removeChild(sqadd[i]);
				}
				sqadd = null;
				sqfalling=false;
				
			}
		}
		
		private function printblack():void
		{
			for(var a:int=0;a<=3;a++)
			{
				for(var b:int=0;b<=3;b++)
				{
					if(SQARR[a][b]==1)
					{
						ARR[SQARR.y+a][SQARR.x+b]=1;
						var cell:Sprite=new Sprite();
						cell.graphics.lineStyle(2,0xFFFFFF,1);	
						cell.graphics.beginFill(0x000000);
						cell.graphics.drawRect(0,0,30,30);	
						CELLARR[SQARR.y+a][SQARR.x+b]=cell;
						CELLARR[SQARR.y+a][SQARR.x+b].x=(SQARR.x+b)*30;
						CELLARR[SQARR.y+a][SQARR.x+b].y=(SQARR.y+a)*30;
						addChild(CELLARR[SQARR.y+a][SQARR.x+b]);
						timer.delay=350;
					}
				}
			}
		}
		
		private function clear():void
		{
			var needclear:Boolean=false;
			for(var a:int=0;a<LENGTH;a++)
			{
				var sqcount:int=0;
				for(var b:int=0;b<WIDTH;b++){
					if(ARR[a][b]==1){
						sqcount++;
					}
					
					if(ARR[a][b]==0){
						break;
					}
				}
				if(sqcount==WIDTH-2){
					ARR.splice(a,1);					
					var newarr:Array=new Array();
					for(var c:int=0; c<WIDTH; c++ )
					{	
						newarr[c]=0;
						newarr[0]=2;
						newarr[WIDTH-1]=2;
					}
					ARR.unshift(newarr);
					needclear=true;
					score=score+1;
					txt.text="SCORE:"+score*100;
					txt.setTextFormat(txtstyle);
					addChild(txt);
				}
			}
			if (needclear==true){
				newmap();
				timer.stop();
				timer.delay=timer.delay-score;
				timer.start();
			}
		}
		
		
		private function newmap():void
		{
			CELLARR=new Array;
			for (y=0;y<=LENGTH;y++ ){
				var cellarr:Array=new Array;
				for(x=0; x<WIDTH; x++ )
				{
					var cell:Sprite=new Sprite();
					cell.graphics.lineStyle(2,0xFFFFFF,1);	
					if(ARR[y][x]==0){
						cell.graphics.beginFill(0xABCDEF);	
					}else if(ARR[y][x]==1){
						cell.graphics.beginFill(0x000000);
					}else {
						cell.graphics.beginFill(0xFEDCBA);
					}
					cell.graphics.drawRect(0,0,30,30);																	
					cellarr[x]=cell;
					cellarr[x].x=x*30;
					cellarr[x].y=y*30;
					addChild(cellarr[x]);
				}
				CELLARR[y]=cellarr;
			}
		}
		
		private function xmovetest(SQARR:Array):void
		{
			for(var a:int=0;a<=3;a++)
			{
				for(var b:int=0;b<=3;b++)
				{
					if(SQARR[a][b]==1)
					{
						if(ARR[SQARR.y+a][SQARR.x+b-1]==2 ||ARR[SQARR.y+a][SQARR.x+b-1]==1)
						{
							lefttest=true;
						}
						if(ARR[SQARR.y+a][SQARR.x+b+1]==2 || ARR[SQARR.y+a][SQARR.x+b+1]==1 )
						{
							righttest=true;
						}
					}
				}
			}	
		}
		
		private function SPINTEST(testarr:Array):void
		{
			for(var a:int=0;a<=3;a++)
			{
				for(var b:int=0;b<=3;b++)
				{
					if(testarr[a][b]==1)
					{
						if(ARR[testarr.y+1+a][testarr.x+b]==2 || ARR[testarr.y+1+a][testarr.x+b]==1)
						{
							spintest=true;
						}
					}
				}
			}	
		}
		
		private function control (event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
					var SPINARR:Array=new Array;
					SPINARR.x=SQARR.x;
					SPINARR.y=SQARR.y;
					for(var g:int=0;g<4;g++)
					{
						var spinarr:Array=new Array;
						for(var h:int=0;h<=3;h++)
						{
							spinarr[h]=SQARR[3-h][g];															
						}	
						SPINARR[g]=spinarr;
					}
					SPINTEST(SPINARR);
					if(spintest==false){
						SQARR=SPINARR; 
					}						
					break;	
				case Keyboard.LEFT:
					
					xmovetest(SQARR);
					if(lefttest==false ){
						SQARR.x=SQARR.x-1;
					}
					
					break;
				case Keyboard.RIGHT:
					
					xmovetest(SQARR);
					if(righttest==false){
						SQARR.x=SQARR.x+1;
					}
					
					break;
				case Keyboard.DOWN:
					timer.delay=150;
			}
		}
		
		private function printMap ( map:Array ) : void
		{
			for ( var xx:int=0; xx<=LENGTH; xx++ )
			{
				trace(map[xx]);
			}
		}
	}
	
}