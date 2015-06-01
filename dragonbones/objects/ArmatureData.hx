package dragonbones.objects;
import dragonbones.objects.BoneData;
import dragonbones.objects.IAreaData;
import dragonbones.objects.SkinData;
import openfl.errors.ArgumentError;

@:final class ArmatureData
{
    public var boneDataList(get, never):Array<BoneData>;
    public var skinDataList(get, never):Array<SkinData>;
    public var animationDataList(get, never):Array<AnimationData>;
    public var areaDataList(get, never):Array<IAreaData>;

    public var name:String;
    
    var _boneDataList:Array<BoneData>;
    function get_BoneDataList():Array<BoneData>
    {
        return _boneDataList;
    }
    
    var _skinDataList:Array<SkinData>;
    function get_SkinDataList():Array<SkinData>
    {
        return _skinDataList;
    }
    
    var _animationDataList:Array<AnimationData>;
    function get_AnimationDataList():Array<AnimationData>
    {
        return _animationDataList;
    }
    
    var _areaDataList:Array<IAreaData>;
    function get_AreaDataList():Array<IAreaData>
    {
        return _areaDataList;
    }
    
    public function new()
    {
        _boneDataList = new Array<BoneData>();
        _skinDataList = new Array<SkinData>();
        _animationDataList = new Array<AnimationData>();
        
        _areaDataList = new Array<IAreaData>();
    }
    
    public function dispose():Void
    {
        var i:Int = _boneDataList.length;
        while (i-->0)
        {
            _boneDataList[i].dispose();
        }
        i = _skinDataList.length;
        while (i-->0)
        {
            _skinDataList[i].dispose();
        }
        i = _animationDataList.length;
        while (i-->0)
        {
            _animationDataList[i].dispose();
        }
        
        _boneDataList.fixed = false;
        _boneDataList.length = 0;
        _skinDataList.fixed = false;
        _skinDataList.length = 0;
        _animationDataList.fixed = false;
        _animationDataList.length = 0;
        //_animationsCached。clear();
        _boneDataList = null;
        _skinDataList = null;
        _animationDataList = null;
    }
    
    public function getBoneData(boneName:String):BoneData
    {
        var i:Int = _boneDataList.length;
        while (i-->0)
        {
            if (_boneDataList[i].name == boneName) 
            {
                return _boneDataList[i];
            }
        }
        return null;
    }
    
    public function getSkinData(skinName:String):SkinData
    {
        if (skinName == null && _skinDataList.length > 0) 
        {
            return _skinDataList[0];
        }
        var i:Int = _skinDataList.length;
        while (i-->0)
        {
            if (_skinDataList[i].name == skinName) 
            {
                return _skinDataList[i];
            }
        }
        
        return null;
    }
    
    public function getAnimationData(animationName:String):AnimationData
    {
        var i:Int = _animationDataList.length;
        while (i-->0)
        {
            if (_animationDataList[i].name == animationName) 
            {
                return _animationDataList[i];
            }
        }
        return null;
    }
    
    public function addBoneData(boneData:BoneData):Void
    {
        if (boneData == null) 
        {
            throw new ArgumentError();
        }
        
        if (Lambda.indexOf(_boneDataList, boneData) < 0) 
        {
            _boneDataList.fixed = false;
            _boneDataList[_boneDataList.length] = boneData;
            _boneDataList.fixed = true;
        }
        else 
        {
            throw new ArgumentError();
        }
    }
    
    public function addSkinData(skinData:SkinData):Void
    {
        if (skinData == null) 
        {
            throw new ArgumentError();
        }
        
        if (Lambda.indexOf(_skinDataList, skinData) < 0) 
        {
            _skinDataList.fixed = false;
            _skinDataList[_skinDataList.length] = skinData;
            _skinDataList.fixed = true;
        }
        else 
        {
            throw new ArgumentError();
        }
    }
    
    public function addAnimationData(animationData:AnimationData):Void
    {
        if (animationData == null) 
        {
            throw new ArgumentError();
        }
        
        if (Lambda.indexOf(_animationDataList, animationData) < 0) 
        {
            _animationDataList.fixed = false;
            _animationDataList[_animationDataList.length] = animationData;
            _animationDataList.fixed = true;
        }
    }
    
    public function sortBoneDataList():Void
    {
        var i:Int = _boneDataList.length;
        if (i == 0) 
        {
            return;
        }
        
        var helpArray:Array<Dynamic> = [];
        while (i-->0)
        {
            var boneData:BoneData = _boneDataList[i];
            var level:Int = 0;
            var parentData:BoneData = boneData;
            while (parentData)
            {
                level++;
                parentData = getBoneData(parentData.parent);
            }
            helpArray[i] = [level, boneData];
        }
        
        helpArray.sortOn("0", Array.NUMERIC);
        
        i = helpArray.length;
        while (i-->0)
        {
            _boneDataList[i] = helpArray[i][1];
        }
    }
    
    public function getAreaData(areaName:String):IAreaData
    {
        if (areaName == null && _areaDataList.length > 0) 
        {
            return _areaDataList[0];
        }
        var i:Int = _areaDataList.length;
        while (i-->0)
        {
            if (_areaDataList[i]["name"] == areaName) 
            {
                return _areaDataList[i];
            }
        }
        return null;
    }
    
    public function addAreaData(areaData:IAreaData):Void
    {
        if (areaData == null) 
        {
            throw new ArgumentError();
        }
        
        if (Lambda.indexOf(_areaDataList, areaData) < 0) 
        {
            _areaDataList.fixed = false;
            _areaDataList[_areaDataList.length] = areaData;
            _areaDataList.fixed = true;
        }
    }
}
