package
{
	import com.zs.views.View;
	
	import flash.display.Sprite;
	
	import org.aswing.AsWingManager;
	import org.aswing.air.JNativeFrame;
	
	[SWF(width=500,height=700)]
	public class JSONView extends JNativeFrame
	{
		public function JSONView()
		{
			AsWingManager.initAsStandard(this);
			
			super(this.stage.nativeWindow,'JSON查看器');
			
			this.getContentPane().append(new View());
		}
	}
}