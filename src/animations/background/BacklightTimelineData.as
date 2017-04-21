package animations.background
{
	import animations.TimelineDefinition
	public class BacklightTimelineData extends TimelineDefinition
	{
		public function BacklightTimelineData()
		{
			timelineData = new Object();
			timelineData.TIME_PER_FRAME = 0.03333333333333333;
			timelineData.targetName = "Backlight";
			var tweenPropVector:Vector.<Object> = new Vector.<Object>();
			tweenPropVector[tweenPropVector.length]= {visible:false};
			tweenPropVector[tweenPropVector.length]= {duration:59,transformMatrix:{a:1.037322998046875,b:0,c:0,d:0.986572265625,tx:69.75,ty:210.2}, colorTransform:{alphaMultiplier:0.5}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:1.037322998046875,b:0,c:0,d:0.986572265625,tx:69.75,ty:214.45}, colorTransform:{alphaMultiplier:0.5}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.151611328125,b:0,c:0,d:1.09527587890625,tx:50.7,ty:195.6}, colorTransform:{alphaMultiplier:0.53}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.257476806640625,b:0,c:0,d:1.1959686279296875,tx:33.05,ty:178.35}, colorTransform:{alphaMultiplier:0.56}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.3548583984375,b:0,c:0,d:1.28857421875,tx:16.85,ty:163}, colorTransform:{alphaMultiplier:0.58}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.4437713623046875,b:0,c:0,d:1.37310791015625,tx:2.05,ty:149.45}, colorTransform:{alphaMultiplier:0.6}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.52423095703125,b:0,c:0,d:1.44964599609375,tx:-11.299,ty:137.55}, colorTransform:{alphaMultiplier:0.62}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.59619140625,b:0,c:0,d:1.518096923828125,tx:-23.249,ty:127.5}, colorTransform:{alphaMultiplier:0.64}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.65972900390625,b:0,c:0,d:1.5784912109375,tx:-33.849,ty:119.1}, colorTransform:{alphaMultiplier:0.65}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.714752197265625,b:0,c:0,d:1.6308441162109375,tx:-42.999,ty:112.6}, colorTransform:{alphaMultiplier:0.67}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.761322021484375,b:0,c:0,d:1.675140380859375,tx:-50.699,ty:107.6}, colorTransform:{alphaMultiplier:0.67}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.7994384765625,b:0,c:0,d:1.71136474609375,tx:-57.099,ty:104.25}, colorTransform:{alphaMultiplier:0.69}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.829071044921875,b:0,c:0,d:1.73956298828125,tx:-61.999,ty:102.55}, colorTransform:{alphaMultiplier:0.69}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.850250244140625,b:0,c:0,d:1.75970458984375,tx:-65.599,ty:102.4}, colorTransform:{alphaMultiplier:0.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.862945556640625,b:0,c:0,d:1.7717742919921875,tx:-67.649,ty:103.8}, colorTransform:{alphaMultiplier:0.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.8671875,b:0,c:0,d:1.77581787109375,tx:-68.399,ty:106.65}, colorTransform:{alphaMultiplier:0.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.037322998046875,b:0,c:0,d:0.986572265625,tx:69.75,ty:214.45}, colorTransform:{alphaMultiplier:0.5}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.22613525390625,b:0,c:0,d:1.1661376953125,tx:38.3,ty:183.75}, colorTransform:{alphaMultiplier:0.53}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.4010009765625,b:0,c:0,d:1.33245849609375,tx:9.25,ty:155.6}, colorTransform:{alphaMultiplier:0.56}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.5618896484375,b:0,c:0,d:1.4854583740234375,tx:-17.599,ty:130.15}, colorTransform:{alphaMultiplier:0.58}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.708770751953125,b:0,c:0,d:1.625152587890625,tx:-41.999,ty:107.3}, colorTransform:{alphaMultiplier:0.6}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.8416595458984375,b:0,c:0,d:1.751556396484375,tx:-64.099,ty:87.2}, colorTransform:{alphaMultiplier:0.62}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.9605560302734375,b:0,c:0,d:1.8646087646484375,tx:-83.999,ty:69.7}, colorTransform:{alphaMultiplier:0.64}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.0654754638671875,b:0,c:0,d:1.9644012451171875,tx:-101.299,ty:54.65}, colorTransform:{alphaMultiplier:0.65}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.156402587890625,b:0,c:0,d:2.050872802734375,tx:-116.449,ty:42.45}, colorTransform:{alphaMultiplier:0.67}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.23333740234375,b:0,c:0,d:2.1240234375,tx:-129.299,ty:32.7}, colorTransform:{alphaMultiplier:0.67}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.2962646484375,b:0,c:0,d:2.18389892578125,tx:-139.749,ty:25.4}, colorTransform:{alphaMultiplier:0.69}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.34521484375,b:0,c:0,d:2.23046875,tx:-147.899,ty:20.6}, colorTransform:{alphaMultiplier:0.69}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.38018798828125,b:0,c:0,d:2.26373291015625,tx:-153.749,ty:18.25}, colorTransform:{alphaMultiplier:0.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.40118408203125,b:0,c:0,d:2.2836761474609375,tx:-157.249,ty:18.4}, colorTransform:{alphaMultiplier:0.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.408203125,b:0,c:0,d:2.29034423828125,tx:-158.499,ty:20.8}, colorTransform:{alphaMultiplier:0.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.037322998046875,b:0,c:0,d:0.986572265625,tx:69.75,ty:214.45}, colorTransform:{alphaMultiplier:0.5}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.22613525390625,b:0,c:0,d:1.1661376953125,tx:38.3,ty:183.75}, colorTransform:{alphaMultiplier:0.53}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.4010009765625,b:0,c:0,d:1.33245849609375,tx:9.25,ty:155.6}, colorTransform:{alphaMultiplier:0.56}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.5618896484375,b:0,c:0,d:1.4854583740234375,tx:-17.599,ty:130.15}, colorTransform:{alphaMultiplier:0.58}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.708770751953125,b:0,c:0,d:1.625152587890625,tx:-41.999,ty:107.3}, colorTransform:{alphaMultiplier:0.6}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.8416595458984375,b:0,c:0,d:1.751556396484375,tx:-64.099,ty:87.2}, colorTransform:{alphaMultiplier:0.62}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.9605560302734375,b:0,c:0,d:1.8646087646484375,tx:-83.999,ty:69.7}, colorTransform:{alphaMultiplier:0.64}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.0654754638671875,b:0,c:0,d:1.9644012451171875,tx:-101.299,ty:54.65}, colorTransform:{alphaMultiplier:0.65}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.156402587890625,b:0,c:0,d:2.050872802734375,tx:-116.449,ty:42.45}, colorTransform:{alphaMultiplier:0.67}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.23333740234375,b:0,c:0,d:2.1240234375,tx:-129.299,ty:32.7}, colorTransform:{alphaMultiplier:0.67}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.2962646484375,b:0,c:0,d:2.18389892578125,tx:-139.749,ty:25.4}, colorTransform:{alphaMultiplier:0.69}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.34521484375,b:0,c:0,d:2.23046875,tx:-147.899,ty:20.6}, colorTransform:{alphaMultiplier:0.69}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.38018798828125,b:0,c:0,d:2.26373291015625,tx:-153.749,ty:18.25}, colorTransform:{alphaMultiplier:0.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.40118408203125,b:0,c:0,d:2.2836761474609375,tx:-157.249,ty:18.4}, colorTransform:{alphaMultiplier:0.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.408203125,b:0,c:0,d:2.29034423828125,tx:-158.499,ty:20.8}, colorTransform:{alphaMultiplier:0.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.037322998046875,b:0,c:0,d:0.986572265625,tx:69.75,ty:214.45}, colorTransform:{alphaMultiplier:0.5}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.264312744140625,b:0,c:0,d:1.20245361328125,tx:31.95,ty:175.45}, colorTransform:{ redMultiplier:0.83, greenMultiplier:0.83, blueMultiplier:0.83, alphaMultiplier:0.59, redOffset:44, greenOffset:44, blueOffset:0, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.46966552734375,b:0,c:0,d:1.3977508544921875,tx:-2.249,ty:140.45}, colorTransform:{ redMultiplier:0.67, greenMultiplier:0.67, blueMultiplier:0.67, alphaMultiplier:0.67, redOffset:84, greenOffset:84, blueOffset:0, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.6534423828125,b:0,c:0,d:1.572540283203125,tx:-32.899,ty:109.75}, colorTransform:{ redMultiplier:0.53, greenMultiplier:0.53, blueMultiplier:0.53, alphaMultiplier:0.74, redOffset:120, greenOffset:120, blueOffset:0, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.8155517578125,b:0,c:0,d:1.726715087890625,tx:-59.749,ty:83.25}, colorTransform:{ redMultiplier:0.41, greenMultiplier:0.41, blueMultiplier:0.41, alphaMultiplier:0.8, redOffset:152, greenOffset:152, blueOffset:0, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.956085205078125,b:0,c:0,d:1.8603973388671875,tx:-83.149,ty:60.9}, colorTransform:{ redMultiplier:0.3, greenMultiplier:0.3, blueMultiplier:0.3, alphaMultiplier:0.85, redOffset:179, greenOffset:179, blueOffset:0, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.0749969482421875,b:0,c:0,d:1.973480224609375,tx:-102.999,ty:42.65}, colorTransform:{ redMultiplier:0.21, greenMultiplier:0.21, blueMultiplier:0.21, alphaMultiplier:0.9, redOffset:202, greenOffset:202, blueOffset:0, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.1722869873046875,b:0,c:0,d:2.066009521484375,tx:-119.199,ty:28.45}, colorTransform:{ redMultiplier:0.13, greenMultiplier:0.13, blueMultiplier:0.13, alphaMultiplier:0.94, redOffset:221, greenOffset:221, blueOffset:0, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.2555389404296875,b:0,c:0,d:2.14520263671875,tx:-133.049,ty:17.15}, colorTransform:{brightness:0.25}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.3319091796875,b:0,c:0,d:2.21783447265625,tx:-145.699,ty:7.2}, colorTransform:{ redMultiplier:0.03, greenMultiplier:0.03, blueMultiplier:0.03, alphaMultiplier:0.99, redOffset:247, greenOffset:247, blueOffset:0, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.40185546875,b:0,c:0,d:2.2843475341796875,tx:-157.349,ty:-1.299}, colorTransform:{ redMultiplier:0.01, greenMultiplier:0.01, blueMultiplier:0.01, alphaMultiplier:1, redOffset:253, greenOffset:253, blueOffset:0, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:2.46484375,b:0,c:0,d:2.34423828125,tx:-167.849,ty:-8.599}, colorTransform:{ redMultiplier:0, greenMultiplier:0, blueMultiplier:0, alphaMultiplier:1, redOffset:255, greenOffset:255, blueOffset:0, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:1.72943115234375,b:0,c:0,d:1.72943115234375,tx:-204.849,ty:-83.699}, colorTransform:{alphaMultiplier:0}};
			tweenPropVector[tweenPropVector.length]= {duration:2,transformMatrix:{a:1.72943115234375,b:0,c:0,d:1.72943115234375,tx:-204.849,ty:-83.699}, colorTransform:{alphaMultiplier:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}