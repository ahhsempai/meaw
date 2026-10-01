local LibraryUrl = "https://raw.githubusercontent.com/ahhsempai/meaw/refs/heads/main/Libraryy.lua"

local Module = {}

local function LoadLibrary()
    local source = game:HttpGet(LibraryUrl)

    if type(source) ~= "string" or source == "" then
        error("Libraryy.lua returned an empty response")
    end

    source = source:gsub(
        "local InterfaceBuild%s*=%s*['\"]3K3W['\"]",
        "local InterfaceBuild = 'UU2NX'",
        1
    )

    local env = getgenv and getgenv()
    local previousRequestSetting

    if env then
        previousRequestSetting = env.DISABLE_RAYFIELD_REQUESTS
        env.DISABLE_RAYFIELD_REQUESTS = true
    end

    local ok, result = pcall(function()
        local chunk, compileError = loadstring(source)
        if not chunk then
            error(compileError or "Unable to compile Libraryy.lua")
        end
        return chunk()
    end)

    if env then
        env.DISABLE_RAYFIELD_REQUESTS = previousRequestSetting
    end

    if not ok then
        error(result)
    end

    if type(result) ~= "table" or type(result.CreateWindow) ~= "function" then
        error("Libraryy.lua returned an invalid Rayfield library")
    end

    return result
end

function Module:GetWorkingRayfield()
    local Rayfield = LoadLibrary()

    local originalCreateWindow = Rayfield.CreateWindow

    if type(originalCreateWindow) == "function" then
        Rayfield.CreateWindow = function(self, ...)
            local Window = originalCreateWindow(self, ...)

            if type(Window) == "table" and type(Window.CreateTabSection) ~= "function" then
                function Window:CreateTabSection(_Name)
                    return self
                end
            end

            return Window
        end
    end

    return Rayfield
end

return Module

