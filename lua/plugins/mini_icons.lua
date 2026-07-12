return {
    {
        "echasnovski/mini.icons",
        opts = {},
        config = function()
            require("mini.icons").setup()
            require("mini.icons").mock_nvim_web_devicons()

            local function rgb_to_hsl(r, g, b)
                r, g, b = r / 255, g / 255, b / 255
                local max, min = math.max(r, g, b), math.min(r, g, b)
                local h, s, l = 0, 0, (max + min) / 2
                if max ~= min then
                    local d = max - min
                    s = l > 0.5 and d / (2 - max - min) or d / (max + min)
                    if max == r then h = (g - b) / d + (g < b and 6 or 0)
                    elseif max == g then h = (b - r) / d + 2
                    else h = (r - g) / d + 4 end
                    h = h / 6
                end
                return h, s, l
            end

            local function hsl_to_rgb(h, s, l)
                if s == 0 then
                    local v = math.floor(l * 255)
                    return v, v, v
                end
                local function hue2rgb(p, q, t)
                    if t < 0 then t = t + 1 end
                    if t > 1 then t = t - 1 end
                    if t < 1/6 then return p + (q - p) * 6 * t end
                    if t < 1/2 then return q end
                    if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
                    return p
                end
                local q = l < 0.5 and l * (1 + s) or l + s - l * s
                local p = 2 * l - q
                return math.floor(hue2rgb(p, q, h + 1/3) * 255),
                       math.floor(hue2rgb(p, q, h) * 255),
                       math.floor(hue2rgb(p, q, h - 1/3) * 255)
            end

            -- sat: 0=сірий, 1=оригінал | bright: 0=чорний, 1=оригінал
            local function adjust_mini_icons(sat, bright)
                local groups = {
                    "MiniIconsAzure", "MiniIconsBlue", "MiniIconsCyan",
                    "MiniIconsGreen", "MiniIconsGrey", "MiniIconsOrange",
                    "MiniIconsPurple", "MiniIconsRed", "MiniIconsYellow", "MiniIconsWhite",
                }
                for _, name in ipairs(groups) do
                    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
                    if hl.fg then
                        local hex = string.format("%06x", hl.fg)
                        local r = tonumber(hex:sub(1, 2), 16)
                        local g = tonumber(hex:sub(3, 4), 16)
                        local b = tonumber(hex:sub(5, 6), 16)
                        local h, s, l = rgb_to_hsl(r, g, b)
                        s = s * sat
                        l = l * bright
                        local nr, ng, nb = hsl_to_rgb(h, s, l)
                        hl.fg = nr * 65536 + ng * 256 + nb
                        vim.api.nvim_set_hl(0, name, hl)
                    end
                end
            end

            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function() adjust_mini_icons(1.5, 0.85) end,
            })
            adjust_mini_icons(1.5, 0.85)
        end,
    }
}
