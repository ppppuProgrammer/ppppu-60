/*
 * BetweenAS3
 * 
 * Licensed under the MIT License
 * 
 * Copyright (c) 2009 BeInteractive! (www.be-interactive.org) and
 *                    Spark project  (www.libspark.org)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */
package org.libspark.betweenas3.core.updaters.geom 
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import org.libspark.betweenas3.core.updaters.AbstractUpdater;
	import org.libspark.betweenas3.core.utils.ClassRegistry;
	/**
	 * ...
	 * @author 
	 */
	public class MatrixUpdater extends AbstractUpdater
	{
		public static const TARGET_PROPERTIES:Array = [
			'a',
			'b',
			'c',
			'd',
			'tx',
			'ty'//,
			//'_matrix'
		];
		
		public static function register(registry:ClassRegistry):void
		{
			registry.registerClassWithTargetClassAndPropertyNames(MatrixUpdater, Matrix, TARGET_PROPERTIES);
		}
		
		protected var _target:Matrix = null;
		protected var _source:Vector.<Number> = new Vector.<Number>(6, true);
		protected var _destination:Vector.<Number> = new Vector.<Number>(6, true);
		protected var _workMatrix:Matrix = new Matrix();
		/**
		 * @inheritDoc
		 */
		override public function get target():Object
		{
			return _target;
		}
		
		/**
		 * @private
		 */
		override public function set target(value:Object):void
		{
			_target = (value as Matrix);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setSourceValue(propertyName:String, value:Number, isRelative:Boolean = false):void
		{
			switch(propertyName)
			{
				case 'a':
					_source[0] = value;
					break;
				case 'b':
					_source[1] = value;
					break;
				case 'c':
					_source[2] = value;
					break;
				case 'd':
					_source[3] = value;
					break;
				case 'tx':
					_source[4] = value;
					break;
				case 'ty':
					_source[5] = value;
					break;
			}
			
			/*if (propertyName == 'x') {
				_fx = true;
				_sx = value;
				_flags |= isRelative ? 0x001 : 0;
			}
			else if (propertyName == 'y') {
				_fy = true;
				_sy = value;
				_flags |= isRelative ? 0x004 : 0;
			}*/
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setDestinationValue(propertyName:String, value:Number, isRelative:Boolean = false):void
		{
			switch(propertyName)
			{
				case 'a':
					_destination[0] = value;
					break;
				case 'b':
					_destination[1] = value;
					break;
				case 'c':
					_destination[2] = value;
					break;
				case 'd':
					_destination[3] = value;
					break;
				case 'tx':
					_destination[4] = value;
					break;
				case 'ty':
					_destination[5] = value;
					break;
			}
			/*if (propertyName == 'x') {
				_fx = true;
				_dx = value;
				_flags |= isRelative ? 0x002 : 0;
			}
			else if (propertyName == 'y') {
				_fy = true;
				_dy = value;
				_flags |= isRelative ? 0x008 : 0;
			}*/
		}
		
		/**
		 * @inheritDoc
		 */
		/*override public function getObject(propertyName:String):Object
		{
			switch(propertyName)
			{
				case "_matrix":
					return target.transform.matrix;
					break;
				case 'a':
					break;
				case 'b':
					break;
				case 'c':
					break;
				case 'd':
					break;
				case 'tx':
					break;
				case 'ty':
					break;
			}
			return null;
		}
		
		override public function setObject(propertyName:String, value:Object):void
		{
			switch(propertyName)
			{
				case "_matrix":
					target.transform.matrix = value;
					break;
			}
		}*/
		
		override protected function resolveValues():void 
		{
			/*var t:Point = _target;
			
			if (_fx) {
				if (isNaN(_sx)) {
					_sx = t.x;
				}
				else if ((_flags & 0x001) != 0) {
					_sx += t.x;
				}
				if (isNaN(_dx)) {
					_dx = t.x;
				}
				else if ((_flags & 0x002) != 0) {
					_dx += t.x;
				}
			}
			if (_fy) {
				if (isNaN(_sy)) {
					_sy = t.y;
				}
				else if ((_flags & 0x004) != 0) {
					_sy += t.y;
				}
				if (isNaN(_dy)) {
					_dy = t.y;
				}
				else if ((_flags & 0x008) != 0) {
					_dy += t.y;
				}
			}*/
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function updateObject(factor:Number):void 
		{
			var invert:Number = 1.0 - factor;
			var _s:Vector.<Number> = _source;
			var _d:Vector.<Number> = _destination;
			_workMatrix.setTo(_s[0] * invert + _d[0] * factor,
			_s[1] * invert + _d[1] * factor,
			_s[2] * invert + _d[2] * factor,
			_s[3] * invert + _d[3] * factor,
			_s[4] * invert + _d[4] * factor,
			_s[5] * invert + _d[5] * factor);
			_target = _workMatrix;
			/*if (_target != null)
				trace("Uodating matrix");*/
			/*var t:Point = _target;
			
			var invert:Number = 1.0 - factor;
			
			if (_fx) {
				t.x = _sx * invert + _dx * factor;
			}
			if (_fy) {
				t.y = _sy * invert + _dy * factor;
			}*/
		}
		
		override protected function newInstance():AbstractUpdater 
		{
			return new MatrixUpdater();
		}
		
		override protected function copyFrom(source:AbstractUpdater):void 
		{
			/*super.copyFrom(source);
			
			var obj:PointUpdater = source as PointUpdater;
			
			_target = obj._target;
			_sx = obj._sx;
			_sy = obj._sy;
			_dx = obj._dx;
			_dy = obj._dy;
			_fx = obj._fx;
			_fy = obj._fy;
			_flags = obj._flags;*/
		}
		
	}

}