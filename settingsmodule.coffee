############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("settingsmodule")
#endregion

############################################################
settingsButton = document.getElementById("settings-button")
settingsoffButton = document.getElementById("settingsoff-button")

############################################################
currentlyShownSettingspage = null

############################################################
export initialize = ->
    log "initialize"
    settingsButton.addEventListener("click", settingsButtonClicked)
    settingsoffButton.addEventListener("click", settingsoffButtonClicked)
    
    #specific settings
    settingsButtons = document.getElementsByClassName("settings-entry")
    for b in settingsButtons
        id = b.id.replace("settingsbutton-", "settingspage-")
        fun = createShowSettingsFunctionFor(id)
        b.addEventListener("click", fun)
    
    #Implement or Remove :-)
    backButtons = document.getElementsByClassName("settingspage-backbutton")
    b.addEventListener("click", settingsBackButtonClicked) for b in backButtons
    return

############################################################
#region eventListeners
settingsButtonClicked = ->
    settingsButton.classList.add("on")
    document.body.classList.add("settings")

settingsoffButtonClicked = ->
    document.body.classList.remove("settings") 
    return

############################################################
createShowSettingsFunctionFor = (id) ->
    page = document.getElementById(id)
    return () -> showSettingsPage(page)
showSettingsPage = (page) ->
    currentlyShownSettingspage = page
    currentlyShownSettingspage.classList.add("here")
    return

############################################################
settingsBackButtonClicked = ->
    return unless currentlyShownSettingspage?
    currentlyShownSettingspage.classList.remove("here")
    currentlyShownSettingspage = null
    # document.body.classList.remove("away")
    # mainframe.classList.remove("zoomed-out")
    return

#endregion