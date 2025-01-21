WhatCanICraft = {}

WhatCanICraft.showRecipes = function(item, playerIndex)
    ISEntityUI.OpenHandcraftWindow(getSpecificPlayer(playerIndex), nil)

    local handCraftPanel = ISEntityUI.players[playerIndex].windows["HandcraftWindow"].instance.handCraftPanel
    local recipeFilterPanel = handCraftPanel.recipesPanel.recipeFilterPanel
    local recipeListPanel = handCraftPanel.recipesPanel.recipeListPanel.recipeListPanel
    local itemName = item:getScriptItem():getDisplayName()

    handCraftPanel:setRecipeFilter(itemName, "InputName")
    recipeFilterPanel.filterTypeCombo:selectData("InputName")
    recipeFilterPanel.entryBox:setText(itemName)

    local items = recipeListPanel.items
    if items and #items > 0 then
        handCraftPanel.logic:setRecipe(items[1].item)
    end
end

WhatCanICraft.onFillInventoryObjectContextMenu=function(playerIndex, table, items)
    if not items or #items < 1 then
        return
    end

    local baseItem = items[1]
    if not baseItem then
        return
    elseif not instanceof(baseItem, "InventoryItem") then
        baseItem = baseItem.items[1]
    end

    table:addOption(getText("ContextMenu_WhatCanICraft"), baseItem, WhatCanICraft.showRecipes, playerIndex);

end

Events.OnFillInventoryObjectContextMenu.Add(WhatCanICraft.onFillInventoryObjectContextMenu)