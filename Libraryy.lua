local function getService(n)local s=game:GetService(n)return cloneref and cloneref(s)or s end
local function loadWithTimeout(url,timeout)
local done,ok,res=false
local th=task.spawn(function()
local a,b=pcall(game.HttpGet,game,url)
if a and #b>0 then ok,res=pcall(function()return loadstring(b)()end)else ok,res=false,b end
done=true
end)
local td=task.delay(timeout or 5,function()if not done then task.cancel(th)done=true end end)
repeat task.wait()until done
pcall(task.cancel,td)
return ok and res or nil
end
local InterfaceBuild,Release="3K3W","Build 1.68"
local RayfieldFolder="Rayfield"
local ConfigurationFolder=RayfieldFolder.."/Configurations"
local ConfigurationExtension=".rfld"
local ToggleKey="K"
local HttpService,RunService,TextService=getService("HttpService"),getService("RunService"),getService("TextService")
local UserInputService,TweenService,Players,CoreGui=getService("UserInputService"),getService("TweenService"),getService("Players"),getService("CoreGui")
local requestsOK=true
local EXP,TI=Enum.EasingStyle.Exponential,TweenInfo.new
local function tw(o,t,p,s,d)TweenService:Create(o,TI(t,s or EXP,d or Enum.EasingDirection.Out),p):Play()end

-- Themes
local K={"TextColor","Background","Topbar","Shadow","NotificationBackground","NotificationActionsBackground","TabBackground","TabStroke","TabBackgroundSelected","TabTextColor","SelectedTabTextColor","ElementBackground","ElementBackgroundHover","SecondaryElementBackground","ElementStroke","SecondaryElementStroke","SliderBackground","SliderProgress","SliderStroke","ToggleBackground","ToggleEnabled","ToggleDisabled","ToggleEnabledStroke","ToggleDisabledStroke","ToggleEnabledOuterStroke","ToggleDisabledOuterStroke","DropdownSelected","DropdownUnselected","InputBackground","InputStroke","PlaceholderColor"}
local D={
Default={{240,240,240},{25,25,25},{34,34,34},{20,20,20},{20,20,20},{230,230,230},{80,80,80},{85,85,85},{210,210,210},{240,240,240},{50,50,50},{35,35,35},{40,40,40},{25,25,25},{50,50,50},{40,40,40},{50,138,220},{50,138,220},{58,163,255},{30,30,30},{0,146,214},{100,100,100},{0,170,255},{125,125,125},{100,100,100},{65,65,65},{40,40,40},{30,30,30},{30,30,30},{65,65,65},{178,178,178}},
Ocean={{230,240,240},{20,30,30},{25,40,40},{15,20,20},{25,35,35},{230,240,240},{40,60,60},{50,70,70},{100,180,180},{210,230,230},{20,50,50},{30,50,50},{40,60,60},{30,45,45},{45,70,70},{40,65,65},{0,110,110},{0,140,140},{0,160,160},{30,50,50},{0,130,130},{70,90,90},{0,160,160},{85,105,105},{50,100,100},{45,65,65},{30,60,60},{25,40,40},{30,50,50},{50,70,70},{140,160,160}},
AmberGlow={{255,245,230},{45,30,20},{55,40,25},{35,25,15},{50,35,25},{245,230,215},{75,50,35},{90,60,45},{230,180,100},{250,220,200},{50,30,10},{60,45,35},{70,50,40},{55,40,30},{85,60,45},{75,50,35},{220,130,60},{250,150,75},{255,170,85},{55,40,30},{240,130,30},{90,70,60},{255,160,50},{110,85,75},{200,100,50},{75,60,55},{70,50,40},{55,40,30},{60,45,35},{90,65,50},{190,150,130}},
Light={{40,40,40},{245,245,245},{230,230,230},{200,200,200},{250,250,250},{240,240,240},{235,235,235},{215,215,215},{255,255,255},{80,80,80},{0,0,0},{240,240,240},{225,225,225},{235,235,235},{210,210,210},{210,210,210},{150,180,220},{100,150,200},{120,170,220},{220,220,220},{0,146,214},{150,150,150},{0,170,255},{170,170,170},{100,100,100},{180,180,180},{230,230,230},{220,220,220},{240,240,240},{180,180,180},{140,140,140}},
Amethyst={{240,240,240},{30,20,40},{40,25,50},{20,15,30},{35,20,40},{240,240,250},{60,40,80},{70,45,90},{180,140,200},{230,230,240},{50,20,50},{45,30,60},{50,35,70},{40,30,55},{70,50,85},{65,45,80},{100,60,150},{130,80,180},{150,100,200},{45,30,55},{120,60,150},{94,47,117},{140,80,170},{124,71,150},{90,40,120},{80,50,110},{50,35,70},{35,25,50},{45,30,60},{80,50,110},{178,150,200}},
Green={{30,60,30},{235,245,235},{210,230,210},{200,220,200},{240,250,240},{220,235,220},{215,235,215},{190,210,190},{245,255,245},{50,80,50},{20,60,20},{225,240,225},{210,225,210},{235,245,235},{180,200,180},{180,200,180},{90,160,90},{70,130,70},{100,180,100},{215,235,215},{60,130,60},{150,175,150},{80,150,80},{130,150,130},{100,160,100},{160,180,160},{225,240,225},{210,225,210},{235,245,235},{180,200,180},{120,140,120}},
Bloom={{60,40,50},{255,240,245},{250,220,225},{230,190,195},{255,235,240},{245,215,225},{240,210,220},{230,200,210},{255,225,235},{80,40,60},{50,30,50},{255,235,240},{245,220,230},{255,235,240},{230,200,210},{230,200,210},{240,130,160},{250,160,180},{255,180,200},{240,210,220},{255,140,170},{200,180,185},{250,160,190},{210,180,190},{220,160,180},{190,170,180},{250,220,225},{240,210,220},{255,235,240},{220,190,200},{170,130,140}},
DarkBlue={{230,230,230},{20,25,30},{30,35,40},{15,20,25},{25,30,35},{45,50,55},{35,40,45},{45,50,60},{40,70,100},{200,200,200},{255,255,255},{30,35,40},{40,45,50},{35,40,45},{45,50,60},{40,45,55},{0,90,180},{0,120,210},{0,150,240},{35,40,45},{0,120,210},{70,70,80},{0,150,240},{75,75,85},{20,100,180},{55,55,65},{30,70,90},{25,30,35},{25,30,35},{45,50,60},{150,150,160}},
Serenity={{50,55,60},{240,245,250},{215,225,235},{200,210,220},{210,220,230},{225,230,240},{200,210,220},{180,190,200},{175,185,200},{50,55,60},{30,35,40},{210,220,230},{220,230,240},{200,210,220},{190,200,210},{180,190,200},{200,220,235},{70,130,180},{150,180,220},{210,220,230},{70,160,210},{180,180,180},{60,150,200},{140,140,140},{100,120,140},{120,120,130},{220,230,240},{200,210,220},{220,230,240},{180,190,200},{150,150,150}}}
local Themes={}
for n,v in pairs(D)do local t={}for i,k in ipairs(K)do local c=v[i]t[k]=Color3.fromRGB(c[1],c[2],c[3])end Themes[n]=t end
local RayfieldLibrary={Flags={},Theme=Themes}
local SelectedTheme=Themes.Default

-- Interface
local Rayfield=game:GetObjects("rbxassetid://10804731440")[1]
for i=1,2 do
local b=Rayfield:FindFirstChild("Build")
if b and b.Value==InterfaceBuild then break end
if i<2 then local o=Rayfield Rayfield=game:GetObjects("rbxassetid://10804731440")[1]o:Destroy()end
end
Rayfield.Enabled=false
if gethui then Rayfield.Parent=gethui()
elseif syn and syn.protect_gui then syn.protect_gui(Rayfield)Rayfield.Parent=CoreGui
elseif CoreGui:FindFirstChild("RobloxGui")then Rayfield.Parent=CoreGui.RobloxGui
else Rayfield.Parent=CoreGui end
for _,i in ipairs((gethui and gethui()or CoreGui):GetChildren())do
if i.Name==Rayfield.Name and i~=Rayfield then i.Enabled=false i.Name="Rayfield-Old"end
end
local useMobileSizing=Rayfield.AbsoluteSize.X<1024 and Rayfield.AbsoluteSize.Y<768
local useMobilePrompt=UserInputService.TouchEnabled
local Main=Rayfield.Main
local MPrompt=Rayfield:FindFirstChild("Prompt")
local Topbar,Elements,LoadingFrame,TabList=Main.Topbar,Main.Elements,Main.LoadingFrame,Main.TabList
local dragBar=Rayfield:FindFirstChild("Drag")
local dragInteract=dragBar and dragBar.Interact
local dragBarCosmetic=dragBar and dragBar.Drag
local dragOffset,dragOffsetMobile=255,150
local Notifications=Rayfield.Notifications
Rayfield.DisplayOrder=100
LoadingFrame.Version.Text=Release
local Icons=loadWithTimeout("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/refs/heads/main/icons.lua")
local CFileName,CEnabled,Minimised,Hidden,Debounce,searchOpen,globalLoaded,rayfieldDestroyed=nil,false,false,false,false,false,nil,false
local TAB_BUTTON_HEIGHT,TAB_SECTION_HEIGHT,TOPBAR_HEIGHT=30,18,45
local TabListCanvasConnection
local TabListOrderCounter=0
local CurrentTabSectionName

local function getSidebarWidth()
local w=Main and Main.AbsoluteSize.X or 0
if w<=0 then return 140 end
return math.clamp(math.floor(w*0.22),132,150)
end
local function updateTabListCanvas()
pcall(function()
local l=TabList:FindFirstChildWhichIsA("UIListLayout")
TabList.CanvasSize=UDim2.new(0,0,0,(l and l.AbsoluteContentSize.Y or 0)+8)
end)
end
local function styleTabSection(t)
if not t or not t:IsA("TextLabel")then return end
t.BackgroundTransparency=1 t.BorderSizePixel=0
t.TextXAlignment=Enum.TextXAlignment.Left t.TextYAlignment=Enum.TextYAlignment.Bottom
t.Font=Enum.Font.GothamSemibold t.TextSize=11 t.TextTransparency=0.38
t.TextColor3=SelectedTheme.TextColor t.RichText=false t.ZIndex=4
end
local function applySidebarLayout()
pcall(function()
local sw=getSidebarWidth()
Main.ClipsDescendants=true TabList.ClipsDescendants=true Elements.ClipsDescendants=true
TabList.AnchorPoint=Vector2.zero
TabList.Position=UDim2.new(0,8,0,TOPBAR_HEIGHT+8)
TabList.Size=UDim2.new(0,sw,1,-(TOPBAR_HEIGHT+16))
TabList.BackgroundTransparency=1
if TabList:IsA("ScrollingFrame")then
TabList.Active=true TabList.ScrollingDirection=Enum.ScrollingDirection.Y TabList.ScrollingEnabled=true
TabList.AutomaticCanvasSize=Enum.AutomaticSize.None TabList.ScrollBarThickness=4
end
local l=TabList:FindFirstChildWhichIsA("UIListLayout")
if l then
l.FillDirection=Enum.FillDirection.Vertical l.HorizontalAlignment=Enum.HorizontalAlignment.Left
l.VerticalAlignment=Enum.VerticalAlignment.Top l.SortOrder=Enum.SortOrder.LayoutOrder l.Padding=UDim.new(0,5)
if not TabListCanvasConnection and TabList:IsA("ScrollingFrame")then
TabListCanvasConnection=l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateTabListCanvas)
end
end
Elements.AnchorPoint=Vector2.zero
Elements.Position=UDim2.new(0,sw+16,0,TOPBAR_HEIGHT+8)
Elements.Size=UDim2.new(1,-(sw+24),1,-(TOPBAR_HEIGHT+16))
for _,p in ipairs(Elements:GetChildren())do
if p:IsA("ScrollingFrame")or p:IsA("Frame")then p.Size=UDim2.new(1,0,1,0)p.Position=UDim2.new()p.ClipsDescendants=true end
end
for _,b in ipairs(TabList:GetChildren())do
if b:IsA("Frame")and b.Name~="Placeholder"then b.Size=UDim2.new(1,-8,0,TAB_BUTTON_HEIGHT)
elseif b:IsA("TextLabel")and b:GetAttribute("RayfieldTabSection")then b.Size=UDim2.new(1,-10,0,TAB_SECTION_HEIGHT)styleTabSection(b)end
end
if Main:FindFirstChild("Search")then
Main.Search.Position=UDim2.new(0,sw+26,0,TOPBAR_HEIGHT+12)
Main.Search.Size=UDim2.new(1,-(sw+42),0,32)
end
updateTabListCanvas()
end)
end
Main:GetPropertyChangedSignal("AbsoluteSize"):Connect(applySidebarLayout)

local function ChangeTheme(Theme)
if typeof(Theme)=="string"then SelectedTheme=Themes[Theme]elseif typeof(Theme)=="table"then SelectedTheme=Theme end
local R=Rayfield.Main
R.BackgroundColor3=SelectedTheme.Background
R.Topbar.BackgroundColor3=SelectedTheme.Topbar
R.Topbar.CornerRepair.BackgroundColor3=SelectedTheme.Topbar
R.Shadow.Image.ImageColor3=SelectedTheme.Shadow
R.Topbar.ChangeSize.ImageColor3=SelectedTheme.TextColor
R.Topbar.Hide.ImageColor3=SelectedTheme.TextColor
R.Topbar.Search.ImageColor3=SelectedTheme.TextColor
Main.Search.BackgroundColor3=SelectedTheme.TextColor
Main.Search.Shadow.ImageColor3=SelectedTheme.TextColor
Main.Search.Search.ImageColor3=SelectedTheme.TextColor
Main.Search.Input.PlaceholderColor3=SelectedTheme.TextColor
Main.Search.UIStroke.Color=SelectedTheme.SecondaryElementStroke
if Main:FindFirstChild("Notice")then Main.Notice.BackgroundColor3=SelectedTheme.Background end
for _,t in ipairs(Rayfield:GetDescendants())do
if t.Parent.Parent~=Notifications and(t:IsA("TextLabel")or t:IsA("TextBox"))then t.TextColor3=SelectedTheme.TextColor end
end
for _,P in ipairs(Elements:GetChildren())do
for _,E in ipairs(P:GetChildren())do
local n=E.Name
if E.ClassName=="Frame"and n~="Placeholder"and n~="SectionSpacing"and n~="Divider"and n~="SectionTitle"and n~="SearchTitle-fsefsefesfsefesfesfThanks"then
E.BackgroundColor3=SelectedTheme.ElementBackground E.UIStroke.Color=SelectedTheme.ElementStroke
end
end
end
for _,g in ipairs(TabList:GetChildren())do
if g:IsA("TextLabel")and g:GetAttribute("RayfieldTabSection")then styleTabSection(g)end
end
end

local function getIcon(name)
if not Icons then warn("Lucide Icons: icon library not loaded")return end
name=string.match(string.lower(name),"^%s*(.*)%s*$")
local r=Icons["48px"][name]
if not r then error('Lucide Icons: Failed to find icon "'..name..'"',2)end
local s,o=r[2],r[3]
if type(r[1])~="number"or type(s)~="table"or type(o)~="table"then error("Lucide Icons: invalid asset entry")end
return{id=r[1],imageRectSize=Vector2.new(s[1],s[2]),imageRectOffset=Vector2.new(o[1],o[2])}
end
local function getAssetUri(id)
if type(id)=="number"then return"rbxassetid://"..id end
if type(id)=="string"and not Icons then warn("Rayfield | Icons library not loaded")else warn("Rayfield | Icon must be an ID (number) or Lucide name (string)")end
return"rbxassetid://0"
end
local function setIcon(img,icon)
if typeof(icon)=="string"and Icons then
local a=getIcon(icon)img.Image="rbxassetid://"..a.id img.ImageRectOffset=a.imageRectOffset img.ImageRectSize=a.imageRectSize
else img.Image=getAssetUri(icon)end
end

local function makeDraggable(object,dragObject,enableTaptic,tapticOffset)
local dragging,relative=false
local offset=Vector2.zero
local sg=object:FindFirstAncestorWhichIsA("ScreenGui")
if sg and sg.IgnoreGuiInset then offset+=getService("GuiService"):GetGuiInset()end
local function hover()
if dragBar and enableTaptic then
dragBar.MouseEnter:Connect(function()if not dragging and not Hidden then tw(dragBarCosmetic,.25,{BackgroundTransparency=.5,Size=UDim2.new(0,120,0,4)},Enum.EasingStyle.Back)end end)
dragBar.MouseLeave:Connect(function()if not dragging and not Hidden then tw(dragBarCosmetic,.25,{BackgroundTransparency=.7,Size=UDim2.new(0,100,0,4)},Enum.EasingStyle.Back)end end)
end
end
hover()
dragObject.InputBegan:Connect(function(input,processed)
if processed then return end
local t=input.UserInputType.Name
if t=="MouseButton1"or t=="Touch"then
dragging=true
relative=object.AbsolutePosition+object.AbsoluteSize*object.AnchorPoint-UserInputService:GetMouseLocation()
if enableTaptic and not Hidden then tw(dragBarCosmetic,.35,{Size=UDim2.new(0,110,0,4),BackgroundTransparency=0},Enum.EasingStyle.Back)end
end
end)
local ie=UserInputService.InputEnded:Connect(function(input)
if not dragging then return end
local t=input.UserInputType.Name
if t=="MouseButton1"or t=="Touch"then
dragging=false hover()
if enableTaptic and not Hidden then tw(dragBarCosmetic,.35,{Size=UDim2.new(0,100,0,4),BackgroundTransparency=.7},Enum.EasingStyle.Back)end
end
end)
local rs=RunService.RenderStepped:Connect(function()
if dragging and not Hidden then
local p=UserInputService:GetMouseLocation()+relative+offset
local y=tapticOffset and((useMobileSizing and tapticOffset[2])or tapticOffset[1])
if enableTaptic and tapticOffset then
tw(object,.4,{Position=UDim2.fromOffset(p.X,p.Y)})
tw(dragObject.Parent,.05,{Position=UDim2.fromOffset(p.X,p.Y+y)})
else
if dragBar and tapticOffset then dragBar.Position=UDim2.fromOffset(p.X,p.Y+y)end
object.Position=UDim2.fromOffset(p.X,p.Y)
end
end
end)
object.Destroying:Connect(function()ie:Disconnect()rs:Disconnect()end)
end

local function PackColor(c)return{R=c.R*255,G=c.G*255,B=c.B*255}end
local function UnpackColor(c)return Color3.fromRGB(c.R,c.G,c.B)end

local function LoadConfiguration(cfg)
local ok,Data=pcall(function()return HttpService:JSONDecode(cfg)end)
local changed
if not ok then warn("Rayfield: could not decode configuration file, try deleting it.")return end
for name,Flag in pairs(RayfieldLibrary.Flags)do
local v=Data[name]
if(typeof(v)=="boolean"and v==false)or v then
task.spawn(function()
if Flag.Type=="ColorPicker"then changed=true Flag:Set(UnpackColor(v))
elseif(Flag.CurrentValue or Flag.CurrentKeybind or Flag.CurrentOption or Flag.Color)~=v then changed=true Flag:Set(v)end
end)
else warn("Rayfield | Unable to find '"..name.."' in the save file.")end
end
return changed
end
local function SaveConfiguration()
if not CEnabled or not globalLoaded then return end
local Data={}
for i,v in pairs(RayfieldLibrary.Flags)do
if v.Type=="ColorPicker"then Data[i]=PackColor(v.Color)
elseif typeof(v.CurrentValue)=="boolean"and v.CurrentValue==false then Data[i]=false
else Data[i]=v.CurrentValue or v.CurrentKeybind or v.CurrentOption or v.Color end
end
if writefile then writefile(ConfigurationFolder.."/"..CFileName..ConfigurationExtension,tostring(HttpService:JSONEncode(Data)))end
end

function RayfieldLibrary:Notify(data)
task.spawn(function()
local n=Notifications.Template:Clone()
n.Name=data.Title or"No Title Provided"
n.Parent=Notifications n.LayoutOrder=#Notifications:GetChildren()n.Visible=false
n.Title.Text=data.Title or"Unknown Title"
n.Description.Text=data.Content or"Unknown Content"
if data.Image then
if typeof(data.Image)=="string"and Icons then setIcon(n.Icon,data.Image)else n.Icon.Image=getAssetUri(data.Image)end
else n.Icon.Image="rbxassetid://0"end
n.Title.TextColor3=SelectedTheme.TextColor n.Description.TextColor3=SelectedTheme.TextColor
n.BackgroundColor3=SelectedTheme.Background n.UIStroke.Color=SelectedTheme.TextColor n.Icon.ImageColor3=SelectedTheme.TextColor
n.BackgroundTransparency=1 n.Title.TextTransparency=1 n.Description.TextTransparency=1
n.UIStroke.Transparency=1 n.Shadow.ImageTransparency=1 n.Size=UDim2.new(1,0,0,800)
n.Icon.ImageTransparency=1 n.Icon.BackgroundTransparency=1
task.wait()
n.Visible=true
local pad=Notifications:FindFirstChild("UIListLayout").Padding.Offset
local b1,b2=n.Title.TextBounds.Y,n.Description.TextBounds.Y
n.Size=UDim2.new(1,-60,0,-pad)
n.Icon.Size=UDim2.new(0,32,0,32)n.Icon.Position=UDim2.new(0,20,.5,0)
tw(n,.6,{Size=UDim2.new(1,0,0,math.max(b1+b2+31,60))})
task.wait(.15)
tw(n,.4,{BackgroundTransparency=.45})tw(n.Title,.3,{TextTransparency=0})
task.wait(.05)
tw(n.Icon,.3,{ImageTransparency=0})
task.wait(.05)
tw(n.Description,.3,{TextTransparency=.35})tw(n.UIStroke,.4,{Transparency=.95})tw(n.Shadow,.3,{ImageTransparency=.82})
task.wait(data.Duration or math.min(math.max(#n.Description.Text*.1+2.5,3),10))
n.Icon.Visible=false
tw(n,.4,{BackgroundTransparency=1})tw(n.UIStroke,.4,{Transparency=1})tw(n.Shadow,.3,{ImageTransparency=1})
tw(n.Title,.3,{TextTransparency=1})tw(n.Description,.3,{TextTransparency=1})
tw(n,1,{Size=UDim2.new(1,-90,0,0)})
task.wait(1)
tw(n,1,{Size=UDim2.new(1,-90,0,-pad)})
n.Visible=false n:Destroy()
end)
end
function RayfieldLibrary:Notification(title,content,time,mode)
local mm=mode==nil and warn or mode
local img=0
if mm==true then img=136186846844342 elseif mm==false then img=71508738660632 elseif mm==warn then img=9441432403 end
RayfieldLibrary:Notify({Title=title,Content=content,Duration=time or 4,Image=img,Actions={}})
end

local function tabBtnState(b,bg,img,txt,stroke,t)
tw(b,t,{BackgroundTransparency=bg})tw(b.Title,t,{TextTransparency=txt})tw(b.Image,t,{ImageTransparency=img})tw(b.UIStroke,t,{Transparency=stroke})
end
local function eachTabBtn(f)
for _,b in ipairs(TabList:GetChildren())do if b.ClassName=="Frame"and b.Name~="Placeholder"then f(b)end end
end
local function eachElement(f)
for _,tab in ipairs(Elements:GetChildren())do
if tab.Name~="Template"and tab.ClassName=="ScrollingFrame"and tab.Name~="Placeholder"then
for _,e in ipairs(tab:GetChildren())do
if e.ClassName=="Frame"and e.Name~="SectionSpacing"and e.Name~="Placeholder"then f(e)end
end
end
end
end
local function isSecTitle(e)return e.Name=="SectionTitle"or e.Name=="SearchTitle-fsefsefesfsefesfesfThanks"end
local function selectedTabStates(t)
eachTabBtn(function(b)
if tostring(Elements.UIPageLayout.CurrentPage)==b.Title.Text then tabBtnState(b,0,0,0,1,t)else tabBtnState(b,.7,.2,.2,.5,t)end
end)
end

local function openSearch()
searchOpen=true
local S=Main.Search
S.BackgroundTransparency=1 S.Shadow.ImageTransparency=1 S.Input.TextTransparency=1 S.Search.ImageTransparency=1 S.UIStroke.Transparency=1
S.Size=UDim2.new(1,0,0,80)S.Position=UDim2.new(.5,0,0,70)
S.Input.Interactable=true S.Visible=true
eachTabBtn(function(b)b.Interact.Visible=false tabBtnState(b,1,1,1,1,.3)end)
S.Input:CaptureFocus()
tw(S.Shadow,.05,{ImageTransparency=.95},Enum.EasingStyle.Quint)
tw(S,.3,{Position=UDim2.new(.5,0,0,57),BackgroundTransparency=.9})
tw(S.UIStroke,.3,{Transparency=.8})tw(S.Input,.3,{TextTransparency=.2})tw(S.Search,.3,{ImageTransparency=.5})
tw(S,.5,{Size=UDim2.new(1,-35,0,35)})
end
local function closeSearch()
searchOpen=false
local S=Main.Search
local q=Enum.EasingStyle.Quint
tw(S,.35,{BackgroundTransparency=1,Size=UDim2.new(1,-55,0,30)},q)
tw(S.Search,.15,{ImageTransparency=1},q)tw(S.Shadow,.15,{ImageTransparency=1},q)tw(S.UIStroke,.15,{Transparency=1},q)tw(S.Input,.15,{TextTransparency=1},q)
eachTabBtn(function(b)b.Interact.Visible=true end)
selectedTabStates(.3)
S.Input.Text=""S.Input.Interactable=false
end

local function Hide(notify)
if MPrompt then
MPrompt.Title.TextColor3=Color3.new(1,1,1)MPrompt.Position=UDim2.new(.5,0,0,-50)MPrompt.Size=UDim2.new(0,40,0,10)
MPrompt.BackgroundTransparency=1 MPrompt.Title.TextTransparency=1 MPrompt.Visible=true
end
task.spawn(closeSearch)
Debounce=true
if notify then
RayfieldLibrary:Notify({Title="Interface Hidden",Content=useMobilePrompt and"The interface has been hidden, you can unhide the interface by tapping 'Show'."or("The interface has been hidden, you can unhide the interface by tapping "..ToggleKey.."."),Duration=7,Image=4400697855})
end
tw(Main,.5,{Size=UDim2.new(0,470,0,0)})tw(Main.Topbar,.5,{Size=UDim2.new(0,470,0,45)})
tw(Main,.5,{BackgroundTransparency=1})tw(Main.Topbar,.5,{BackgroundTransparency=1})tw(Main.Topbar.Divider,.5,{BackgroundTransparency=1})
tw(Main.Topbar.CornerRepair,.3,{BackgroundTransparency=1})tw(Main.Topbar.Title,.5,{TextTransparency=1})
tw(Main.Shadow.Image,.5,{ImageTransparency=1})tw(Topbar.UIStroke,.5,{Transparency=1})
tw(dragBarCosmetic,.25,{BackgroundTransparency=1},Enum.EasingStyle.Back)
if useMobilePrompt and MPrompt then
tw(MPrompt,.5,{Size=UDim2.new(0,120,0,30),Position=UDim2.new(.5,0,0,20),BackgroundTransparency=.3})tw(MPrompt.Title,.5,{TextTransparency=.3})
end
for _,b in ipairs(Topbar:GetChildren())do if b.ClassName=="ImageButton"then tw(b,.5,{ImageTransparency=1})end end
eachTabBtn(function(b)tabBtnState(b,1,1,1,1,.3)end)
dragInteract.Visible=false
eachElement(function(e)
if isSecTitle(e)then tw(e.Title,.3,{TextTransparency=1})
elseif e.Name=="Divider"then tw(e.Divider,.3,{BackgroundTransparency=1})
else
local s=e:FindFirstChild("UIStroke")if s then tw(s,.3,{Transparency=1})end
local t=e:FindFirstChild("Title")if t then tw(t,.3,{TextTransparency=1})end
tw(e,.3,{BackgroundTransparency=1})
end
for _,c in ipairs(e:GetDescendants())do if c:IsA("GuiObject")then c.Visible=false end end
end)
task.wait(.5)
Main.Visible=false Debounce=false
end

local function Maximise()
Debounce=true
Topbar.ChangeSize.Image="rbxassetid://10137941941"
tw(Topbar.UIStroke,.5,{Transparency=1})tw(Main.Shadow.Image,.5,{ImageTransparency=.6})
tw(Topbar.CornerRepair,.5,{BackgroundTransparency=0})tw(Topbar.Divider,.5,{BackgroundTransparency=0})
tw(dragBarCosmetic,.25,{BackgroundTransparency=.7},Enum.EasingStyle.Back)
tw(Main,.5,{Size=useMobileSizing and UDim2.new(0,570,0,275)or UDim2.new(0,570,0,475)})
tw(Topbar,.5,{Size=UDim2.new(0,570,0,45)})
TabList.Visible=true
task.wait(.2)
Elements.Visible=true
eachElement(function(e)
if isSecTitle(e)then tw(e.Title,.3,{TextTransparency=.4})
elseif e.Name=="Divider"then tw(e.Divider,.3,{BackgroundTransparency=.85})
else tw(e,.3,{BackgroundTransparency=0})tw(e.UIStroke,.3,{Transparency=0})tw(e.Title,.3,{TextTransparency=0})end
for _,c in ipairs(e:GetChildren())do
local k=c.ClassName
if k=="Frame"or k=="TextLabel"or k=="TextBox"or k=="ImageButton"or k=="ImageLabel"then c.Visible=true end
end
end)
task.wait(.1)
selectedTabStates(.3)
task.wait(.5)
Debounce=false
end

local function Unhide()
Debounce=true
Main.Position=UDim2.new(.5,0,.5,0)Main.Visible=true
tw(Main,.5,{Size=useMobileSizing and UDim2.new(0,570,0,275)or UDim2.new(0,570,0,475)})
tw(Main.Topbar,.5,{Size=UDim2.new(0,570,0,45)})tw(Main.Shadow.Image,.7,{ImageTransparency=.6})
tw(Main,.5,{BackgroundTransparency=0})tw(Main.Topbar,.5,{BackgroundTransparency=0})tw(Main.Topbar.Divider,.5,{BackgroundTransparency=0})
tw(Main.Topbar.CornerRepair,.5,{BackgroundTransparency=0})tw(Main.Topbar.Title,.5,{TextTransparency=0})
if MPrompt then
tw(MPrompt,.5,{Size=UDim2.new(0,40,0,10),Position=UDim2.new(.5,0,0,-50),BackgroundTransparency=1})tw(MPrompt.Title,.5,{TextTransparency=1})
task.spawn(function()task.wait(.5)MPrompt.Visible=false end)
end
if Minimised then task.spawn(Maximise)end
dragBar.Position=useMobileSizing and UDim2.new(.5,0,.5,dragOffsetMobile)or UDim2.new(.5,0,.5,dragOffset)
dragInteract.Visible=true
for _,b in ipairs(Topbar:GetChildren())do
if b.ClassName=="ImageButton"then tw(b,.7,{ImageTransparency=b.Name=="Icon"and 0 or .8})end
end
selectedTabStates(.3)
eachElement(function(e)
if isSecTitle(e)then tw(e.Title,.3,{TextTransparency=.4})
elseif e.Name=="Divider"then tw(e.Divider,.3,{BackgroundTransparency=.85})
else
tw(e,.3,{BackgroundTransparency=0})
local s=e:FindFirstChild("UIStroke")if s then tw(s,.3,{Transparency=0})end
local t=e:FindFirstChild("Title")if t then tw(t,.3,{TextTransparency=0})end
end
for _,c in ipairs(e:GetDescendants())do if c:IsA("GuiObject")then c.Visible=true end end
end)
tw(dragBarCosmetic,.25,{BackgroundTransparency=.5},Enum.EasingStyle.Back)
task.wait(.5)
Minimised=false Debounce=false
end

local function Minimise()
Debounce=true
Topbar.ChangeSize.Image="rbxassetid://11036884234"
Topbar.UIStroke.Color=SelectedTheme.ElementStroke
task.spawn(closeSearch)
eachTabBtn(function(b)tabBtnState(b,1,1,1,1,.3)end)
eachElement(function(e)
if isSecTitle(e)then tw(e.Title,.3,{TextTransparency=1})
elseif e.Name=="Divider"then tw(e.Divider,.3,{BackgroundTransparency=1})
else tw(e,.3,{BackgroundTransparency=1})tw(e.UIStroke,.3,{Transparency=1})tw(e.Title,.3,{TextTransparency=1})end
for _,c in ipairs(e:GetChildren())do
local k=c.ClassName
if k=="Frame"or k=="TextLabel"or k=="TextBox"or k=="ImageButton"or k=="ImageLabel"then c.Visible=false end
end
end)
tw(dragBarCosmetic,.25,{BackgroundTransparency=1},Enum.EasingStyle.Back)
tw(Topbar.UIStroke,.5,{Transparency=0})tw(Main.Shadow.Image,.5,{ImageTransparency=1})
tw(Topbar.CornerRepair,.5,{BackgroundTransparency=1})tw(Topbar.Divider,.5,{BackgroundTransparency=1})
tw(Main,.5,{Size=UDim2.new(0,495,0,45)})tw(Topbar,.5,{Size=UDim2.new(0,495,0,45)})
task.wait(.3)
Elements.Visible=false TabList.Visible=false
task.wait(.2)
Debounce=false
end

local function flashError(el,name,err,ind)
tw(el,.6,{BackgroundColor3=Color3.fromRGB(85,0,0)})tw(el.UIStroke,.6,{Transparency=1})
if ind then tw(ind,.6,{TextTransparency=1})end
el.Title.Text="Callback Error"
print("Rayfield | "..name.." Callback Error "..tostring(err))
warn("Check docs.sirius.menu for help with Rayfield specific development.")
task.wait(.5)
el.Title.Text=name
tw(el,.6,{BackgroundColor3=SelectedTheme.ElementBackground})tw(el.UIStroke,.6,{Transparency=0})
if ind then tw(ind,.6,{TextTransparency=.9})end
end
local function fadeIn(e)
e.BackgroundTransparency=1 e.UIStroke.Transparency=1 e.Title.TextTransparency=1
tw(e,.7,{BackgroundTransparency=0})tw(e.UIStroke,.7,{Transparency=0})tw(e.Title,.7,{TextTransparency=0})
end
local function hoverBG(e)
e.MouseEnter:Connect(function()tw(e,.6,{BackgroundColor3=SelectedTheme.ElementBackgroundHover})end)
e.MouseLeave:Connect(function()tw(e,.6,{BackgroundColor3=SelectedTheme.ElementBackground})end)
end
local function themeChanged(f)Rayfield.Main:GetPropertyChangedSignal("BackgroundColor3"):Connect(f)end

function RayfieldLibrary:CreateWindow(Settings)
if Rayfield:FindFirstChild("Loading")and getgenv and not getgenv().rayfieldCached then
Rayfield.Enabled=true Rayfield.Loading.Visible=true
task.wait(1.4)
Rayfield.Loading.Visible=false
end
if getgenv then getgenv().rayfieldCached=true end
if Settings.ToggleUIKeybind then
local kb=Settings.ToggleUIKeybind
if type(kb)=="string"then
kb=string.upper(kb)
assert(pcall(function()return Enum.KeyCode[kb]end),"ToggleUIKeybind must be a valid KeyCode")
ToggleKey=kb
elseif typeof(kb)=="EnumItem"then
assert(kb.EnumType==Enum.KeyCode,"ToggleUIKeybind must be a KeyCode enum")
ToggleKey=kb.Name
else error("ToggleUIKeybind must be a string or KeyCode enum")end
end
pcall(function()if isfolder and not isfolder(RayfieldFolder)then makefolder(RayfieldFolder)end end)
Topbar.Title.Text=Settings.Name
Main.Size=UDim2.new(0,480,0,100)Main.Visible=true Main.BackgroundTransparency=1
if Main:FindFirstChild("Notice")then Main.Notice.Visible=false end
Main.Shadow.Image.ImageTransparency=1
LoadingFrame.Title.TextTransparency=1 LoadingFrame.Subtitle.TextTransparency=1
if Settings.ShowText and MPrompt then MPrompt.Title.Text="Show "..Settings.ShowText end
LoadingFrame.Version.TextTransparency=1
LoadingFrame.Title.Text=Settings.LoadingTitle or"Rayfield"
LoadingFrame.Subtitle.Text=Settings.LoadingSubtitle or"Interface Suite"
if Settings.LoadingTitle~="Rayfield Interface Suite"then LoadingFrame.Version.Text="Rayfield UI"end
if Settings.Icon and Settings.Icon~=0 and Topbar:FindFirstChild("Icon")then
Topbar.Icon.Visible=true Topbar.Title.Position=UDim2.new(0,47,.5,0)
setIcon(Topbar.Icon,Settings.Icon)
end
if dragBar then dragBar.Visible=false dragBarCosmetic.BackgroundTransparency=1 dragBar.Visible=true end
if Settings.Theme then
if not pcall(ChangeTheme,Settings.Theme)then
if not pcall(ChangeTheme,"Default")then warn("CRITICAL ERROR - NO DEFAULT THEME")end
warn("issue rendering theme. no theme on file")
end
end
Topbar.Visible=false Elements.Visible=false LoadingFrame.Visible=true
pcall(function()
local cs=Settings.ConfigurationSaving
if not cs.FileName then cs.FileName=tostring(game.PlaceId)end
if cs.Enabled==nil then cs.Enabled=false end
CFileName=cs.FileName
ConfigurationFolder=cs.FolderName or ConfigurationFolder
CEnabled=cs.Enabled
if cs.Enabled and not isfolder(ConfigurationFolder)then makefolder(ConfigurationFolder)end
end)
makeDraggable(Main,Topbar,false,{dragOffset,dragOffsetMobile})
if dragBar then
dragBar.Position=useMobileSizing and UDim2.new(.5,0,.5,dragOffsetMobile)or UDim2.new(.5,0,.5,dragOffset)
makeDraggable(Main,dragInteract,true,{dragOffset,dragOffsetMobile})
end
eachTabBtn(function(b)b.BackgroundTransparency=1 b.Title.TextTransparency=1 b.Image.ImageTransparency=1 b.UIStroke.Transparency=1 end)
Notifications.Template.Visible=false Notifications.Visible=true Rayfield.Enabled=true
task.wait(.5)
tw(Main,.7,{BackgroundTransparency=0})tw(Main.Shadow.Image,.7,{ImageTransparency=.6})
task.wait(.1)
tw(LoadingFrame.Title,.7,{TextTransparency=0})
task.wait(.05)
tw(LoadingFrame.Subtitle,.7,{TextTransparency=0})
task.wait(.05)
tw(LoadingFrame.Version,.7,{TextTransparency=0})
Elements.Template.LayoutOrder=100000 Elements.Template.Visible=false
Elements.UIPageLayout.FillDirection=Enum.FillDirection.Horizontal
TabList.Template.Visible=false

local FirstTab=false
local Window={}

function Window:CreateTabSection(SectionName)
TabListOrderCounter+=1
CurrentTabSectionName=SectionName
local L=Instance.new("TextLabel")
L.Name="TabSection_"..tostring(SectionName)
L.Text="  "..string.upper(tostring(SectionName))
L.LayoutOrder=TabListOrderCounter L.Parent=TabList
L:SetAttribute("RayfieldTabSection",true)
styleTabSection(L)applySidebarLayout()
local V={}
function V:Set(n)SectionName=n CurrentTabSectionName=n L.Name="TabSection_"..tostring(n)L.Text="  "..string.upper(tostring(n))updateTabListCanvas()end
function V:Destroy()if CurrentTabSectionName==SectionName then CurrentTabSectionName=nil end L:Destroy()updateTabListCanvas()end
return V
end

function Window:CreateTab(Name,Image,Ext)
local SDone=false
local TabButton=TabList.Template:Clone()
TabButton.Name=Name TabButton.Title.Text=Name
TabListOrderCounter+=1
TabButton.LayoutOrder=TabListOrderCounter TabButton.Parent=TabList
TabButton:SetAttribute("RayfieldTabButton",true)
if CurrentTabSectionName then TabButton:SetAttribute("RayfieldTabSectionName",tostring(CurrentTabSectionName))end
local T=TabButton.Title
T.TextWrapped=false T.TextTruncate=Enum.TextTruncate.AtEnd T.TextSize=13
TabButton.Size=UDim2.new(1,-8,0,TAB_BUTTON_HEIGHT)TabButton.AnchorPoint=Vector2.zero TabButton.Position=UDim2.new(0,4,0,0)TabButton.ClipsDescendants=true
T.TextXAlignment=Enum.TextXAlignment.Left T.AnchorPoint=Vector2.new(0,.5)T.Position=UDim2.new(0,12,.5,0)T.Size=UDim2.new(1,-24,0,14)
if Image and Image~=0 then
setIcon(TabButton.Image,Image)
T.Position=UDim2.new(0,36,.5,0)T.Size=UDim2.new(1,-44,0,14)
TabButton.Image.Visible=true TabButton.Image.AnchorPoint=Vector2.new(0,.5)TabButton.Image.Position=UDim2.new(0,12,.5,0)
end
TabButton.BackgroundTransparency=1 T.TextTransparency=1 TabButton.Image.ImageTransparency=1 TabButton.UIStroke.Transparency=1
TabButton.Visible=not Ext or false
applySidebarLayout()
local TabPage=Elements.Template:Clone()
TabPage.Name=Name TabPage.Visible=true
TabPage.LayoutOrder=#Elements:GetChildren()or Ext and 10000
for _,t in ipairs(TabPage:GetChildren())do if t.ClassName=="Frame"and t.Name~="Placeholder"then t:Destroy()end end
TabPage.Parent=Elements TabPage.Size=UDim2.new(1,0,1,0)TabPage.Position=UDim2.new()TabPage.ClipsDescendants=true
applySidebarLayout()
if not FirstTab and not Ext then
Elements.UIPageLayout.Animated=false Elements.UIPageLayout:JumpTo(TabPage)Elements.UIPageLayout.Animated=true
end
TabButton.UIStroke.Color=SelectedTheme.TabStroke
local function paint(sel)
TabButton.BackgroundColor3=sel and SelectedTheme.TabBackgroundSelected or SelectedTheme.TabBackground
TabButton.Image.ImageColor3=sel and SelectedTheme.SelectedTabTextColor or SelectedTheme.TabTextColor
T.TextColor3=sel and SelectedTheme.SelectedTabTextColor or SelectedTheme.TabTextColor
end
paint(Elements.UIPageLayout.CurrentPage==TabPage)
task.wait(.1)
if FirstTab or Ext then
paint(false)
tw(TabButton,.7,{BackgroundTransparency=.7})tw(T,.7,{TextTransparency=.2})tw(TabButton.Image,.7,{ImageTransparency=.2})tw(TabButton.UIStroke,.7,{Transparency=.5})
elseif not Ext then
FirstTab=Name paint(true)
tw(TabButton.Image,.7,{ImageTransparency=0})tw(TabButton,.7,{BackgroundTransparency=0})tw(T,.7,{TextTransparency=0})
end
TabButton.Interact.MouseButton1Click:Connect(function()
if Minimised then return end
tw(TabButton,.7,{BackgroundTransparency=0})tw(TabButton.UIStroke,.7,{Transparency=1})tw(T,.7,{TextTransparency=0})tw(TabButton.Image,.7,{ImageTransparency=0})
tw(TabButton,.7,{BackgroundColor3=SelectedTheme.TabBackgroundSelected})tw(T,.7,{TextColor3=SelectedTheme.SelectedTabTextColor})tw(TabButton.Image,.7,{ImageColor3=SelectedTheme.SelectedTabTextColor})
for _,o in ipairs(TabList:GetChildren())do
if o.Name~="Template"and o.ClassName=="Frame"and o~=TabButton and o.Name~="Placeholder"then
tw(o,.7,{BackgroundColor3=SelectedTheme.TabBackground})tw(o.Title,.7,{TextColor3=SelectedTheme.TabTextColor})tw(o.Image,.7,{ImageColor3=SelectedTheme.TabTextColor})
tw(o,.7,{BackgroundTransparency=.7})tw(o.Title,.7,{TextTransparency=.2})tw(o.Image,.7,{ImageTransparency=.2})tw(o.UIStroke,.7,{Transparency=.5})
end
end
if Elements.UIPageLayout.CurrentPage~=TabPage then Elements.UIPageLayout:JumpTo(TabPage)end
end)

local Tab={}
local function regFlag(S)
if Settings.ConfigurationSaving and Settings.ConfigurationSaving.Enabled and S.Flag then RayfieldLibrary.Flags[S.Flag]=S end
end

function Tab:CreateButton(S)
local V={}
local B=Elements.Template.Button:Clone()
B.Name=S.Name B.Title.Text=S.Name B.Visible=true B.Parent=TabPage
fadeIn(B)
B.Interact.MouseButton1Click:Connect(function()
local ok,resp=pcall(S.Callback)
if rayfieldDestroyed then return end
if not ok then flashError(B,S.Name,resp,B.ElementIndicator)
else
if not S.Ext then SaveConfiguration()end
tw(B,.6,{BackgroundColor3=SelectedTheme.ElementBackgroundHover})tw(B.ElementIndicator,.6,{TextTransparency=1})tw(B.UIStroke,.6,{Transparency=1})
task.wait(.2)
tw(B,.6,{BackgroundColor3=SelectedTheme.ElementBackground})tw(B.ElementIndicator,.6,{TextTransparency=.9})tw(B.UIStroke,.6,{Transparency=0})
end
end)
B.MouseEnter:Connect(function()tw(B,.6,{BackgroundColor3=SelectedTheme.ElementBackgroundHover})tw(B.ElementIndicator,.6,{TextTransparency=.7})end)
B.MouseLeave:Connect(function()tw(B,.6,{BackgroundColor3=SelectedTheme.ElementBackground})tw(B.ElementIndicator,.6,{TextTransparency=.9})end)
function V:Set(n)B.Title.Text=n B.Name=n end
return V
end

function Tab:CreateColorPicker(S)
S.Type="ColorPicker"
local CP=Elements.Template.ColorPicker:Clone()
local Background=CP.CPBackground
local Display=Background.Display
local MainCP=Background.MainCP
local Slider=CP.ColorSlider
CP.ClipsDescendants=true CP.Name=S.Name CP.Title.Text=S.Name CP.Visible=true CP.Parent=TabPage
CP.Size=UDim2.new(1,-10,0,45)Background.Size=UDim2.new(0,39,0,22)Display.BackgroundTransparency=0
MainCP.MainPoint.ImageTransparency=1
CP.Interact.Size=UDim2.new(1,0,1,0)CP.Interact.Position=UDim2.new(.5,0,.5,0)
CP.RGB.Position=UDim2.new(0,17,0,70)CP.HexInput.Position=UDim2.new(0,17,0,90)
MainCP.ImageTransparency=1 Background.BackgroundTransparency=1
local function styleInputs()
for _,r in ipairs(CP.RGB:GetChildren())do if r:IsA("Frame")then r.BackgroundColor3=SelectedTheme.InputBackground r.UIStroke.Color=SelectedTheme.InputStroke end end
CP.HexInput.BackgroundColor3=SelectedTheme.InputBackground CP.HexInput.UIStroke.Color=SelectedTheme.InputStroke
end
styleInputs()
local opened,mainDragging,sliderDragging=false,false,false
local mouse=Players.LocalPlayer:GetMouse()
MainCP.Image="http://www.roblox.com/asset/?id=11415645739"
CP.Interact.MouseButton1Down:Connect(function()
task.spawn(function()
tw(CP,.6,{BackgroundColor3=SelectedTheme.ElementBackgroundHover})tw(CP.UIStroke,.6,{Transparency=1})
task.wait(.2)
tw(CP,.6,{BackgroundColor3=SelectedTheme.ElementBackground})tw(CP.UIStroke,.6,{Transparency=0})
end)
if not opened then
opened=true
tw(Background,.45,{Size=UDim2.new(0,18,0,15)})
task.wait(.1)
tw(CP,.6,{Size=UDim2.new(1,-10,0,120)})tw(Background,.6,{Size=UDim2.new(0,173,0,86)})tw(Display,.6,{BackgroundTransparency=1})
tw(CP.Interact,.6,{Position=UDim2.new(.289,0,.5,0)})tw(CP.RGB,.8,{Position=UDim2.new(0,17,0,40)})tw(CP.HexInput,.5,{Position=UDim2.new(0,17,0,73)})
tw(CP.Interact,.6,{Size=UDim2.new(.574,0,1,0)})tw(MainCP.MainPoint,.2,{ImageTransparency=0})
tw(MainCP,.2,{ImageTransparency=SelectedTheme~=Themes.Default and .25 or .1})tw(Background,.6,{BackgroundTransparency=0})
else
opened=false
tw(CP,.6,{Size=UDim2.new(1,-10,0,45)})tw(Background,.6,{Size=UDim2.new(0,39,0,22)})
tw(CP.Interact,.6,{Size=UDim2.new(1,0,1,0)})tw(CP.Interact,.6,{Position=UDim2.new(.5,0,.5,0)})
tw(CP.RGB,.6,{Position=UDim2.new(0,17,0,70)})tw(CP.HexInput,.5,{Position=UDim2.new(0,17,0,90)})
tw(Display,.6,{BackgroundTransparency=0})tw(MainCP.MainPoint,.2,{ImageTransparency=1})tw(MainCP,.2,{ImageTransparency=1})tw(Background,.6,{BackgroundTransparency=1})
end
end)
UserInputService.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then mainDragging=false sliderDragging=false end
end)
MainCP.MouseButton1Down:Connect(function()if opened then mainDragging=true end end)
MainCP.MainPoint.MouseButton1Down:Connect(function()if opened then mainDragging=true end end)
Slider.MouseButton1Down:Connect(function()sliderDragging=true end)
Slider.SliderPoint.MouseButton1Down:Connect(function()sliderDragging=true end)
local h,s,v=S.Color:ToHSV()
local hex=string.format("#%02X%02X%02X",S.Color.R*255,S.Color.G*255,S.Color.B*255)
CP.HexInput.InputBox.Text=hex
local function setDisplay()
MainCP.MainPoint.Position=UDim2.new(s,-MainCP.MainPoint.AbsoluteSize.X/2,1-v,-MainCP.MainPoint.AbsoluteSize.Y/2)
MainCP.MainPoint.ImageColor3=Color3.fromHSV(h,s,v)
Background.BackgroundColor3=Color3.fromHSV(h,1,1)
Display.BackgroundColor3=Color3.fromHSV(h,s,v)
Slider.SliderPoint.Position=UDim2.new(0,h*Slider.AbsoluteSize.X-Slider.SliderPoint.AbsoluteSize.X/2,.5,0)
Slider.SliderPoint.ImageColor3=Color3.fromHSV(h,1,1)
local c=Color3.fromHSV(h,s,v)
CP.RGB.RInput.InputBox.Text=tostring(math.floor(c.R*255+.5))
CP.RGB.GInput.InputBox.Text=tostring(math.floor(c.G*255+.5))
CP.RGB.BInput.InputBox.Text=tostring(math.floor(c.B*255+.5))
hex=string.format("#%02X%02X%02X",c.R*255,c.G*255,c.B*255)
CP.HexInput.InputBox.Text=hex
end
setDisplay()
CP.HexInput.InputBox.FocusLost:Connect(function()
if not pcall(function()
local r,g,b=string.match(CP.HexInput.InputBox.Text,"^#?(%w%w)(%w%w)(%w%w)$")
local c=Color3.fromRGB(tonumber(r,16),tonumber(g,16),tonumber(b,16))
h,s,v=c:ToHSV()
hex=CP.HexInput.InputBox.Text
setDisplay()
S.Color=c
end)then CP.HexInput.InputBox.Text=hex end
pcall(function()S.Callback(Color3.fromHSV(h,s,v))end)
S.Color=Color3.fromHSV(h,s,v)
if not S.Ext then SaveConfiguration()end
end)
local function rgbBox(box,which)
local value=tonumber(box.Text)
local c=Color3.fromHSV(h,s,v)
local R,G,B=math.floor(c.R*255+.5),math.floor(c.G*255+.5),math.floor(c.B*255+.5)
local save
if which=="R"then save=R R=value elseif which=="G"then save=G G=value else save=B B=value end
if value then
value=math.clamp(value,0,255)
h,s,v=Color3.fromRGB(R,G,B):ToHSV()
setDisplay()
else box.Text=tostring(save)end
S.Color=Color3.fromHSV(h,s,v)
if not S.Ext then SaveConfiguration()end
end
for _,p in ipairs({{"RInput","R"},{"GInput","G"},{"BInput","B"}})do
CP.RGB[p[1]].InputBox.FocusLost:Connect(function()
rgbBox(CP.RGB[p[1]].InputBox,p[2])
pcall(function()S.Callback(Color3.fromHSV(h,s,v))end)
end)
end
local function dragUpdate()
local c=Color3.fromHSV(h,s,v)
Display.BackgroundColor3=c
MainCP.MainPoint.ImageColor3=c
Background.BackgroundColor3=Color3.fromHSV(h,1,1)
CP.RGB.RInput.InputBox.Text=tostring(math.floor(c.R*255+.5))
CP.RGB.GInput.InputBox.Text=tostring(math.floor(c.G*255+.5))
CP.RGB.BInput.InputBox.Text=tostring(math.floor(c.B*255+.5))
CP.HexInput.InputBox.Text=string.format("#%02X%02X%02X",c.R*255,c.G*255,c.B*255)
pcall(function()S.Callback(c)end)
S.Color=c
if not S.Ext then SaveConfiguration()end
end
RunService.RenderStepped:Connect(function()
if mainDragging then
local lx=math.clamp(mouse.X-MainCP.AbsolutePosition.X,0,MainCP.AbsoluteSize.X)
local ly=math.clamp(mouse.Y-MainCP.AbsolutePosition.Y,0,MainCP.AbsoluteSize.Y)
MainCP.MainPoint.Position=UDim2.new(0,lx-MainCP.MainPoint.AbsoluteSize.X/2,0,ly-MainCP.MainPoint.AbsoluteSize.Y/2)
s=lx/MainCP.AbsoluteSize.X v=1-(ly/MainCP.AbsoluteSize.Y)
dragUpdate()
end
if sliderDragging then
local lx=math.clamp(mouse.X-Slider.AbsolutePosition.X,0,Slider.AbsoluteSize.X)
h=lx/Slider.AbsoluteSize.X
Slider.SliderPoint.Position=UDim2.new(0,lx-Slider.SliderPoint.AbsoluteSize.X/2,.5,0)
Slider.SliderPoint.ImageColor3=Color3.fromHSV(h,1,1)
dragUpdate()
end
end)
regFlag(S)
function S:Set(c)S.Color=c h,s,v=c:ToHSV()setDisplay()end
CP.MouseEnter:Connect(function()tw(CP,.6,{BackgroundColor3=SelectedTheme.ElementBackgroundHover})end)
CP.MouseLeave:Connect(function()tw(CP,.6,{BackgroundColor3=SelectedTheme.ElementBackground})end)
themeChanged(styleInputs)
return S
end

function Tab:CreateSection(Name)
local V={}
if SDone then local sp=Elements.Template.SectionSpacing:Clone()sp.Visible=true sp.Parent=TabPage end
local Sec=Elements.Template.SectionTitle:Clone()
Sec.Title.Text=Name Sec.Visible=true Sec.Parent=TabPage
Sec.Title.TextTransparency=1
tw(Sec.Title,.7,{TextTransparency=.4})
function V:Set(n)Sec.Title.Text=n end
SDone=true
return V
end

function Tab:CreateDivider()
local V={}
local Dv=Elements.Template.Divider:Clone()
Dv.Visible=true Dv.Parent=TabPage Dv.Divider.BackgroundTransparency=1
tw(Dv.Divider,.5,{BackgroundTransparency=.85})
function V:Set(x)Dv.Visible=x end
return V
end

function Tab:CreateLabel(LabelText,Icon,Color,IgnoreTheme)
local V={}
local L=Elements.Template.Label:Clone()
L.Visible=true L.Parent=TabPage L.ClipsDescendants=true
L.BackgroundColor3=Color or SelectedTheme.SecondaryElementBackground
L.UIStroke.Color=Color or SelectedTheme.SecondaryElementStroke
local T=L.Title
T.TextWrapped=true T.TextTruncate=Enum.TextTruncate.None T.TextXAlignment=Enum.TextXAlignment.Left T.TextYAlignment=Enum.TextYAlignment.Top
T.AnchorPoint=Vector2.zero T.AutomaticSize=Enum.AutomaticSize.None
local cText,cIcon,cColor=tostring(LabelText or""),Icon,Color
local function resolveIcon(i)
if i then
if typeof(i)=="string"and Icons then setIcon(L.Icon,i)else L.Icon.Image=getAssetUri(i)end
L.Icon.ImageRectOffset=typeof(i)=="string"and Icons and L.Icon.ImageRectOffset or Vector2.zero
L.Icon.ImageRectSize=typeof(i)=="string"and Icons and L.Icon.ImageRectSize or Vector2.zero
else L.Icon.Image="rbxassetid://0"L.Icon.ImageRectOffset=Vector2.zero L.Icon.ImageRectSize=Vector2.zero end
end
local function update()
local iv=cIcon~=nil and L:FindFirstChild("Icon")~=nil
local lp,rp=iv and 45 or 12,12
local cw=math.max(80,L.AbsoluteSize.X-lp-rp)
if cw<=80 then cw=math.max(120,TabPage.AbsoluteSize.X-lp-rp-8)end
T.Text=cText T.Position=UDim2.new(0,lp,0,10)
if iv then resolveIcon(cIcon)L.Icon.Visible=true else resolveIcon(nil)L.Icon.Visible=false end
local th=math.max(14,TextService:GetTextSize(cText,T.TextSize,T.Font,Vector2.new(cw,10000)).Y)
local bs=Elements.Template.Button.Size
L.Size=UDim2.new(bs.X.Scale,bs.X.Offset,0,math.max(43,th+22))
T.Size=UDim2.new(1,-(lp+rp),0,th)
L.Name=cText~=""and cText or"Label"
end
update()
L.Icon.ImageTransparency=1 L.BackgroundTransparency=1 L.UIStroke.Transparency=1 T.TextTransparency=1
tw(L,.7,{BackgroundTransparency=cColor and .8 or 0})tw(L.UIStroke,.7,{Transparency=cColor and .7 or 0})
tw(L.Icon,.7,{ImageTransparency=.2})tw(T,.7,{TextTransparency=cColor and .2 or 0})
task.defer(update)
TabPage:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)
function V:Set(nl,ni,nc)
cText=tostring(nl or cText or"")
if ni~=nil then cIcon=ni end
if nc~=nil then cColor=nc L.BackgroundColor3=nc or SelectedTheme.SecondaryElementBackground L.UIStroke.Color=nc or SelectedTheme.SecondaryElementStroke end
update()
end
themeChanged(function()
L.BackgroundColor3=IgnoreTheme and(cColor or L.BackgroundColor3)or SelectedTheme.SecondaryElementBackground
L.UIStroke.Color=IgnoreTheme and(cColor or L.BackgroundColor3)or SelectedTheme.SecondaryElementStroke
end)
return V
end

function Tab:CreateParagraph(PS)
local V={}
PS=PS or{}
local P=Elements.Template.Paragraph:Clone()
P.Visible=true P.Parent=TabPage P.ClipsDescendants=true P.BackgroundTransparency=1 P.UIStroke.Transparency=1
P.BackgroundColor3=SelectedTheme.SecondaryElementBackground P.UIStroke.Color=SelectedTheme.SecondaryElementStroke
local function ensure(n)
local l=P:FindFirstChild(n)
if not l or not l:IsA("TextLabel")then if l then l:Destroy()end l=Instance.new("TextLabel")l.Name=n l.Parent=P end
l.BackgroundTransparency=1 l.TextXAlignment=Enum.TextXAlignment.Left l.TextYAlignment=Enum.TextYAlignment.Top
l.ZIndex=math.max(P.ZIndex+1,l.ZIndex)
return l
end
local TL,CL=ensure("Title"),ensure("Content")
TL.TextWrapped=false TL.TextTruncate=Enum.TextTruncate.AtEnd TL.Size=UDim2.new(1,-24,0,18)TL.Position=UDim2.new(0,12,0,10)
CL.TextWrapped=true CL.TextTruncate=Enum.TextTruncate.None CL.Position=UDim2.new(0,12,0,32)CL.Size=UDim2.new(1,-24,0,16)
local function update(d)
d=d or{}
local tt=tostring(d.Title or d.Name or"")
local ct=tostring(d.Content or d.Text or d.Description or"")
local cw=math.max(80,P.AbsoluteSize.X-24)
local tv,cv=tt~="",ct~=""
local top=tv and 32 or 12
local ch=0
TL.Text=tt TL.Visible=tv CL.Text=ct CL.Visible=cv
if cv then ch=math.max(16,TextService:GetTextSize(ct,CL.TextSize,CL.Font,Vector2.new(cw,10000)).Y)end
TL.Position=UDim2.new(0,12,0,10)TL.Size=UDim2.new(1,-24,0,tv and 18 or 0)
CL.Position=UDim2.new(0,12,0,top)CL.Size=UDim2.new(1,-24,0,cv and ch or 0)
local bs=Elements.Template.Button.Size
P.Size=UDim2.new(bs.X.Scale,bs.X.Offset,0,math.max(42,top+ch+10))
P.Name=tt~=""and tt or"Paragraph"
end
update(PS)
TL.TextTransparency=1 CL.TextTransparency=1 TL.TextColor3=SelectedTheme.TextColor CL.TextColor3=SelectedTheme.TextColor
tw(P,.7,{BackgroundTransparency=0})tw(P.UIStroke,.7,{Transparency=0})tw(TL,.7,{TextTransparency=0})tw(CL,.7,{TextTransparency=0})
task.defer(function()update(PS)end)
function V:Set(n)PS=n or PS update(PS)end
themeChanged(function()
P.BackgroundColor3=SelectedTheme.SecondaryElementBackground P.UIStroke.Color=SelectedTheme.SecondaryElementStroke
TL.TextColor3=SelectedTheme.TextColor CL.TextColor3=SelectedTheme.TextColor
end)
return V
end

function Tab:CreateMarkdown(MS)
local V={}
MS=type(MS)=="string"and{Content=MS}or MS or{}
local M=Elements.Template.Paragraph:Clone()
M.Visible=true M.Parent=TabPage M.ClipsDescendants=true M.BackgroundTransparency=1 M.UIStroke.Transparency=1
M.BackgroundColor3=SelectedTheme.SecondaryElementBackground M.UIStroke.Color=SelectedTheme.SecondaryElementStroke
M.Name=tostring(MS.Title or MS.Name or"Markdown")
for _,c in ipairs(M:GetChildren())do if not c:IsA("UIStroke")and not c:IsA("UICorner")then c:Destroy()end end
local Holder=Instance.new("Frame")
Holder.Name="MarkdownHolder"Holder.BackgroundTransparency=1 Holder.Parent=M
Holder.Position=UDim2.new(0,12,0,10)Holder.Size=UDim2.new(1,-24,0,0)
local HL=Instance.new("UIListLayout")
HL.Padding=UDim.new(0,6)HL.FillDirection=Enum.FillDirection.Vertical HL.HorizontalAlignment=Enum.HorizontalAlignment.Left HL.SortOrder=Enum.SortOrder.LayoutOrder HL.Parent=Holder
local function hexOf(c)return string.format("#%02X%02X%02X",math.floor(c.R*255+.5),math.floor(c.G*255+.5),math.floor(c.B*255+.5))end
local function blend(a,b,t)return Color3.new(a.R+(b.R-a.R)*t,a.G+(b.G-a.G)*t,a.B+(b.B-a.B)*t)end
local function esc(t)t=tostring(t or"")t=t:gsub("&","&amp;")t=t:gsub("<","&lt;")t=t:gsub(">","&gt;")return t end
local function measure(t,sz,f,w)return TextService:GetTextSize(tostring(t or""),sz,f,Vector2.new(math.max(40,w or 40),100000))end
local function inline(t)
local ah=hexOf(SelectedTheme.TabTextColor or SelectedTheme.TextColor)
local ch=hexOf(blend(SelectedTheme.TextColor,Color3.fromRGB(140,180,255),.35))
local r=esc(t)
r=r:gsub("%[([^%]]+)%]%(([^%)]+)%)",'<u><font color="'..ah..'">%1</font></u>')
r=r:gsub("%*%*([^%*][^%*]-)%*%*","<b>%1</b>")
r=r:gsub("__([^_][^_]-)__","<b>%1</b>")
r=r:gsub("~~([^~][^~]-)~~","<s>%1</s>")
r=r:gsub("`([^`\n]+)`",'<font color="'..ch..'"><b>%1</b></font>')
r=r:gsub("%*([^%*\n]+)%*","<i>%1</i>")
r=r:gsub("_([^_\n]+)_","<i>%1</i>")
return r
end
local function clearBlocks()for _,c in ipairs(Holder:GetChildren())do if c~=HL then c:Destroy()end end end
local function updateSize()
local bs=Elements.Template.Button.Size
local h=HL.AbsoluteContentSize.Y
Holder.Size=UDim2.new(1,-24,0,h)
M.Size=UDim2.new(bs.X.Scale,bs.X.Offset,0,math.max(42,h+20))
end
HL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
local lastW=0
local function getW()
local w=M.AbsoluteSize.X
if w<=0 then local bs=Elements.Template.Button.Size w=bs.X.Offset>0 and bs.X.Offset or 420 end
return math.max(140,w-24)
end
local function textBlock(name,text,size,font,height,rich,color)
local l=Instance.new("TextLabel")
l.Name=name l.BackgroundTransparency=1 l.BorderSizePixel=0 l.RichText=rich or false l.TextWrapped=true
l.TextXAlignment=Enum.TextXAlignment.Left l.TextYAlignment=Enum.TextYAlignment.Top
l.Text=text l.TextSize=size l.Font=font l.TextColor3=color or SelectedTheme.TextColor l.Size=UDim2.new(1,0,0,height)l.Parent=Holder
return l
end
local function render(cs)
cs=cs or MS or{}
clearBlocks()
M.Name=tostring(cs.Title or cs.Name or"Markdown")
local md=tostring(cs.Content or cs.Markdown or cs.Text or"")
local cw=getW()
lastW=cw
local ht=tostring(cs.Title or"")
if ht~=""then textBlock("MarkdownTitle",esc(ht),16,Enum.Font.GothamBold,math.max(18,measure(ht,16,Enum.Font.GothamBold,cw).Y),true)end
local para,code,inCode,lang={},{},false,""
local function flushPara()
if #para==0 then return end
local t=table.concat(para,"\n")
textBlock("ParagraphBlock",inline(t),13,Enum.Font.Gotham,math.max(16,measure(t,13,Enum.Font.Gotham,cw).Y),true)
table.clear(para)
end
local function spacer(h)local s=Instance.new("Frame")s.Name="Spacer"s.BackgroundTransparency=1 s.BorderSizePixel=0 s.Size=UDim2.new(1,0,0,h or 4)s.Parent=Holder end
local function flushCode()
if #code==0 then lang=""return end
local raw=table.concat(code,"\n")
local F=Instance.new("Frame")
F.Name="CodeBlock"F.BackgroundColor3=blend(SelectedTheme.SecondaryElementBackground,Color3.fromRGB(40,40,45),.35)F.BorderSizePixel=0 F.Size=UDim2.new(1,0,0,0)F.Parent=Holder
local c=Instance.new("UICorner")c.CornerRadius=UDim.new(0,8)c.Parent=F
local st=Instance.new("UIStroke")st.ApplyStrokeMode=Enum.ApplyStrokeMode.Border st.Color=blend(SelectedTheme.SecondaryElementStroke,SelectedTheme.TextColor,.15)st.Transparency=.15 st.Parent=F
local padX,top=10,34
local codeW=math.max(80,cw-padX*2)
local hc=blend(SelectedTheme.TextColor,Color3.fromRGB(160,190,255),.35)
local H=Instance.new("Frame")
H.Name="Header"H.BackgroundTransparency=1 H.BorderSizePixel=0 H.Size=UDim2.new(1,-padX*2,0,24)H.Position=UDim2.new(0,padX,0,6)H.Parent=F
local LL=Instance.new("TextLabel")
LL.Name="Language"LL.BackgroundTransparency=1 LL.BorderSizePixel=0 LL.TextXAlignment=Enum.TextXAlignment.Left LL.TextYAlignment=Enum.TextYAlignment.Center
LL.Font=Enum.Font.GothamBold LL.TextSize=11 LL.TextColor3=hc LL.Text=lang~=""and string.upper(lang)or"CODE"LL.Size=UDim2.new(1,-30,1,0)LL.Parent=H
local CB=Instance.new("ImageButton")
CB.Name="CopyButton"CB.AutoButtonColor=false CB.BackgroundColor3=blend(SelectedTheme.SecondaryElementBackground,SelectedTheme.SecondaryElementStroke,.18)CB.BorderSizePixel=0
CB.AnchorPoint=Vector2.new(1,0)CB.Position=UDim2.new(1,0,0,1)CB.Size=UDim2.new(0,20,0,20)CB.Image="rbxassetid://83983589022863"CB.ImageColor3=hc CB.ImageTransparency=.08 CB.Parent=H
local cc=Instance.new("UICorner")cc.CornerRadius=UDim.new(0,6)cc.Parent=CB
local cs2=Instance.new("UIStroke")cs2.ApplyStrokeMode=Enum.ApplyStrokeMode.Border cs2.Color=blend(SelectedTheme.SecondaryElementStroke,SelectedTheme.TextColor,.12)cs2.Transparency=.25 cs2.Parent=CB
local function vis(copied)
if copied then
tw(CB,.18,{BackgroundColor3=blend(SelectedTheme.TabTextColor or SelectedTheme.TextColor,SelectedTheme.SecondaryElementBackground,.55),ImageColor3=Color3.new(1,1,1)})tw(cs2,.18,{Transparency=.05})
else
tw(CB,.18,{BackgroundColor3=blend(SelectedTheme.SecondaryElementBackground,SelectedTheme.SecondaryElementStroke,.18),ImageColor3=hc})tw(cs2,.18,{Transparency=.25})
end
end
CB.MouseEnter:Connect(function()tw(CB,.18,{BackgroundColor3=blend(SelectedTheme.SecondaryElementBackground,SelectedTheme.SecondaryElementStroke,.3)})tw(cs2,.18,{Transparency=.12})end)
CB.MouseLeave:Connect(function()vis(false)end)
CB.MouseButton1Click:Connect(function()
local fn=setclipboard or toclipboard or(Clipboard and Clipboard.set)
if fn then pcall(fn,raw)vis(true)task.delay(.8,function()if CB and CB.Parent then vis(false)end end)end
end)
local CL=Instance.new("TextLabel")
CL.Name="Code"CL.BackgroundTransparency=1 CL.BorderSizePixel=0 CL.RichText=false CL.TextWrapped=true
CL.TextXAlignment=Enum.TextXAlignment.Left CL.TextYAlignment=Enum.TextYAlignment.Top CL.Font=Enum.Font.Code CL.TextSize=13
CL.TextColor3=blend(SelectedTheme.TextColor,Color3.fromRGB(190,210,255),.18)CL.Text=raw
local chh=math.max(18,measure(raw,13,Enum.Font.Code,codeW).Y)
CL.Size=UDim2.new(1,-padX*2,0,chh)CL.Position=UDim2.new(0,padX,0,top)CL.Parent=F
F.Size=UDim2.new(1,0,0,top+chh+10)
table.clear(code)lang=""
end
for _,line in ipairs(string.split(md,"\n"))do
local fl=line:match("^```%s*([%w_-]*)%s*$")
if fl~=nil then
if inCode then flushCode()inCode=false else flushPara()inCode=true lang=fl or""end
elseif inCode then table.insert(code,line)
elseif line:match("^%s*$")then flushPara()spacer(2)
else
local hh,ht2=line:match("^(%s*#+)%s+(.+)$")
local q=line:match("^%s*>%s+(.+)$")
local bt=line:match("^%s*[-%*+]%s+(.+)$")
local oi,ot=line:match("^%s*(%d+)%.%s+(.+)$")
local dv=line:match("^%s*[-*_][-*_][-*_]+%s*$")
if hh and ht2 then
flushPara()
local lv=math.clamp(#hh:gsub("%s",""),1,6)
local sz=({24,20,17,15,14,13})[lv]or 13
textBlock("Heading"..lv,inline(ht2),sz,Enum.Font.GothamBold,math.max(sz,measure(ht2,sz,Enum.Font.GothamBold,cw).Y),true)
elseif q then
flushPara()
local QF=Instance.new("Frame")QF.Name="QuoteBlock"QF.BackgroundTransparency=1 QF.BorderSizePixel=0 QF.Size=UDim2.new(1,0,0,0)QF.Parent=Holder
local bar=Instance.new("Frame")bar.Name="Bar"bar.BorderSizePixel=0 bar.BackgroundColor3=blend(SelectedTheme.TabTextColor or SelectedTheme.TextColor,SelectedTheme.SecondaryElementStroke,.35)bar.Size=UDim2.new(0,3,1,0)bar.Parent=QF
local ql=Instance.new("TextLabel")
ql.Name="QuoteText"ql.BackgroundTransparency=1 ql.BorderSizePixel=0 ql.RichText=true ql.TextWrapped=true ql.TextXAlignment=Enum.TextXAlignment.Left ql.TextYAlignment=Enum.TextYAlignment.Top
ql.Font=Enum.Font.Gotham ql.TextSize=13 ql.TextColor3=blend(SelectedTheme.TextColor,SelectedTheme.SecondaryElementStroke,.15)ql.Text=inline(q)
local qh=math.max(16,measure(q,13,Enum.Font.Gotham,math.max(80,cw-14)).Y)
ql.Size=UDim2.new(1,-10,0,qh)ql.Position=UDim2.new(0,10,0,0)ql.Parent=QF
QF.Size=UDim2.new(1,0,0,qh)
elseif bt or ot then
flushPara()
local body=bt or ot or""
local IF=Instance.new("Frame")IF.Name="ListItem"IF.BackgroundTransparency=1 IF.BorderSizePixel=0 IF.Size=UDim2.new(1,0,0,0)IF.Parent=Holder
local mk=Instance.new("TextLabel")
mk.Name="Marker"mk.BackgroundTransparency=1 mk.BorderSizePixel=0 mk.TextXAlignment=Enum.TextXAlignment.Left mk.TextYAlignment=Enum.TextYAlignment.Top
mk.Font=Enum.Font.GothamBold mk.TextSize=13 mk.TextColor3=SelectedTheme.TabTextColor or SelectedTheme.TextColor mk.Text=bt and"•"or(tostring(oi)..".")mk.Size=UDim2.new(0,16,0,16)mk.Parent=IF
local il=Instance.new("TextLabel")
il.Name="ItemText"il.BackgroundTransparency=1 il.BorderSizePixel=0 il.RichText=true il.TextWrapped=true il.TextXAlignment=Enum.TextXAlignment.Left il.TextYAlignment=Enum.TextYAlignment.Top
il.Font=Enum.Font.Gotham il.TextSize=13 il.TextColor3=SelectedTheme.TextColor il.Text=inline(body)
local ih=math.max(16,measure(body,13,Enum.Font.Gotham,math.max(80,cw-18)).Y)
il.Size=UDim2.new(1,-18,0,ih)il.Position=UDim2.new(0,18,0,0)il.Parent=IF
IF.Size=UDim2.new(1,0,0,ih)
elseif dv then
flushPara()
local d=Instance.new("Frame")d.Name="MarkdownDivider"d.BorderSizePixel=0 d.BackgroundColor3=blend(SelectedTheme.SecondaryElementStroke,SelectedTheme.TextColor,.08)d.Size=UDim2.new(1,0,0,1)d.Parent=Holder
else table.insert(para,line)end
end
end
flushPara()
if inCode then flushCode()end
updateSize()
end
updateSize()
render(MS)
tw(M,.7,{BackgroundTransparency=0})tw(M.UIStroke,.7,{Transparency=0})
task.defer(function()render(MS)end)
M:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
if math.abs(getW()-lastW)>=4 then task.defer(function()render(MS)end)end
end)
function V:Set(n)MS=type(n)=="string"and{Content=n}or n or MS render(MS)end
themeChanged(function()
M.BackgroundColor3=SelectedTheme.SecondaryElementBackground M.UIStroke.Color=SelectedTheme.SecondaryElementStroke render(MS)
end)
return V
end

function Tab:CreateInput(S)
local I=Elements.Template.Input:Clone()
I.Name=S.Name I.Title.Text=S.Name I.Visible=true I.Parent=TabPage
local box=I.InputFrame.InputBox
box.Text=S.CurrentValue or""
I.InputFrame.BackgroundColor3=SelectedTheme.InputBackground I.InputFrame.UIStroke.Color=SelectedTheme.InputStroke
fadeIn(I)
box.PlaceholderText=S.PlaceholderText or"nil"
I.InputFrame.Size=UDim2.new(0,box.TextBounds.X+24,0,30)
box.FocusLost:Connect(function()
local ok,resp=pcall(function()S.Callback(box.Text)S.CurrentValue=box.Text end)
if not ok then flashError(I,S.Name,resp)end
if S.RemoveTextAfterFocusLost then box.Text=""end
if not S.Ext then SaveConfiguration()end
end)
hoverBG(I)
box:GetPropertyChangedSignal("Text"):Connect(function()tw(I.InputFrame,.55,{Size=UDim2.new(0,box.TextBounds.X+24,0,30)})end)
function S:Set(t)box.Text=t S.CurrentValue=t pcall(function()S.Callback(t)end)if not S.Ext then SaveConfiguration()end end
regFlag(S)
themeChanged(function()I.InputFrame.BackgroundColor3=SelectedTheme.InputBackground I.InputFrame.UIStroke.Color=SelectedTheme.InputStroke end)
return S
end

function Tab:CreateDropdown(S)
local Dd=Elements.Template.Dropdown:Clone()
Dd.Name=string.find(S.Name,"closed")and"Dropdown"or S.Name
Dd.Title.Text=S.Name Dd.Visible=true Dd.Parent=TabPage Dd.List.Visible=false
if S.CurrentOption then
if type(S.CurrentOption)=="string"then S.CurrentOption={S.CurrentOption}end
if not S.MultipleOptions and type(S.CurrentOption)=="table"then S.CurrentOption={S.CurrentOption[1]}end
else S.CurrentOption={}end
local function label()
if S.MultipleOptions then
local n=#S.CurrentOption
Dd.Selected.Text=n==1 and S.CurrentOption[1]or(n==0 and"None"or"Various")
else Dd.Selected.Text=S.CurrentOption[1]or"None"end
end
label()
Dd.Toggle.ImageColor3=SelectedTheme.TextColor
tw(Dd,.4,{BackgroundColor3=SelectedTheme.ElementBackground})
Dd.Size=UDim2.new(1,-10,0,45)
fadeIn(Dd)
for _,o in ipairs(Dd.List:GetChildren())do if o.ClassName=="Frame"and o.Name~="Placeholder"then o:Destroy()end end
Dd.Toggle.Rotation=180
local function eachOpt(f)for _,o in ipairs(Dd.List:GetChildren())do if o.ClassName=="Frame"and o.Name~="Placeholder"then f(o)end end end
local function closeList()
tw(Dd,.5,{Size=UDim2.new(1,-10,0,45)})
eachOpt(function(o)tw(o,.3,{BackgroundTransparency=1})tw(o.UIStroke,.3,{Transparency=1})tw(o.Title,.3,{TextTransparency=1})end)
tw(Dd.List,.3,{ScrollBarImageTransparency=1})tw(Dd.Toggle,.7,{Rotation=180})
end
Dd.Interact.MouseButton1Click:Connect(function()
tw(Dd,.4,{BackgroundColor3=SelectedTheme.ElementBackgroundHover})tw(Dd.UIStroke,.4,{Transparency=1})
task.wait(.1)
tw(Dd,.4,{BackgroundColor3=SelectedTheme.ElementBackground})tw(Dd.UIStroke,.4,{Transparency=0})
if Debounce then return end
if Dd.List.Visible then
Debounce=true closeList()
task.wait(.35)
Dd.List.Visible=false Debounce=false
else
tw(Dd,.5,{Size=UDim2.new(1,-10,0,180)})
Dd.List.Visible=true
tw(Dd.List,.3,{ScrollBarImageTransparency=.7})tw(Dd.Toggle,.7,{Rotation=0})
eachOpt(function(o)
if o.Name~=Dd.Selected.Text then tw(o.UIStroke,.3,{Transparency=0})end
tw(o,.3,{BackgroundTransparency=0})tw(o.Title,.3,{TextTransparency=0})
end)
end
end)
Dd.MouseEnter:Connect(function()if not Dd.List.Visible then tw(Dd,.6,{BackgroundColor3=SelectedTheme.ElementBackgroundHover})end end)
Dd.MouseLeave:Connect(function()tw(Dd,.6,{BackgroundColor3=SelectedTheme.ElementBackground})end)
local function SetOptions()
for _,Option in ipairs(S.Options)do
local O=Elements.Template.Dropdown.List.Template:Clone()
O.Name=Option O.Title.Text=Option O.Parent=Dd.List O.Visible=true
O.BackgroundTransparency=1 O.UIStroke.Transparency=1 O.Title.TextTransparency=1
O.Interact.ZIndex=50
O.Interact.MouseButton1Click:Connect(function()
local idx=table.find(S.CurrentOption,Option)
if not S.MultipleOptions and idx then return end
if idx then table.remove(S.CurrentOption,idx)label()
else
if not S.MultipleOptions then table.clear(S.CurrentOption)end
table.insert(S.CurrentOption,Option)label()
tw(O.UIStroke,.3,{Transparency=1})tw(O,.3,{BackgroundColor3=SelectedTheme.DropdownSelected})
Debounce=true
end
local ok,resp=pcall(function()S.Callback(S.CurrentOption)end)
if not ok then flashError(Dd,S.Name,resp)end
eachOpt(function(d)if not table.find(S.CurrentOption,d.Name)then tw(d,.3,{BackgroundColor3=SelectedTheme.DropdownUnselected})end end)
if not S.MultipleOptions then
task.wait(.1)
closeList()
task.wait(.35)
Dd.List.Visible=false
end
Debounce=false
if not S.Ext then SaveConfiguration()end
end)
themeChanged(function()O.UIStroke.Color=SelectedTheme.ElementStroke end)
end
end
SetOptions()
local function paintOpts()
eachOpt(function(d)d.BackgroundColor3=table.find(S.CurrentOption,d.Name)and SelectedTheme.DropdownSelected or SelectedTheme.DropdownUnselected end)
end
paintOpts()
themeChanged(paintOpts)
function S:Set(n)
S.CurrentOption=n
if typeof(S.CurrentOption)=="string"then S.CurrentOption={S.CurrentOption}end
if not S.MultipleOptions then S.CurrentOption={S.CurrentOption[1]}end
label()
local ok,resp=pcall(function()S.Callback(n)end)
if not ok then flashError(Dd,S.Name,resp)end
paintOpts()
end
function S:Refresh(opts)
S.Options=opts
eachOpt(function(o)o:Destroy()end)
SetOptions()
end
regFlag(S)
themeChanged(function()Dd.Toggle.ImageColor3=SelectedTheme.TextColor tw(Dd,.4,{BackgroundColor3=SelectedTheme.ElementBackground})end)
return S
end

function Tab:CreateKeybind(S)
local checking=false
local Kb=Elements.Template.Keybind:Clone()
Kb.Name=S.Name Kb.Title.Text=S.Name Kb.Visible=true Kb.Parent=TabPage
Kb.KeybindFrame.BackgroundColor3=SelectedTheme.InputBackground Kb.KeybindFrame.UIStroke.Color=SelectedTheme.InputStroke
fadeIn(Kb)
local box=Kb.KeybindFrame.KeybindBox
box.Text=S.CurrentKeybind
Kb.KeybindFrame.Size=UDim2.new(0,box.TextBounds.X+24,0,30)
box.Focused:Connect(function()checking=true box.Text=""end)
box.FocusLost:Connect(function()
checking=false
if box.Text==nil or box.Text==""then box.Text=S.CurrentKeybind if not S.Ext then SaveConfiguration()end end
end)
hoverBG(Kb)
UserInputService.InputBegan:Connect(function(input,processed)
if checking then
if input.KeyCode~=Enum.KeyCode.Unknown then
local k=tostring(string.split(tostring(input.KeyCode),".")[3])
box.Text=k S.CurrentKeybind=k box:ReleaseFocus()
if not S.Ext then SaveConfiguration()end
if S.CallOnChange then S.Callback(k)end
end
elseif not S.CallOnChange and S.CurrentKeybind~=nil and(input.KeyCode==Enum.KeyCode[S.CurrentKeybind]and not processed)then
local Held=true
local conn
conn=input.Changed:Connect(function(p)if p=="UserInputState"then conn:Disconnect()Held=false end end)
if not S.HoldToInteract then
local ok,resp=pcall(S.Callback)
if not ok then flashError(Kb,S.Name,resp)end
else
task.wait(.25)
if Held then
local Loop
Loop=RunService.Stepped:Connect(function()
if not Held then S.Callback(false)Loop:Disconnect()else S.Callback(true)end
end)
end
end
end
end)
box:GetPropertyChangedSignal("Text"):Connect(function()tw(Kb.KeybindFrame,.55,{Size=UDim2.new(0,box.TextBounds.X+24,0,30)})end)
function S:Set(k)
box.Text=tostring(k)S.CurrentKeybind=tostring(k)box:ReleaseFocus()
if not S.Ext then SaveConfiguration()end
if S.CallOnChange then S.Callback(tostring(k))end
end
regFlag(S)
themeChanged(function()Kb.KeybindFrame.BackgroundColor3=SelectedTheme.InputBackground Kb.KeybindFrame.UIStroke.Color=SelectedTheme.InputStroke end)
return S
end

function Tab:CreateToggle(S)
local Tg=Elements.Template.Toggle:Clone()
Tg.Name=S.Name Tg.Title.Text=S.Name Tg.Visible=true Tg.Parent=TabPage
Tg.Switch.BackgroundColor3=SelectedTheme.ToggleBackground
if SelectedTheme~=Themes.Default then Tg.Switch.Shadow.Visible=false end
fadeIn(Tg)
local Ind=Tg.Switch.Indicator
local function snap(on)
Ind.Position=UDim2.new(1,on and-20 or-40,.5,0)
Ind.UIStroke.Color=on and SelectedTheme.ToggleEnabledStroke or SelectedTheme.ToggleDisabledStroke
Ind.BackgroundColor3=on and SelectedTheme.ToggleEnabled or SelectedTheme.ToggleDisabled
Tg.Switch.UIStroke.Color=on and SelectedTheme.ToggleEnabledOuterStroke or SelectedTheme.ToggleDisabledOuterStroke
end
snap(S.CurrentValue==true)
hoverBG(Tg)
local function animate(on,resize)
local Q,O=Enum.EasingStyle.Quart,Enum.EasingDirection.Out
tw(Tg,.6,{BackgroundColor3=SelectedTheme.ElementBackgroundHover})tw(Tg.UIStroke,.6,{Transparency=1})
tw(Ind,on and .5 or .45,{Position=UDim2.new(1,on and-20 or-40,.5,0)},Q,O)
if resize then tw(Ind,.4,{Size=UDim2.new(0,12,0,12)},Q,O)end
tw(Ind.UIStroke,.55,{Color=on and SelectedTheme.ToggleEnabledStroke or SelectedTheme.ToggleDisabledStroke},EXP,O)
tw(Ind,.8,{BackgroundColor3=on and SelectedTheme.ToggleEnabled or SelectedTheme.ToggleDisabled},EXP,O)
tw(Tg.Switch.UIStroke,.55,{Color=on and SelectedTheme.ToggleEnabledOuterStroke or SelectedTheme.ToggleDisabledOuterStroke},EXP,O)
if resize then tw(Ind,.45,{Size=UDim2.new(0,17,0,17)},Q,O)end
tw(Tg,.6,{BackgroundColor3=SelectedTheme.ElementBackground})tw(Tg.UIStroke,.6,{Transparency=0})
end
local function fire()
local ok,resp=pcall(function()S.Callback(S.CurrentValue)end)
if not ok then flashError(Tg,S.Name,resp)end
if not S.Ext then SaveConfiguration()end
end
Tg.Interact.MouseButton1Click:Connect(function()
S.CurrentValue=not S.CurrentValue
animate(S.CurrentValue,false)fire()
end)
function S:Set(v)S.CurrentValue=v==true animate(S.CurrentValue,true)fire()end
if not S.Ext then regFlag(S)end
themeChanged(function()
Tg.Switch.BackgroundColor3=SelectedTheme.ToggleBackground
if SelectedTheme~=Themes.Default then Tg.Switch.Shadow.Visible=false end
task.wait()
snap(S.CurrentValue and true or false)
Ind.Position=UDim2.new(1,S.CurrentValue and-20 or-40,.5,0)
end)
return S
end

function Tab:CreateSlider(S)
local drag=false
local Sl=Elements.Template.Slider:Clone()
Sl.Name=S.Name Sl.Title.Text=S.Name Sl.Visible=true Sl.Parent=TabPage
if SelectedTheme~=Themes.Default then Sl.Main.Shadow.Visible=false end
local function colors()
Sl.Main.BackgroundColor3=SelectedTheme.SliderBackground Sl.Main.UIStroke.Color=SelectedTheme.SliderStroke
Sl.Main.Progress.UIStroke.Color=SelectedTheme.SliderStroke Sl.Main.Progress.BackgroundColor3=SelectedTheme.SliderProgress
end
colors()
fadeIn(Sl)
local R=S.Range
local function barSize(val)
local w=Sl.Main.AbsoluteSize.X
return UDim2.new(0,w*((val+R[1])/(R[2]-R[1]))>5 and w*(val/(R[2]-R[1]))or 5,1,0)
end
Sl.Main.Progress.Size=barSize(S.CurrentValue)
local function info(v)Sl.Main.Information.Text=S.Suffix and(tostring(v).." "..S.Suffix)or tostring(v)end
info(S.CurrentValue)
hoverBG(Sl)
Sl.Main.Interact.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
tw(Sl.Main.UIStroke,.6,{Transparency=1})tw(Sl.Main.Progress.UIStroke,.6,{Transparency=1})drag=true
end
end)
Sl.Main.Interact.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
tw(Sl.Main.UIStroke,.6,{Transparency=.4})tw(Sl.Main.Progress.UIStroke,.6,{Transparency=.3})drag=false
end
end)
Sl.Main.Interact.MouseButton1Down:Connect(function(X)
local Current=Sl.Main.Progress.AbsolutePosition.X+Sl.Main.Progress.AbsoluteSize.X
local Start,Location=Current,X
local Loop
Loop=RunService.Stepped:Connect(function()
if drag then
local ax,aw=Sl.Main.AbsolutePosition.X,Sl.Main.AbsoluteSize.X
Location=UserInputService:GetMouseLocation().X
Current=Current+0.025*(Location-Start)
if Location<ax then Location=ax elseif Location>ax+aw then Location=ax+aw end
if Current<ax+5 then Current=ax+5 elseif Current>ax+aw then Current=ax+aw end
if Current<=Location and(Location-Start)<0 then Start=Location elseif Current>=Location and(Location-Start)>0 then Start=Location end
tw(Sl.Main.Progress,.45,{Size=UDim2.new(0,Current-ax,1,0)})
local nv=R[1]+(Location-ax)/aw*(R[2]-R[1])
nv=math.floor(nv/S.Increment+.5)*(S.Increment*10000000)/10000000
nv=math.clamp(nv,R[1],R[2])
info(nv)
if S.CurrentValue~=nv then
local ok,resp=pcall(function()S.Callback(nv)end)
if not ok then flashError(Sl,S.Name,resp)end
S.CurrentValue=nv
if not S.Ext then SaveConfiguration()end
end
else
tw(Sl.Main.Progress,.3,{Size=UDim2.new(0,Location-Sl.Main.AbsolutePosition.X>5 and Location-Sl.Main.AbsolutePosition.X or 5,1,0)})
Loop:Disconnect()
end
end)
end)
function S:Set(nv)
nv=math.clamp(nv,R[1],R[2])
tw(Sl.Main.Progress,.45,{Size=barSize(nv)})
Sl.Main.Information.Text=tostring(nv).." "..(S.Suffix or"")
local ok,resp=pcall(function()S.Callback(nv)end)
if not ok then flashError(Sl,S.Name,resp)end
S.CurrentValue=nv
if not S.Ext then SaveConfiguration()end
end
regFlag(S)
themeChanged(function()
if SelectedTheme~=Themes.Default then Sl.Main.Shadow.Visible=false end
colors()
end)
return S
end

themeChanged(function()
TabButton.UIStroke.Color=SelectedTheme.TabStroke
paint(Elements.UIPageLayout.CurrentPage==TabPage)
end)
return Tab
end

Elements.Visible=true
task.wait(1.1)
tw(Main,.7,{Size=UDim2.new(0,390,0,90)},EXP,Enum.EasingDirection.InOut)
task.wait(.3)
tw(LoadingFrame.Title,.2,{TextTransparency=1})tw(LoadingFrame.Subtitle,.2,{TextTransparency=1})tw(LoadingFrame.Version,.2,{TextTransparency=1})
task.wait(.1)
tw(Main,.6,{Size=useMobileSizing and UDim2.new(0,570,0,275)or UDim2.new(0,570,0,475)})
tw(Main.Shadow.Image,.5,{ImageTransparency=.6})
Topbar.BackgroundTransparency=1 Topbar.Divider.Size=UDim2.new(0,0,0,1)Topbar.Divider.BackgroundColor3=SelectedTheme.ElementStroke
Topbar.CornerRepair.BackgroundTransparency=1 Topbar.Title.TextTransparency=1 Topbar.Search.ImageTransparency=1
Topbar.ChangeSize.ImageTransparency=1 Topbar.Hide.ImageTransparency=1
task.wait(.5)
Topbar.Visible=true
tw(Topbar,.7,{BackgroundTransparency=0})tw(Topbar.CornerRepair,.7,{BackgroundTransparency=0})
task.wait(.1)
tw(Topbar.Divider,1,{Size=UDim2.new(1,0,0,1)})tw(Topbar.Title,.6,{TextTransparency=0})
task.wait(.05)
tw(Topbar.Search,.6,{ImageTransparency=.8})
task.wait(.05)
tw(Topbar.ChangeSize,.6,{ImageTransparency=.8})
task.wait(.05)
tw(Topbar.Hide,.6,{ImageTransparency=.8})
task.wait(.3)
if dragBar then tw(dragBarCosmetic,.6,{BackgroundTransparency=.7})end
function Window.ModifyTheme(NewTheme)
if not pcall(ChangeTheme,NewTheme)then
RayfieldLibrary:Notify({Title="Unable to Change Theme",Content="We are unable find a theme on file.",Image=4400704299})
else
RayfieldLibrary:Notify({Title="Theme Changed",Content="Successfully changed theme to "..(typeof(NewTheme)=="string"and NewTheme or"Custom Theme").."."  ,Image=4483362748})
end
end
return Window
end

local function setVisibility(vis,notify)
if Debounce then return end
if vis then Hidden=false Unhide()else Hidden=true Hide(notify)end
end
function RayfieldLibrary:SetVisibility(v)setVisibility(v,false)end
function RayfieldLibrary:IsVisible()return not Hidden end
local hideConn
function RayfieldLibrary:Destroy()rayfieldDestroyed=true hideConn:Disconnect()Rayfield:Destroy()end

-- Settings button is removed (no settings tab in this build)
if Topbar:FindFirstChild("Settings")then Topbar.Settings:Destroy()end
Topbar.Search.Position=UDim2.new(1,-75,.5,0)

Topbar.ChangeSize.MouseButton1Click:Connect(function()
if Debounce then return end
if Minimised then Minimised=false Maximise()else Minimised=true Minimise()end
end)
Main.Search.Input:GetPropertyChangedSignal("Text"):Connect(function()
local page=Elements.UIPageLayout.CurrentPage
local text=Main.Search.Input.Text
if #text>0 then
if not page:FindFirstChild("SearchTitle-fsefsefesfsefesfesfThanks")then
local st=Elements.Template.SectionTitle:Clone()
st.Parent=page st.Name="SearchTitle-fsefsefesfsefesfesfThanks"st.LayoutOrder=-100
st.Title.Text="Results from '"..page.Name.."'"st.Visible=true
end
else
local st=page:FindFirstChild("SearchTitle-fsefsefesfsefesfesfThanks")
if st then st:Destroy()end
end
for _,e in ipairs(page:GetChildren())do
if e.ClassName~="UIListLayout"and e.Name~="Placeholder"and e.Name~="SearchTitle-fsefsefesfsefesfesfThanks"then
if e.Name=="SectionTitle"then e.Visible=#text==0
else e.Visible=string.lower(e.Name):find(string.lower(text),1,true)~=nil end
end
end
end)
Main.Search.Input.FocusLost:Connect(function()
if #Main.Search.Input.Text==0 and searchOpen then task.wait(.12)closeSearch()end
end)
Topbar.Search.MouseButton1Click:Connect(function()task.spawn(function()if searchOpen then closeSearch()else openSearch()end end)end)
Topbar.Hide.MouseButton1Click:Connect(function()setVisibility(Hidden,not useMobileSizing)end)
hideConn=UserInputService.InputBegan:Connect(function(input,processed)
if input.KeyCode==Enum.KeyCode[ToggleKey]and not processed then
if Debounce then return end
if Hidden then Hidden=false Unhide()else Hidden=true Hide()end
end
end)
if MPrompt then
MPrompt.Interact.MouseButton1Click:Connect(function()
if Debounce then return end
if Hidden then Hidden=false Unhide()end
end)
end
for _,b in ipairs(Topbar:GetChildren())do
if b.ClassName=="ImageButton"and b.Name~="Icon"then
b.MouseEnter:Connect(function()tw(b,.7,{ImageTransparency=0})end)
b.MouseLeave:Connect(function()tw(b,.7,{ImageTransparency=.8})end)
end
end

function RayfieldLibrary:LoadConfiguration()
if CEnabled then
local notified,loaded
local ok,result=pcall(function()
if isfile then
local f=ConfigurationFolder.."/"..CFileName..ConfigurationExtension
if isfile(f)then loaded=LoadConfiguration(readfile(f))end
else
notified=true
RayfieldLibrary:Notify({Title="Rayfield Configurations",Content="We couldn't enable Configuration Saving as you are not using software with filesystem support.",Image=4384402990})
end
end)
if ok and loaded and not notified then
RayfieldLibrary:Notify({Title="Rayfield Configurations",Content="The configuration file for this script has been loaded from a previous session.",Image=4384403532})
elseif not ok and not notified then
warn("Rayfield Configurations Error | "..tostring(result))
RayfieldLibrary:Notify({Title="Rayfield Configurations",Content="We've encountered an issue loading your configuration correctly.\n\nCheck the Developer Console for more information.",Image=4384402990})
end
end
globalLoaded=true
end
task.delay(4,function()RayfieldLibrary.LoadConfiguration()end)

function RayfieldLibrary:GetDropdownValue(t)
if type(t)=="table"then for _,e in ipairs(t)do return tostring(e)end else return tostring(t)end
end

return RayfieldLibrary
