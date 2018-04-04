package  {
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class External {
		
		/*private var returnCollide:Boolean;
		
		private var objPointP:Point;
		private var objPointO:Point;
		
		private var objRectP:Rectangle;
		private var objRectO:Rectangle;
		
		private var objBmpP:BitmapData;
		private var objBmpO:BitmapData;
		
		private var objOffsetP:Matrix;
		private var objOffsetO:Matrix;*/

		public function randNum (minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		//public function collide(objP:DisplayObjectContainer, objO:DisplayObjectContainer):Boolean {
		//	returnCollide = false;
		//	
		//	//trace (obj);
		//	
		//	objRectP = objO.getBounds(objO);
		//	objOffsetP = objP.transform.matrix;
		//	objOffsetP.tx = objP.x - objO.x;
		//	objOffsetP.ty = objP.y - objO.y;
		//	
		//	objRectO = objP.getBounds(objP);
		//	objOffsetO = objO.transform.matrix;
		//	objOffsetO.tx = objO.x - objO.x;
		//	objOffsetO.ty = objO.y - objO.y;
		//	
		//	objBmpP = new BitmapData(objRectP.width, objRectP.height, true, 0);
		//	objBmpP.draw(objO, objOffsetO);
		//	
		//	objBmpO = new BitmapData(objRectO.width, objRectO.height, true, 0);
		//	objBmpO.draw(objP, objOffsetP);
		//	
		//	objPointP = new Point(objRectP.x, objRectP.y);
		//	objPointO = new Point(objRectO.x, objRectO.y);
		//	
		//	if (objBmpP.hitTest(objPointP, 255, objBmpO, objPointO, 255)) {
		//		returnCollide = true;
		//		trace ("hi");
		//	}
		//	
		//	objBmpP.dispose();
		//	objBmpO.dispose();
		//	
		//	return returnCollide;
		//}

	}
	
}
