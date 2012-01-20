/**
 * 	 * @author - ddennis.dk AKA meresukker.dk AKA fantatisk.dk
 *     Based on Keith Peters minimal comps - RangeSlider
 *
 */

package com.ddennis.display.interactive {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class RangeSliderDD extends Sprite {
		
		public static const RANGE_UPDATE:String = "rangeUpdate"
		
		//protected var _labelMode:String = ALWAYS;
		protected var _labelPosition:String;
		protected var _labelPrecision:int = 0;
		
		protected var _lowValue:Number = 0;
		protected var _highValue:Number = 100;
		
		protected var _rangeValue:Number = 100; // bruges ikke
		protected var _rangeValueMin:Number = 0; // bruges ikke
		protected var _rangeValueMax:Number = 100; // bruges ikke
		
		protected var _max:Number = 100; // bruges til draggeren
		protected var _min:Number = 0;
		
		protected var _maximum:Number = 100;
		protected var _minimum:Number = 0;
		
		public var _back:DisplayObjectContainer;
		private var _maxHandle:MovieClip;
		private var _minHandle:MovieClip;
		
		
		protected var _orientation:String = VERTICAL;
		protected var _tick:Number = 1;
		
		public static const ALWAYS:String = "always";
		public static const BOTTOM:String = "bottom";
		public static const HORIZONTAL:String = "horizontal";
		public static const LEFT:String = "left";
		public static const MOVE:String = "move";
		public static const NEVER:String = "never";
		public static const RIGHT:String = "right";
		public static const TOP:String = "top";
		public static const VERTICAL:String = "vertical";
		private var _width:Number = 0
		private var _height:Number = 0
		private var range:Number;
		public var _dragger:MovieClip;
		
		public var _value:Number = 0;
		
		private var _minimumScale:int = 20
		
		public var minRatio:Number = 0;
		public var maxRatio:Number = 1;
		
		/**
		 * Constructor
		 * @param orientation Whether the slider will be horizontal or vertical.
		 * @param parent The parent DisplayObjectContainer on which to add this Slider.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 */
		public function RangeSliderDD(orientation:String, parent:DisplayObjectContainer, minHandler:MovieClip, maxHandler:MovieClip, dragger:MovieClip, back:DisplayObjectContainer = null){
			_orientation = orientation;
			
			_back = back
			_minHandle = minHandler
			_maxHandle = maxHandler
			_dragger = dragger
			
			init()
		}

		
		/**
		 * Initializes the component.
		 */
		protected function init():void {
			if (_orientation == HORIZONTAL){
				setSize(500, 10);
				//_labelPosition = TOP;
			} else {
				setSize(10, 110);
				//_labelPosition = RIGHT;
			}
			addChildren()
		}

		/**
		 * Creates and adds the child display objects of this component.
		 */
		protected function addChildren():void {
			if (!_back){
				_back = drawBack()
			}
			
			addChild(_back);
			
			setSize(_back.width, _back.height)
			
			_back.x = 0
			_back.y = 0
			addChild(_back)
			
			_dragger.x = 0
			_dragger.y = 0
			addChild(_dragger)
			
			_minHandle.x = 0
			_minHandle.y = 0
			addChild(_minHandle)
			
			_maxHandle.x = 0
			_maxHandle.y = 0
			addChild(_maxHandle)
			
			_dragger.addEventListener(MouseEvent.MOUSE_DOWN, onDragDragger);
			_dragger.buttonMode = true
			
			_minHandle.addEventListener(MouseEvent.MOUSE_DOWN, onDragMin);
			_minHandle.buttonMode = true;
			
			addChild(_minHandle);
			
			_maxHandle.addEventListener(MouseEvent.MOUSE_DOWN, onDragMax);
			_maxHandle.buttonMode = true;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			// positionHandles()
		}
		
		/**
		 * Draws the back of the slider.
		 */
		public function drawBack():MovieClip {
			//trace ("Slider.as > drawBack  = "+drawBack)
			var b = new MovieClip();
			b.graphics.clear();
			b.graphics.beginFill(0x666666);
			b.graphics.drawRect(0, 0, _width, _height);
			b.graphics.endFill();
			return b
		}
		
		/**
		 * Adjusts positions of handles when value, maximum or minimum have changed.
		 * TODO: Should also be called when slider is resized.
		 */
		protected function positionHandles():void {
			if (_orientation == HORIZONTAL){
				range = _back.width;
				//_minHandle.x = (_lowValue - _minimum) / (_maximum - _minimum) * range;			
				//_maxHandle.x =  (_highValue - _minimum) / (_maximum - _minimum) * range;
				//_maxHandle.x =  (_highValue - _minimum) / (_maximum - _minimum) * range;

				//_dragger.x = _minHandle.x + _minHandle.width
				//_dragger.width = _maxHandle.x -  ( _minHandle.x+ _minHandle.width)
			} else {
				range = _height - _back.width * 2;
				_minHandle.y = _height - _back.width - (_lowValue - _minimum) / (_maximum - _minimum) * range;
				_maxHandle.y = _height - _back.width * 2 - (_highValue - _minimum) / (_maximum - _minimum) * range;
			}
			//updateLabels();
		}
		
		public function positionDragger():void {
			var range:Number;
			if (_orientation == HORIZONTAL){
				
				range = _back.width - _maxHandle.width // - _minHandle.width
				
				_dragger.width = (_highValue / (_maximum - _minimum)) * (_back.width - (_minHandle.width + _maxHandle.width))
				
				//var newXpos:Number = (( _value / (_max - _min)  ) * range   ) 
				//_dragger.x = newXpos //Clamp(_minimum , newXpos ,  
				//trace ("RangeSliderDD.as > newXpos  = "+newXpos)
				
				//_dragger.y = 10
				_maxHandle.x = _dragger.x + _dragger.width
				//  100 =  ( ( x  )  /  ( _back.width - ( _minHandle.width + _maxHandle.width ) )  )  * _maximum 			
			} else {
				//range = height 
				_dragger.y = _back.height / (_max - _min) * _value //  - (_value - _min) / (_max - _min) * range;
				
			}
		
		}
		
		function Clamp(low, val, high){
			return Math.min(Math.max(val, low), high);
		
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		private function onAdded(event:Event):void {
			positionHandles();
			onMinSlide();
		}
		
		/**
		 * Internal mouseDown handler for the low value handle. Starts dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onDragMin(event:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMinSlide);
			if (_orientation == HORIZONTAL){
				_minHandle.startDrag(false, new Rectangle(0, 0, _maxHandle.x - _minHandle.width, 0));
			} else {
				//_minHandle.startDrag(false, new Rectangle(0, _maxHandle.y + _width, 0, _height - _maxHandle.y - _width * 2));
			}
			/*if(_labelMode == MOVE){
			   _lowLabel.visible = true;
			   _highLabel.visible = true;
			}*/
		}
		
		/**
		 * Internal mouseDown handler for the high value handle. Starts dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onDragMax(event:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMaxSlide);
			
			if (_orientation == HORIZONTAL){
				//_maxHandle.startDrag(false, new Rectangle(_minHandle.x + _minHandle.width + minimumScale, 0, Math.round (_back.width - (_maxHandle.width + _minHandle.x + _minHandle.width+ minimumScale)) , 0));
				_maxHandle.startDrag(false, new Rectangle(_minHandle.x + _minHandle.width, 0, Math.round(_back.width - (_maxHandle.width + _minHandle.x + _minHandle.width)), 0));
			} else {
				_maxHandle.startDrag(false, new Rectangle(0, 0, 0, _minHandle.y - _back.width));
			}
			/*if(_labelMode == MOVE) {
				_lowLabel.visible = true;
				_highLabel.visible = true;
			}*/
		}

		private function onDragDragger(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onDraggerSlide);
			
			if (_orientation == HORIZONTAL){
				_dragger.startDrag(false, new Rectangle(_minHandle.width, 0, _back.width - (_maxHandle.width + _minHandle.width + _dragger.width), 0));
				//trace ("RangeSliderDD.as > _back.width  = "+_back.x)
			} else {
				_maxHandle.startDrag(false, new Rectangle(0, 0, 0, _minHandle.y - _back.width));
			}
		}

		
		/**
		 * Internal mouseUp handler. Stops dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onDrop(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMinSlide);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMaxSlide);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDraggerSlide);
			
			stopDrag();
		}
		
		/**
		 * Internal mouseMove handler for when the low value handle is being moved.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMinSlide(event:MouseEvent = null):void {
			var oldValue:Number = _lowValue;
			
			if (_orientation == HORIZONTAL) {
			
				
				_lowValue = ((_minHandle.x) / (_back.width - _maxHandle.width - _minHandle.width)) * _maximum;
				
				
				minRatio = _minHandle.x / range;
				_dragger.width = _maxHandle.x - (_minHandle.x + _minHandle.width)
				_dragger.x = _minHandle.x + _minHandle.width
				
				_highValue = ((_dragger.width) / (_back.width - (_minHandle.width + _maxHandle.width))) * _maximum
				maxRatio = (_maxHandle.x+_maxHandle.width) / range;
				
				
				
				var jj = ((_dragger.x - _minHandle.width) - 0) * (_max - _min)
				_value = Math.round(jj / ((_back.width - (_dragger.width + _maxHandle.width + _minHandle.width)) - 0) + _min)
				
				
			} else {
				_lowValue = (_height - _back.width - _minHandle.y) / (height - _back.width * 2) * (_maximum - _minimum) + _minimum;
			}
			
			if (_lowValue != oldValue){
			}
			
			dispatchEvent(new Event(RangeSliderDD.RANGE_UPDATE))
			dispatchEvent(new Event(Event.CHANGE))
			//dispatchEvent(new Event(Event.CHANGE));
			//dispatchEvent(new Event(Event.CHANGE));
			//updateLabels();
		}
		
		/**
		 * Internal mouseMove handler for when the high value handle is being moved.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMaxSlide(event:MouseEvent):void {
			var oldValue:Number = _highValue;
			if (_orientation == HORIZONTAL){
				// 	-  _highValue = _maxHandle.x / (_width - _maxHandle.width  ) * (_maximum - _minimum) + _minimum
				//  -  _highValue = (( _maxHandle.x - _minHandle.width  ) / (_back.width - (_maxHandle.width + _minHandle.width )))  * _maximum 				
				//_highValue = (( _maxHandle.x - _minHandle.width  ) / (_dragger.width - (_maxHandle.width + _minHandle.width )))  * _maximum 	
				
				_dragger.width = _maxHandle.x - (_minHandle.x + _minHandle.width)
				_highValue = ((_dragger.width) / (_back.width - (_minHandle.width + _maxHandle.width))) * _maximum
				maxRatio = (_maxHandle.x + _maxHandle.width) / range;
				
			} else {
				_highValue = (_height - _back.width * 2 - _maxHandle.y) / (_height - _back.width * 2) * (_maximum - _minimum) + _minimum;
				
			}
			if (_highValue != oldValue){
				
			}
			dispatchEvent(new Event(RangeSliderDD.RANGE_UPDATE))
			dispatchEvent(new Event(Event.CHANGE))
			//updateLabels();
		}

		
		private function onDraggerSlide(e:MouseEvent):void {
			//_highValue =  _maxHandle.x  / (_width - _maxHandle.width ) * (_maximum - _minimum) + _minimum
			//_lowValue = _minHandle.x / (_width - _maxHandle.width - _minHandle.width) * (_maximum - _minimum) + _minimum;
			if (highValue != maximum){
				_minHandle.x = _dragger.x - _minHandle.width
				_maxHandle.x = _dragger.x + _dragger.width
				
				var jj = ((_dragger.x - _minHandle.width) - 0) * (_max - _min)
				_value = Math.round(jj / ((_back.width - (_dragger.width + _maxHandle.width + _minHandle.width)) - 0) + _min)
				//trace("_value  = " + value)
			}
			//((_dragger.x - _minHandle.width) - 0 ) * ( _max - _min )   /  ( ( _back.width - (_dragger.width + _maxHandle.width+_minHandle.width) ) - 0) + _min )	
			//trace (" _value   = "+_value )
			
			minRatio = _minHandle.x / range;
			maxRatio = (_maxHandle.x+_maxHandle.width) / range;
			dispatchEvent(new Event(Event.CHANGE))
		}
		
		///////////////////////////////////////////////////////////////////////////////////////	
		
		/**
		 * Moves the component to the specified position.
		 * @param xpos the x position to move the component
		 * @param ypos the y position to move the component
		 */
		public function move(xpos:Number, ypos:Number):void {
			x = Math.round(xpos);
			y = Math.round(ypos);
		}
		
		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		public function setSize(w:Number, h:Number):void {
			_width = w;
			_height = h;
			//invalidate();
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Adjusts value to be within minimum and maximum.
		 */
		protected function correctValue():void {
			if (_max > _min){
				
				_value = Math.min(_value, _max);
				_value = Math.max(_value, _min);
				
			} else {
				
				_value = Math.max(_value, _max);
				_value = Math.min(_value, _min);
				
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////////////
		//////GETTERS AND SETTERS ////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Gets / sets the maximum value of this slider.
		 */
		public function set max(m:Number):void {
			_max = m;
			correctValue();
			positionDragger();
		}
		public function get max():Number {
			return _max;
		}
		
		/**
		 * Gets / sets the minimum value of this slider.
		 */
		public function set min(m:Number):void {
			_min = m;
			correctValue();
			positionDragger();
		}
		public function get min():Number {
			return _min;
		}
		
		/**
		 * Sets / gets the current value of this slider.
		 */
		public function set value(v:Number):void {
			_value = v;
			correctValue();
			//positionHandle();
			positionDragger()
		}
		public function get value():Number {
			//return Math.round(_value / _tick) * _tick;
			return (_value / _tick) * _tick;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////		
		
		/**
		 * Gets / sets the minimum value of the slider.
		 */
		public function set minimum(v:Number):void {
			_minimum = v;
			_maximum = Math.max(_maximum, _minimum);
			_lowValue = Math.max(_lowValue, _minimum);
			_highValue = Math.max(_highValue, _minimum);
			positionHandles();
		}
		public function get minimum():Number {
			return _minimum;
		}
		
		/**
		 * Gets / sets the maximum value of the slider.
		 */
		public function set maximum(v:Number):void {
			_maximum = v;
			_minimum = Math.min(_minimum, _maximum);
			_lowValue = Math.min(_lowValue, _maximum);
			_highValue = Math.min(_highValue, _maximum);
			positionHandles();
		}
		public function get maximum():Number {
			return _maximum;
		}
		
		/**
		 * Gets / sets the low value of this slider.
		 */
		public function set lowValue(v:Number):void {
			_lowValue = v;
			_lowValue = Math.min(_lowValue, _highValue);
			_lowValue = Math.max(_lowValue, _minimum);
			positionHandles();
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function get lowValue():Number {
			return Math.round(_lowValue / _tick) * _tick;
		}
		
		/**
		 * Gets / sets the high value for this slider.
		 */
		public function set highValue(v:Number):void {
			_highValue = v;
			_highValue = Math.max(_highValue, _lowValue);
			_highValue = Math.min(_highValue, _maximum);
			positionHandles();
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function get highValue():Number {
			return Math.round(_highValue / _tick) * _tick;
		}
		
		/**
		 * Sets / gets where the labels will appear. "left" or "right" for vertical sliders, "top" or "bottom" for horizontal.
		 */
		public function set labelPosition(v:String):void {
			_labelPosition = v;
			//updateLabels();
		}
		public function get labelPosition():String {
			return _labelPosition;
		}
		
		/**
		 * Sets / gets how many decimal points of precisions will be displayed on the labels.
		 */
		public function set labelPrecision(v:int):void {
			_labelPrecision = v;
			//updateLabels();
		}
		public function get labelPrecision():int {
			return _labelPrecision;
		}
		
		/**
		 * Gets / sets the tick value of this slider. This round the value to the nearest multiple of this number.
		 */
		public function set tick(v:Number):void {
			_tick = v
			//updateLabels();
		}
		public function get tick():Number {
			return _tick;
		}
		
		public function get minimumScale():int {
			return _minimumScale;
		}
		
		public function set minimumScale(value:int):void {
			_minimumScale = _width / value;
		}
		
		public function get rangeValue():Number {
			return _rangeValue;
		}
		
		public function set rangeValue(value:Number):void {
			_rangeValue = value;
		}
		
		/////////////////***************************************
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		/*
		public function draw():void {
			drawBack();
			drawHandles();
		}
		*/
		/**
		 * Draws the handles of the slider.
		 */
		/*
		protected function drawHandles():void {
			_minHandle.graphics.clear();
			_minHandle.graphics.beginFill(0x333333);
			_maxHandle.graphics.clear();
			_maxHandle.graphics.beginFill(0x333333);
			if (_orientation == HORIZONTAL){
				_minHandle.graphics.drawRect(1, 1, _height - 2, _height - 2);
				_maxHandle.graphics.drawRect(1, 1, _height - 2, _height - 2);
			} else {
				_minHandle.graphics.drawRect(1, 1, _width - 2, _width - 2);
				_maxHandle.graphics.drawRect(1, 1, _width - 2, _width - 2);
			}
			_minHandle.graphics.endFill();
			positionHandles();
		}
		*/

		/**
		 * Sets / gets when the labels will appear. Can be "never", "move", or "always"
		 */
		/*
		public function set labelMode(value:String):void {
			_labelMode = value;
			_highLabel.visible = (_labelMode == ALWAYS);
			_lowLabel.visible = (_labelMode == ALWAYS);
		}
		public function get labelMode():String {
			return _labelMode;
		}
		*/
		
		/**
		 * Generates a label string for the given value.
		 * @param value The number to create a label for.
		 */
		/*
		protected function getLabelForValue(value:Number):String {
			var str:String = (Math.round(value * Math.pow(10, _labelPrecision)) / Math.pow(10, _labelPrecision)).toString();
			if (_labelPrecision > 0){
				var decimal:String = str.split(".")[1] || "";
				if (decimal.length == 0)
					str += ".";
				for (var i:int = decimal.length; i < _labelPrecision; i++){
					str += "0";
				}
			}
			return str;
		}
		*/
		
		/**
		 * Sets the text and positions the labels.
		 */
		/*
		protected function updateLabels():void {
			if (_orientation == VERTICAL){
				_lowLabel.y = _minHandle.y + (_width - _lowLabel.height) * 0.5;
				_highLabel.y = _maxHandle.y + (_width - _highLabel.height) * 0.5;
				if (_labelPosition == LEFT){
					_lowLabel.x = -_lowLabel.width - 5;
					_highLabel.x = -_highLabel.width - 5;
				} else {
					_lowLabel.x = _width + 5;
					_highLabel.x = _width + 5;
				}
			} else {
				_lowLabel.x = _minHandle.x - _lowLabel.width + _height;
				_highLabel.x = _maxHandle.x;
				if (_labelPosition == BOTTOM){
					_lowLabel.y = _height + 2;
					_highLabel.y = _height + 2;
				} else {
					_lowLabel.y = -_lowLabel.height;
					_highLabel.y = -_highLabel.height;
				}
				
			}
		}
		*/
	}
}