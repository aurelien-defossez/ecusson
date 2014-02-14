--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:8f5ea19a55f10894954fbc8c5ce8a6d4:d8b5538e419b87797318bc45dcf29b3a:f5c322b4188998d6cd973301e8657e5f$
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
            x=1296,
            y=1488,
            width=216,
            height=232,

        },
        {
            -- dog_dead_02
            x=1296,
            y=1240,
            width=216,
            height=232,

        },
        {
            -- dog_dead_03
            x=1296,
            y=992,
            width=216,
            height=232,

        },
        {
            -- dog_dead_04
            x=1296,
            y=744,
            width=216,
            height=232,

        },
        {
            -- dog_dead_05
            x=1296,
            y=496,
            width=216,
            height=232,

        },
        {
            -- dog_idle_01
            x=1296,
            y=248,
            width=216,
            height=232,

        },
        {
            -- dog_idle_02
            x=1296,
            y=0,
            width=216,
            height=232,

        },
        {
            -- level_background
            x=0,
            y=816,
            width=1280,
            height=800,

        },
        {
            -- level_foreground
            x=0,
            y=0,
            width=1280,
            height=800,

        },
    },
    
    sheetContentWidth = 1512,
    sheetContentHeight = 1720
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
