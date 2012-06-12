////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 Julius Loa | jloa@chargedweb.com
//  All Rights Reserved.
//  license:	MIT {http://www.opensource.org/licenses/mit-license.php}
//  notice: 	just keep the header plz
////////////////////////////////////////////////////////////////////////////////

package com.ddennis.utils
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * <p>AlignUtil class - vertical/horizontal align DisplayObjects</p>
	 * @author			Julius Loa aka jloa, jloa@chargedweb.com
	 * @availability 	flash/flex, as3
	 * @version 		1.0
	 *
	 * <p>Class usage:</p>
	 * @example Flex sample:
	 * <listing version="3.0">
	 * import com.chargedweb.utils.AlignUtil;
	 *
	 * var btn:Button = new Button();
	 * btn.x = 100;
	 * btn.y = 100;
	 * btn.width = 100;
	 * btn.height = 30;
	 * btn.rotation = 30;
	 * addChild(btn);
	 * 
	 * AlignUtil.setAlign(AlignUtil.H_CENTER, btn, this);
	 * AlignUtil.setAlign(AlignUtil.V_MIDDLE, btn, this);
	 * </listing>
	 */
	public class AlignUtil
	{
		/** Horizontal left alignment **/
		public static const H_LEFT:String = "horizontalLeft";
		/** Horizontal center alignment **/
		public static const H_CENTER:String = "horizontalCenter";
		/** Horizontal right alignment **/
		public static const H_RIGHT:String = "horizontalRight";
		
		/** Vertical top alignment **/
		public static const V_TOP:String = "verticalTop";
		/** Vertical middle alignment **/
		public static const V_MIDDLE:String = "verticalMiddle";
		/** Vertical bottom alignment **/
		public static const V_BOTTOM:String = "verticalBottom";
		
		/**
		 * Applies a specified alignment to the target DisplayObject
		 * @param	align:String			alignment mode (see the public constants defined above)
		 * @param	target:DisplayObject	target DisplayObject to align (according to the set alignment mode) @see flash.display.DisplayObject
		 * @param	parent:DisplayObject	the parent DisplayObject of the target one @see flash.display.DisplayObject
		 * @return	nothing
		 */
		public static function setAlign(align:String, target:DisplayObject, parent:DisplayObject):void
		{
			var a:String = align; var t:DisplayObject = target; var p:DisplayObject = parent;
			var b:Rectangle = t.transform.pixelBounds;
			var bp:Point = p.globalToLocal(new Point(b.x, b.y));
			b.x = bp.x; b.y = bp.y;
			if(a == H_LEFT) t.x = (t.x > b.x) ? t.x - b.x : 0;
			if(a == H_CENTER) t.x = int((p.width - b.width)/2 + t.x - b.x);
			if(a == H_RIGHT) t.x = (t.x > b.x + b.width) ? p.width : p.width - (b.x + b.width - t.x);
			if(a == V_TOP) t.y = (t.y > b.y) ? t.y - b.y : 0;
			if(a == V_MIDDLE) t.y = int((p.height - b.height)/2 + t.y - b.y);
			if(a == V_BOTTOM) t.y = (t.y > b.y + b.height) ? p.height : p.height - (b.y + b.height - t.y);
		}
	}
}