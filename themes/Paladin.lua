---@class BetterBags: AceAddon
local BetterBags = LibStub('AceAddon-3.0'):GetAddon("BetterBags")
assert(BetterBags, "PaladinTheme for Faulkal requires BetterBags")

---@class Themes: AceModule
local themes = BetterBags:GetModule('Themes')

---@class SearchBox: AceModule
local search = BetterBags:GetModule('SearchBox')

---@class Fonts: AceModule
local fonts = BetterBags:GetModule('Fonts')

---@class SimpleDarkDecoration: Frame
---@field title FontString

---@class BagButton: Button
---@field portrait Texture
---@field highlightTex Texture

---@type table<string, SimpleDarkDecoration>
local decoratorFrames = {}

---@type string
local theBorder = 'Interface\\AddOns\\PaladinTheme-for-Faulkal\\textures\\PaladinBorder256.png'
local theBackground = 'Interface\\AddOns\\PaladinTheme-for-Faulkal\\textures\\PaladinBackgroundNew.png'
local theCrest = 'Interface\\AddOns\\PaladinTheme-for-Faulkal\\textures\\PaladinBagButton.png'
local theClose = 'Interface\\AddOns\\PaladinTheme-for-Faulkal\\textures\\PaladinCloseButton.png'
local theFont = 'Interface\\AddOns\\PaladinTheme-for-Faulkal\\fonts\\Paladinfont-Regular.ttf'


fonts.PaladinUI = CreateFont('BetterBagsPaladinUI')
fonts.PaladinUI:SetFont(theFont, 16, "OUTLINE")
fonts.PaladinUI:SetTextColor(1, 1, 1)

fonts.PaladinUITitle = CreateFont('BetterBagsPaladinUITitle')
fonts.PaladinUITitle:SetFont(theFont, 20, "OUTLINE")
fonts.PaladinUITitle:SetTextColor(1, 1, 1)


---@type Theme
local simpleDark = {
  Name = 'Class - Paladin',
  Description = 'A meme Paladin theme.',
  Available = true,
  Portrait = function(frame)
    local decoration = decoratorFrames[frame:GetName()]
    if not decoration then
      -- Backdrop
      decoration = CreateFrame("Frame", frame:GetName().."ThemePaladin", frame, "BackdropTemplate") --[[@as SimpleDarkDecoration]]
      decoration:SetAllPoints()
      decoration:SetFrameLevel(frame:GetFrameLevel() - 1)
      decoration:SetBackdrop({
        bgFile = theBackground,
        insets = {left = -8, right = -8, top = -8, bottom = -8},
        tile = true,
        tileSize = 224*3/4
      })
      decoration:SetBackdropColor(1, 1, 1, 1)

      decoration.Border = decoration:CreateTexture();
      decoration.Border:SetTexture(theBorder)
      decoration.Border:SetTextureSliceMargins(26, 26, 26, 26);
      decoration.Border:SetTextureSliceMode(Enum.UITextureSliceMode.Tiled);
      decoration.Border:SetPoint("TOPLEFT", frame, "TOPLEFT", -22, 22)
      decoration.Border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 22, -22)
      decoration.Border:SetVertexColor(1, 1, 1);

      -- Title text
      local title = decoration:CreateFontString(nil, "OVERLAY")
      title:SetFontObject(fonts.PaladinUITitle)
      title:SetPoint("TOP", decoration, "TOP", 0, 26)
      title:SetHeight(30)
      decoration.title = title

      if themes.titles[frame:GetName()] then
        decoration.title:SetText(themes.titles[frame:GetName()])
      end

      local close = CreateFrame("Button", nil, decoration)
      close:SetSize(32, 32)
      close:SetPushedTexture(theClose)
      close:SetHighlightTexture(theClose)
      close:SetNormalTexture(theClose)
      close:SetPoint("TOPRIGHT", decoration, "TOPRIGHT", 22, 22)
      close:SetScript("OnClick", function()
        frame.Owner:Hide()
      end)

      local searchBox = search:CreateBox(frame.Owner.kind, decoration --[[@as Frame]])
      searchBox.frame:SetPoint("TOPRIGHT", decoration, "TOPRIGHT", -22, -2)
      searchBox.frame:SetSize(150, 20)
      decoration.search = searchBox

      local bagButton = themes.SetupBagButton(frame.Owner, decoration --[[@as Frame]])
      bagButton:SetPoint("TOPLEFT", decoration, "TOPLEFT", -28, 28)
      bagButton.portrait:SetSize(250, 250)
      bagButton.portrait:SetTexCoord(0, 1, 0, 1)
      bagButton.portrait:SetTexture(theCrest)
      bagButton.portrait:SetScale(0.25)
      bagButton.highlightTex:SetSize(250, 250)
      bagButton.highlightTex:SetTexCoord(0, 1, 0, 1)
      bagButton.highlightTex:SetTexture(theCrest)
      bagButton.highlightTex:SetScale(0.25)

      -- Save the decoration frame for reuse.
      decoratorFrames[frame:GetName()] = decoration
    else
      decoration:Show()
    end
  end,
  Simple = function(frame)
    local decoration = decoratorFrames[frame:GetName()]
    if not decoration then
      -- Backdrop
      decoration = CreateFrame("Frame", frame:GetName().."ThemePaladin", frame, "BackdropTemplate") --[[@as SimpleDarkDecoration]]
      decoration:SetAllPoints()
      decoration:SetFrameLevel(frame:GetFrameLevel() - 1)
      decoration:SetBackdrop({
        bgFile = theBackground,
        insets = {left = -8, right = -8, top = -8, bottom = -8},
        tile = true,
        tileSize = 224*3/4
      })
      decoration:SetBackdropColor(1, 1, 1, 1)

      decoration.Border = decoration:CreateTexture();
      decoration.Border:SetTexture(theBorder)
      decoration.Border:SetTextureSliceMargins(26, 26, 26, 26);
      decoration.Border:SetTextureSliceMode(Enum.UITextureSliceMode.Tiled);
      decoration.Border:SetPoint("TOPLEFT", frame, "TOPLEFT", -22, 22)
      decoration.Border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 22, -22)
      decoration.Border:SetVertexColor(1, 1, 1);

      -- Title text
      local title = decoration:CreateFontString(nil, "OVERLAY")
      title:SetFontObject(fonts.PaladinUI)
      title:SetPoint("TOP", decoration, "TOP", 0, 26)
      title:SetHeight(30)
      decoration.title = title

      local close = CreateFrame("Button", nil, decoration)
      close:SetSize(32, 32)
      close:SetPushedTexture(theClose)
      close:SetHighlightTexture(theClose)
      close:SetNormalTexture(theClose)
      close:SetPoint("TOPRIGHT", decoration, "TOPRIGHT", 0, 0)
      close:SetScript("OnClick", function()
        frame:Hide()
      end)

      if themes.titles[frame:GetName()] then
        decoration.title:SetText(themes.titles[frame:GetName()])
      end
      -- Save the decoration frame for reuse.
      decoratorFrames[frame:GetName()] = decoration
    else
      decoration:Show()
    end
  end,
  Flat = function (frame)
    local decoration = decoratorFrames[frame:GetName()]
    if not decoration then
      -- Backdrop
      decoration = CreateFrame("Frame", frame:GetName().."ThemePaladin", frame, "BackdropTemplate") --[[@as SimpleDarkDecoration]]
      decoration:SetAllPoints()
      decoration:SetFrameLevel(frame:GetFrameLevel() - 1)
      decoration:SetBackdrop({
        bgFile = theBackground,
        insets = {left = -8, right = -8, top = -8, bottom = -8},
        tile = true,
        tileSize = 224*3/4
      })
      decoration:SetBackdropColor(1, 1, 1, 1)

      decoration.Border = decoration:CreateTexture();
      decoration.Border:SetTexture(theBorder)
      decoration.Border:SetTextureSliceMargins(26, 26, 26, 26);
      decoration.Border:SetTextureSliceMode(Enum.UITextureSliceMode.Tiled);
      decoration.Border:SetPoint("TOPLEFT", frame, "TOPLEFT", -22, 22)
      decoration.Border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 22, -22)
      decoration.Border:SetVertexColor(1, 1, 1);

      -- Title text
      local title = decoration:CreateFontString(nil, "OVERLAY")
      title:SetFontObject(fonts.PaladinUI)
      title:SetPoint("TOP", decoration, "TOP", 0, 26)
      title:SetHeight(30)
      decoration.title = title

      if themes.titles[frame:GetName()] then
        decoration.title:SetText(themes.titles[frame:GetName()])
      end
      -- Save the decoration frame for reuse.
      decoratorFrames[frame:GetName()] = decoration
    else
      decoration:Show()
    end
  end,
  Opacity = function(frame, alpha)
    local decoration = decoratorFrames[frame:GetName()]
    if decoration then
      decoration:SetAlpha(alpha / 100)
    end
  end,
  SectionFont = function(font)
    font:SetFontObject(fonts.PaladinUI)
  end,
  SetTitle = function(frame, title)
    local decoration = decoratorFrames[frame:GetName()]
    if decoration then
      decoration.title:SetText(title)
    end
  end,
  Reset = function()
    for _, frame in pairs(decoratorFrames) do
      frame:Hide()
    end
  end,
  ToggleSearch = function (frame, shown)
    local decoration = decoratorFrames[frame:GetName()]
    if decoration then
      decoration.search:SetShown(shown)
    end
  end,
  PositionBagSlots = function (frame, bagSlotWindow)
    bagSlotWindow:ClearAllPoints()
    bagSlotWindow:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0)
  end,
  OffsetSidebar = function()
    return -60
  end
}

themes:RegisterTheme('CLassPaladin', simpleDark)
