############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("settingsmodule")
#endregion

############################################################
import * as triggers from "./navtriggers.js"

############################################################
settingsButton = document.getElementById("settings-button")
settingsoffButton = document.getElementById("settingsoff-button")

############################################################
currentlyShownSettingspage = null

settingsTrigger = {
    account: triggers.settingsAccount
    backend: triggers.settingsBackend
}

############################################################
export initialize = ->
    log "initialize"
    settingsButton.addEventListener("click", settingsButtonClicked)
    settingsoffButton.addEventListener("click", settingsoffButtonClicked)
    
    #specific settings
    settingsEntries = document.getElementsByClassName("settings-entry")
    for entry in settingsEntries
        id = entry.id.replace("settingsentry-", "settingspage-")
        fun = createShowSettingsFunctionFor(id)
        entry.addEventListener("click", fun)
    
    #Implement or Remove :-)
    backButtons = document.getElementsByClassName("settingspage-backbutton")
    b.addEventListener("click", settingsBackButtonClicked) for b in backButtons
    return

############################################################
#region eventListeners
settingsButtonClicked = ->
    triggers.settingsOn()
    return

settingsoffButtonClicked = ->
    triggers.back()
    return

############################################################
createShowSettingsFunctionFor = (id) ->
    page = document.getElementById(id)
    return () -> showSettingsPage(page)

showSettingsPage = (page) ->
    id = page.id.replace("settingspage-", "")
    log "showSettingsPage #{id}"

    if settingsTrigger[id]? then return settingsTrigger[id]()
    log "settingsTrigger was not defined!"
    # currentlyShownSettingspage = page
    # currentlyShownSettingspage.classList.add("here")
    return

hideCurrentSettingsPage = ->
    return unless currentlyShownSettingspage?
    currentlyShownSettingspage.classList.remove("here")
    currentlyShownSettingspage = null
    return

############################################################
settingsBackButtonClicked = ->
    triggers.back()
    return

#endregion

############################################################
export switchSettingsOn = (pageId) ->
    log "switchSettingsOn"
    settingsButton.classList.add("on")
    document.body.classList.add("settings")

    hideCurrentSettingsPage()

    if pageId?
        page = document.getElementById("settingspage-#{pageId}")
        currentlyShownSettingspage = page
        currentlyShownSettingspage.classList.add("here")

    return

############################################################
export switchSettingsOff = ->
    log "switchSettingsOff"
    document.body.classList.remove("settings") 
    settingsButton.classList.remove("on")

    hideCurrentSettingsPage()
    return