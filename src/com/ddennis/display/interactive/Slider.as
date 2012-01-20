package com.ddennis.display.interactive{
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	/**
	 * 	 * @author - ddennis.dk AKA meresukker.dk AKA fantatisk.dk 
	 *     Based on Keith Peters minimal comps - Slider
	 * 
	 */
	 
	 
	public class Slider extends Sprite {
		
		
		private var _orientation:String;
		public var _back:MovieClip
		private var _handle:MovieClip
		private var _backClick:Boolean = false;
		
		public var _width:Number	= 0
		public var _height:Number 	= 0

		public var _max:Number = 100;
		public var _min:Number = 0;
		public var _value:Number = 0;
		public var _tick:Number = 1;
		
		public static const CHANGE:String = "change"
		
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		private var _isMasked:Boolean;
		private var theMask:Sprite;
		private var _maskedContent:DisplayObjectContainer;
		private var _maskX:Number;
		private var _maskY:Number;
		private var _maskHeight:Number;
		private var _maskWidth:Number;
		
		
		
		public function Slider (orientation:String = Slider.HORIZONTAL, parent:DisplayObjectContainer = null , scrollBg:MovieClip = null, scrollhandle:MovieClip = null) {
						
			_orientation = orientation;
			//_isMasked = isMasked
			
			if (parent != null)	{
			//	parent.addChild (this);				
			}
			
			setStandardBackSize() 	
						
			_back = scrollBg			
			_handle = scrollhandle
								
			addChildren ()
			
			
			
		}
		
		
		
		
		public function addChildren ():void	{	
			
			
			
			if (!_handle) {					
				_handle = drawHandle ()						
			}
			
			
			if (!_back) {
				_back = drawBack ()						
			}
					
			setSize (_back.width, _back.height)
			
			
			
				
			addChild (_back);
			addChild (_handle);
			
			_back.x = 0
			_back.y = 0
			
			_handle.x = 0
			_handle.y = 0
				
			
			
			
			//this.width = _back.width
			//this.height = _back.height
			
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
			_handle.buttonMode = true;
			_handle.useHandCursor = true;
						
			
			positionHandle ();
		
			dispatchEvent(new Event(Event.CHANGE));	
			
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		/**
		 * Internal mouseDown handler. Starts dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		
		protected function onDrag(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			if (_orientation == HORIZONTAL)
			
			{
				_handle.startDrag(false, new Rectangle(0, 0, _back.width - _handle.width, 0));
			}
			else
			{
				_handle.startDrag(false, new Rectangle(0, 0, 0, _back.height -_handle.height ));
			}
		}
		
		
		
		
		
		/**
		 * Internal mouseUp handler. Stops dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onDrop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			stopDrag();
		}
		
		
		
		
		
		/**
		 * Internal mouseMove handler for when the handle is being moved.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onSlide(event:MouseEvent):void	{
			
			var oldValue:Number = _value;
			if(_orientation == HORIZONTAL)
			{
				//_value = _handle.x / (width - height) * (_max - _min) + _min;
				var jj =  Math.ceil ((_handle.x - 0 ) * ( _max - _min ) )
				_value = jj / ( ( _back.width - _handle.width  ) - 0) + _min 
			}
			else
			{
						
				
				var kk =  Math.ceil ((_handle.y - 0 ) * ( _max - _min ) )
				_value = kk / ( ( _handle.height - _back.height) - 0) + _min 
							
				//_value =  _handle.y - 0 )* ( _max - _min ) / _back.height  /			
				/// _back.height / (_max - _min)       // (_back.height - _handle.y  ) / _back.height  * (_max - _min) + _min 
				
				
			}
			if (_value != oldValue) {
					
				dispatchEvent (new Event (Event.CHANGE));
				
			}
		}
		
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Adjusts value to be within minimum and maximum.
		 */
		protected function correctValue():void
		{
			if (_max > _min) {
				
				_value = Math.min(_value, _max);
				_value = Math.max (_value, _min);
				
		}else {
			
				_value = Math.max(_value, _max);
				_value = Math.min (_value, _min);
				
			}
		}
				
		
		
		public function positionHandle():void	{
			var range:Number;
			if (_orientation == HORIZONTAL)	{
				
				range = width ;
				//_handle.x = (_value - _min) / (_max - _min) * range;
				_handle.x = (((_back.width - _handle.width) / (_max - _min) * _value )- _min) //+ _handle.width*.5
			
			}
			
			
			else {				
				
				range = height 
				_handle.y =  _back.height / (_max - _min)   * _value  //  - (_value - _min) / (_max - _min) * range;
				
			}
			
		}
		
			
		
		
		
		public function move(xpos:Number, ypos:Number):void	{
			this.x = Math.round(xpos);
			this.y = Math.round (ypos);			
		
		}
		
			
		
		
		public function setSize (w:Number, h:Number):void {
			
			_width = w;
			_height = h;
			
			
		}
			
		
		/**
		 * Convenience method to set the three main parameters in one shot.
		 * @param min The minimum value of the slider.
		 * @param max The maximum value of the slider.
		 * @param value The value of the slider.
		 */
		
		 
		public function setSliderParams(min:Number, max:Number, value:Number):void	{
			this.minimum = min;
			this.maximum = max;
			this.value = value;
		
		}
		
		
		public function updateContent (v):void {	
			_value = v
			 correctValue()
			positionHandle ()
			dispatchEvent (new Event (Event.CHANGE));	
			//setSliderAutoParams()
		}
		
		
		public function setSliderAutoParams ():void	{
			
			if (!_maskedContent) {
				trace (" ---------------------------" )
				trace ("Masken skal sættes først ")
				trace (" ---------------------------" )
				return
			}
			
			
			if (_orientation == VERTICAL) {			
		
					this.minimum = ((_maskedContent.height -y )-_back.height)					
					this.maximum = -this.y
					
					this.value = this.maximum
					
									
					if (this.maximum > 0) {								
						//_handle.visible = false						
					}			
					
			}else {
					
				this.minimum = -x
				this.maximum = ((_maskedContent.width -x )-_back.width)
				this.value = 0;
				_handle.visible = true
					
				if (this.maximum < 0) {					
					//_handle.visible = false					
				}
					
					
			}
						
		}
		
		
		function Clamp(low, val, high) {			
			return Math.min(Math.max(val, low), high);
			
		}
		
		
		
				
		public function setStandardBackSize( ):void {
			
			if (_orientation == HORIZONTAL) {				
				setSize(300, 10);			}
			else{
				setSize (6, 113);
			}			
			
		}
		
		
		
		
		public function createMask (maskWidth:Number = 0 ,  maskHeight:Number = 0, maskX:Number = 0 , maskY:Number = 0):void {
			
			if (!theMask) {											
				theMask = new Sprite ()
			}
			
			theMask.alpha = .5
			_maskX = maskX
			_maskY = maskY
			
			_maskWidth 	= maskWidth
			_maskHeight = maskHeight
			
			drawMask ( maskWidth , maskHeight , _maskX , _maskY)
			addChild (theMask)
			
		}
		
		
		
		public function placeMask (parent:DisplayObjectContainer, maskedContent:DisplayObjectContainer):void {
									
			if (!_maskWidth) {
				_maskWidth = maskedContent.width
			}
			if (!_maskHeight) {
				_maskHeight = maskedContent.height
			}
				
			_maskedContent = maskedContent
						
		
			theMask.alpha = .5
			maskedContent.mask = theMask
			parent.addChild (theMask)
		
		
							
		}
		
		
		
		
		public function drawMask (w , h , mx , my):void {
			
			theMask.graphics.clear();
			theMask.graphics.beginFill(0x00FF00);			
			theMask.graphics.drawRect(mx, my, w , h );					
			theMask.graphics.endFill ();
			
		}
		
		
		
		
		
		public function setMouseWheelActive():void {
			_maskedContent.addEventListener (MouseEvent.MOUSE_OVER , activateWheel)			
			_maskedContent.addEventListener(MouseEvent.MOUSE_OUT , deActivateWheel)
		}
		
		
		function deActivateWheel (e:MouseEvent):void {
			//trace ("ll")
			e.currentTarget.removeEventListener (MouseEvent.MOUSE_WHEEL, listenToWheel)
			
			//trace ("Slider.as > e.currentTarget  = "+e.currentTarget.name)
		}
		
		
		
		private function activateWheel (e:MouseEvent):void {
			
			e.currentTarget.addEventListener(MouseEvent.MOUSE_WHEEL, listenToWheel)
		}
		
		
		
		private function listenToWheel(e:MouseEvent):void {
			
			//var moveFactor = 40
			
			if (this.visible == false) {
				return
			}
			
			var d = e.delta
			var moveFactor = 5			
			moveHandle (d*10 * -1)
				
			
			/*
			if (d < 0) {
				
				value = value - moveFactor
				
			}else {
				
				value = value + moveFactor
			
			}
			//onSlide(null)
			dispatchEvent (new Event (Event.CHANGE));	
			*/
		}
		
		
		
		
		public function moveHandle(v:Number):void {
			
			if (_orientation == Slider.HORIZONTAL) {		
				
					//_handle.y = Clamp(handleMinimum , (_handle.y + (v)), _back.height -_handle.height )			
				
								
			}else {				
					
					_handle.y = Clamp(0 , (_handle.y + (v)), _back.height -_handle.height )				
			}
						
			onSlide (null)				
			dispatchEvent (new Event (Event.CHANGE));	
			
		}
		
	
		
		
		
		///////////////////////////////////////////////////////////////////////////////////////////
		// Tegn Content
		///////////////////////////////////////////////////////////////////////////////////////////
		
			
			public function drawBack ():MovieClip {			
				//trace ("Slider.as > drawBack  = "+drawBack)
				var b = new MovieClip ();
				b.graphics.clear();
				b.graphics.beginFill(0x666666);
				b.graphics.drawRect(0, 0, _width, _height);
				b.graphics.endFill ();		
				return b
				
			}
			
			
			
				
			public function drawHandle():MovieClip {
				var h = new MovieClip ()
				h.graphics.clear();
				h.graphics.beginFill(0x000000);
				
				if(_orientation == HORIZONTAL)
				{
					h.graphics.drawRect(0, 0, _height , _height );
				}
				else {
					
					h.graphics.drawRect(0, 0, _width , _width );
				}
				h.graphics.endFill();			
				return h
				
			}
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets whether or not a click on the background of the slider will move the handler to that position.
		 */
		public function set backClick(b:Boolean):void		{
			_backClick = b;
			//invalidate();
		}
		
		public function get backClick():Boolean		{
			return _backClick;
		}
		
		/**
		 * Sets / gets the current value of this slider.
		 */
		public function set value(v:Number):void		{
		
			_value = v;
			correctValue();
			positionHandle();
		}
		
		public function get value():Number		{
			//return Math.round(_value / _tick) * _tick;
			return (_value / _tick) * _tick;
		}
		
		/**
		 * Gets / sets the maximum value of this slider.
		 */
		
		public function set maximum(m:Number):void		{
			_max = m;
			correctValue();
			positionHandle();
		}
		
		public function get maximum():Number{
			return _max;
		}
		
		/**
		 * Gets / sets the minimum value of this slider.
		 */
		public function set minimum (m:Number):void	{
			
			_min = m;
			correctValue();
			positionHandle();
		}
		
		
		public function get minimum ():Number {
			
			return _min;
		}
		
		/**
		 * Gets / sets the tick value of this slider. This round the value to the nearest multiple of this number. 
		 */
		
		public function set tick (t:Number):void	{
			
			_tick = t;
		}
		
		public function get tick ():Number	{
			return _tick;
		}
			
			
		
		
		
		
	}

}











