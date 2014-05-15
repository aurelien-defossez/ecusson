--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:30f00e25fc5eeba089ce67623db20b9d:d8b5538e419b87797318bc45dcf29b3a:16905a3207bcd6e6261566d9ecdaf4c0$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- dog_dead_01
            x=324,
            y=372,
            width=54,
            height=58,

        },
        {
            -- dog_dead_02
            x=324,
            y=310,
            width=54,
            height=58,

        },
        {
            -- dog_dead_03
            x=324,
            y=248,
            width=54,
            height=58,

        },
        {
            -- dog_dead_04
            x=324,
            y=186,
            width=54,
            height=58,

        },
        {
            -- dog_dead_05
            x=324,
            y=124,
            width=54,
            height=58,

        },
        {
            -- dog_idle_01
            x=324,
            y=62,
            width=54,
            height=58,

        },
        {
            -- dog_idle_02
            x=324,
            y=0,
            width=54,
            height=58,

        },
        {
            -- level_background
            x=0,
            y=204,
            width=320,
            height=200,

        },
        {
            -- level_foreground
            x=0,
            y=0,
            width=320,
            height=200,

        },
    },
    
    sheetContentWidth = 378,
    sheetContentHeight = 430
}

SheetInfo.frameIndex =
{

    ["dog_dead_01"] = 1,
    ["dog_dead_02"] = 2,
    ["dog_dead_03"] = 3,
    ["dog_dead_04"] = 4,
    ["dog_dead_05"] = 5,
    ["dog_idle_01"] = 6,
    ["dog_idle_02"] = 7,
    ["level_background"] = 8,
    ["level_foreground"] = 9,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
