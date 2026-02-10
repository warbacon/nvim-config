local M = {}

M.oklchToHex = function(color)
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

    local function toSRGB(v)
        if v <= 0.0031308 then
            return 12.92 * v
        else
            return 1.055 * math.pow(v, 1 / 2.4) - 0.055
        end
    end

    r = toSRGB(r)
    g = toSRGB(g)
    b_rgb = toSRGB(b_rgb)

    local function clamp(v)
        return math.max(0, math.min(1, v))
    end

    r = clamp(r)
    g = clamp(g)
    b_rgb = clamp(b_rgb)

    local function toHex(v)
        return string.format("%02x", math.floor(v * 255 + 0.5))
    end

    return "#" .. toHex(r) .. toHex(g) .. toHex(b_rgb)
end

M.convertColors = function(colors)
    local function convert(value)
        if type(value) == "table" then
            local out = {}
            for k, v in pairs(value) do
                out[k] = convert(v)
            end
            return out
        end

        if type(value) == "string" then
            return M.oklchToHex(value)
        end

        return value
    end

    return convert(colors)
end

return M
