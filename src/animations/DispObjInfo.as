package animations 
{
	import flash.display.DisplayObject;
	/**
	 * Used to provide data necessary to control the display order of DisplayObjects in tween controlled animations.
	 * @author 
	 */
	public class DispObjInfo 
	{
		//The time in the animation that this info should be active
		private var time:Number = 0.0;
		//The name of the display object this DispObjInfo will affect
		private var controlDispObj:String = null;
		//The name of the display object that is used for special purposes such as masking.
		private var targetDispObj:String = null;
		//Flags that change the behavior of using the targetDispObj. 0 means nothing special (depth is absolute), 1 is relative (depth will be set relative to the targetDispObj's depth), 2 is masked (controlDispObj will be masked by the targetDispObj and will be 1 depth behind targetDispObj, depth will control the priority the controlDispObj will have when masked with other display objects.) 3 will have the control object added to the target object as a child.
		private var targetFlag:int;
		//The depth priority at which the controlDispObj will be placed for the animation. A lower value means to be behind other display objects.
		private var depth:int = 0;
		
		//Constructor for a new DisplayObjectInfo instance.
		public function DispObjInfo(controlDispName:String, dispDepth:int, startTime:Number, targetDispName:String=null, flag:int=0) 
		{
			controlDispObj = controlDispName;
			depth = dispDepth;
			time = startTime;
			targetDispObj = targetDispName;
			targetFlag = flag;
		}
		
		//Getters
		public function GetStartTime():Number{ return time;}
		public function GetControlObjectName():String{ return controlDispObj;}
		public function GetTargetObjName():String{ return targetDispObj;}
		public function GetTargetFlag():int { return targetFlag;}
		public function GetDepth():int { return depth; }	
		
	}

}