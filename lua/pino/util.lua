local M = {}

M.oklch_to_hex = function(color)
    local l, c, h = color:match("([%d.]+)%% ([%d.]+) ([%d.]+)")
    l = tonumber(l) / 100
    c = tonumber(c)
    h = tonumber(h)

    local a = c * math.cos(math.rad(h))
    local b = c * math.sin(math.rad(h))

    local l_ = l + 0.3963377774 * a + 0.2158037573 * b
    local m_ = l - 0.1055613458 * a - 0.0638541728 * b
    local s_ = l - 0.0894841775 * a - 1.2914855480 * b

    local l3 = l_ * l_ * l_
    local m3 = m_ * m_ * m_
    local s3 = s_ * s_ * s_

    local r = 4.0767416621 * l3 - 3.3077115913 * m3 + 0.2309699292 * s3
    local g = -1.2684380046 * l3 + 2.6097574011 * m3 - 0.3413193965 * s3
    local b_rgb = -0.0041960863 * l3 - 0.7034186147 * m3 + 1.7076147010 * s3

    local function to_SRGB(v)
        if v <= 0.0031308 then
            return 12.92 * v
        else
            return 1.055 * math.pow(v, 1 / 2.4) - 0.055
        end
    end

    r = to_SRGB(r)
    g = to_SRGB(g)
    b_rgb = to_SRGB(b_rgb)

    local function clamp(v)
        return math.max(0, math.min(1, v))
    end

    r = clamp(r)
    g = clamp(g)
    b_rgb = clamp(b_rgb)

    local function to_hex(v)
        return string.format("%02x", math.floor(v * 255 + 0.5))
    end

    return "#" .. to_hex(r) .. to_hex(g) .. to_hex(b_rgb)
end

---@param colors table<string,string>
M.convert_colors = function(colors)
    local out = {}
    for k, v in pairs(colors) do
        out[k] = M.oklch_to_hex(v)
    end
    return out
end

---@param c string
local function rgb(c)
    c = string.lower(c)
    return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(foreground, alpha, background)
    alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
    local bg = rgb(background)
    local fg = rgb(foreground)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

---@param str string
---@param table table<string, string>[]
M.template = function(str, table)
    return str:gsub("($%b{})", function(w)
        local keys = vim.split(w:sub(3, -2), ".", { plain = true })
        local value = table
        for _, key in ipairs(keys) do
            if type(value) ~= "table" then
                return w
            end
            value = value[key]
        end
        return value or w
    end)
end

return M
