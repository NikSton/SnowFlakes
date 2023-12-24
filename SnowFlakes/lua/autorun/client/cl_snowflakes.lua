// Micro-Optimizate Code //
local SnowMaterial = Material("particle/snow")
local white = Color(255, 255, 255, 255)
local draw_color =  surface.SetDrawColor
local draw_material = surface.SetMaterial
local draw_texrect = surface.DrawTexturedRect

// Function falling snowflakes //
function FalSnowFlakes(panel)
    if !IsValid(panel) then
        return
    end

    local oldThink = panel.Think
    local panel_h = 0, 0
    panel.Think = function(self)
        if self.SnowFlakes then
            for k,v in pairs(self.SnowFlakes) do
                if v.y > panel_h then
                    v.y = -4
                    v.x = self.Drops[k]
                else
                    v.y = v.y + FrameTime() * 40 * v.seed
                    v.x = v.x + math.sin(CurTime() * v.seed)
                end
            end
        end

        if oldThink then
            oldThink(self)
        end
    end

    panel:Think()

    local oldPaint = panel.PaintOver

    panel.PaintOver = function(self, w, h)
        if oldPaint then
            oldPaint(self, w, h)
        end   

        if not self.Drops then
            self.Drops = {}
            self.SnowFlakes = {}
            for i = 1, w do
            if math.random() < 0.02 then
                    table.insert(self.Drops, i)
                    table.insert(self.SnowFlakes, {x=i,y=math.random(0,h),seed = (math.random() + 1) * 2})
                end
            end
        end

        panel_h = h
        
        draw_color(white)
        draw_material(SnowMaterial)
        for k,v in pairs(self.SnowFlakes) do
            draw_texrect(v.x - 4, v.y - 4, 8, 8)
        end
    end
end