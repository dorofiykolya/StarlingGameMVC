package starling.filters
{
    import flash.display3D.Context3DProgramType;
    import flash.display3D.Program3D;
    import starling.textures.Texture;
    import flash.display3D.Context3D;
	import starling.filters.FragmentFilter;
	
	/**
     * ...
     * @author dorofiy.com
     */
    public class ShadowFilter extends FragmentFilter 
    {
        private var mShaderProgram:Program3D;
        
        public function ShadowFilter() 
        {
            //super(1, .25);
        }
        
        override public function dispose():void 
        {
            if (mShaderProgram)
            {
                mShaderProgram.dispose();
            }
            super.dispose();
        }
        
        override protected function createPrograms():void 
        {
            var fragmentProgramCode:String =
                "tex ft0, v0, fs0 <2d, clamp, linear, mipnone>  \n" + // read texture color
                "min oc, ft0, fc0 \n";  // min
            
            mShaderProgram = assembleAgal(fragmentProgramCode);
        }
        
        override protected function activate(pass:int, context:Context3D, texture:Texture):void 
        {
            context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, new <Number>[0, 0, 0, .5], 1);
            context.setProgram(mShaderProgram);
        }
    }

}