import QtGraphicalEffects 1.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Item {
    id: root
    width: 1920
    height: 1080

    property string mainFont: {
	    var fonts = Qt.fontFamilies()

	    for (var i = 0; i < fonts.lenght; i++) {
		if (fonts[i].toLowerCase().indexOf("audiowide") !== -1) {
		   console.log("found Audiowide:", fonts[i])
		   return fonts[i]
		}
	    }
	    
	    console.log("Audiowide not found", config.font || "Sans")
	    return config.font || "Sans"
    }

    
    // Background
    Image {
        id: background
        anchors.fill: parent
        source: config.background || "assets/wallpaper.jpg" // YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER YOUR WALLPAPER
	fillMode: Image.PreserveAspectCrop
    }
    
    // Date
    Text {
        id: dateText
        anchors.horizontalCenter: parent.horizontalCenter
        y: config.dateY || 20
        text: Qt.formatDate(new Date(), config.dateFormat || "ddd, d MMM yyyy")
        font {
	    family: mainFont
	    pixelSize: parseInt(config.dateFontSize) || 32
            bold: true
        }
        color: config.dateColor || (0 ,0, 0, 0.3)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    
    // Time
    Text {
        id: timeText
        anchors.horizontalCenter: parent.horizontalCenter
        y: config.timeY || 45
        text: Qt.formatTime(new Date(), config.timeFormat || "hh:mm")
        font {
	    family: mainFont
            pixelSize: parseInt(config.timeFontSize) || 160
            bold: false
        }
        color: config.timeColor || (0, 0, 0, 0.3)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    
    // Avatar
Item {
    width: 50; height: 50 // AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE AVATAR SIZE
    anchors.horizontalCenter: parent.horizontalCenter
	anchors.top: parent.top
	anchors.topMargin: 951 //AVATAR POZITION (> - TO BOT, < - TO TOP) AVATAR POZITION (> - TO BOT, < - TO TOP) AVATAR POZITION (> - TO BOT, < - TO TOP) AVATAR POZITION (> - TO BOT, < - TO TOP) AVATAR POZITION (> - TO BOT, < - TO TOP) AVATAR POZITION (> - TO BOT, < - TO TOP) AVATAR POZITION (> - TO BOT, < - TO TOP) AVATAR POZITION (> - TO BOT, < - TO TOP) AVATAR POZITION (> - TO BOT, < - TO TOP) AVATAR POZITION (> - TO BOT, < - TO TOP) AVATAR POZITION (> - TO BOT, < - TO TOP) 

    Image {
        id: userAvatar
        source: "assets/avatar.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop 
        visible: false
    }

    Rectangle {
        id: maskCircle
        anchors.fill: parent
        radius: 80
        visible: false
    }

    OpacityMask {
        anchors.fill: userAvatar
        source: userAvatar
        maskSource: maskCircle
    }

    Rectangle {
        anchors.fill: parent
        radius: 80
        color: "transparent"
        border.color: "#FF3B30"
        border.width: 1
    }
}
    
    // Password menu
    Rectangle {
        id: passwordField
        width: parseInt(config.passwordFieldWidth) || 180
        height: parseInt(config.passwordFieldHeight) || 40
        radius: parseInt(config.passwordFieldRadius) || 20
        color: config.passwordFieldColor || "#0000"
        border {
            width: parseInt(config.passwordFieldBorderWidth) || 2
            color: config.passwordFieldBorderColor || "#FF0000"
        }
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 15
        }
        
        Text {
            id: placeholder
            anchors.centerIn: parent
            text: config.passwordPlaceholder || "ENTER PASSWORD"
            font {
                family: mainFont
                pixelSize: parseInt(config.passwordPlaceholderSize) || 12
            }
            color: config.passwordPlaceholderColor || "#FF0000"
            visible: passwordText.text.length === 0
        }
        
        TextInput {
            id: passwordText
            anchors.centerIn: parent
            width: parent.width - 40
            height: parent.height
            font {
                family: mainFont
                pixelSize: parseInt(config.passwordTextSize) || 32
            }
            color: config.passwordTextColor || "#FF0000"
            echoMode: TextInput.Password
            passwordCharacter: "•"
            maximumLength: 128
	    cursorVisible: false
	    cursorPosition: text.lenght
            focus: true
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
	    selectByMouse: false
	    cursorDelegate: Item {

	    }
            
            Keys.onEnterPressed: {
		    sddm.login(userModel.lastUser, passwordText.text, sessionModel.lastSession)
		    passwordText.text = ""
	    }
	    Keys.onReturnPressed: {
		    sddm.login(userModel.lastUser, passwordText.text, sessionModel.lastSession)
		    passwordText.text = ""
            }
        }
    }
    
    // Buttons
    Row {
        id: powerButtons
        anchors {
            top: parent.top
            right: parent.right
            margins: 20
        }
        spacing: 10
        
        // Session button
        Rectangle {
            id: sessionButton
            width: parseInt(config.buttonSize) || 32
            height: parseInt(config.buttonSize) || 32
            radius: 5
            color: "transparent"
            
            Image {
                anchors.fill: parent
                source: config.sessionButtonIcon || "assets/session.png"
                fillMode: Image.PreserveAspectFit
            }
            
            MouseArea {
                anchors.fill: parent
                onClicked: sessionMenu.visible = !sessionMenu.visible
            }
            
            // Session menu
            Rectangle {
                id: sessionMenu
                width: 210
                height: sessionListView.contentHeight + 20
                x: -width + parent.width
                y: parent.height + 5
                radius: parseInt(config.sessionMenuRadius) || 10
                color: config.sessionMenuColor || "#000000"
                visible: false
                clip: true
                
                ListView {
                    id: sessionListView
                    anchors {
                        fill: parent
                        margins: 10
                    }
                    model: sessionModel
                    delegate: ItemDelegate {
                        width: parent.width
                        height: 30
                        text: name
                        font {
                            family: mainFont
                            pixelSize: 12
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: config.sessionMenuFontColor || "#FF0000"
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle {
                            color: "transparent"
                            radius: 5
                        }
                        onClicked: {
                            sessionModel.currentSession = name
                            sessionMenu.visible = false
                        }
                    }
                }
            }
        }
        
        // Sleep button
        Rectangle {
            id: suspendButton
            width: parseInt(config.buttonSize) || 32
            height: parseInt(config.buttonSize) || 32
            radius: 5
            color: "transparent"
            
            Image {
                anchors.fill: parent
                source: config.suspendButtonIcon || "assets/suspend.png"
                fillMode: Image.PreserveAspectFit
            }
            
            MouseArea {
                anchors.fill: parent
                onClicked: sddm.suspend()
            }
        }
        
        // Reboot button
        Rectangle {
            id: restartButton
            width: parseInt(config.buttonSize) || 32
            height: parseInt(config.buttonSize) || 32
            radius: 5
            color: "transparent"
            
            Image {
                anchors.fill: parent
                source: config.restartButtonIcon || "assets/restart.png"
                fillMode: Image.PreserveAspectFit
            }
            
            MouseArea {
                anchors.fill: parent
		onClicked: sddm.reboot()
            }
        }
        
        // Poweroff button
        Rectangle {
            id: powerButton
            width: parseInt(config.buttonSize) || 32
            height: parseInt(config.buttonSize) || 32
            radius: 5
            color: "transparent"
            
            Image {
                anchors.fill: parent
                source: config.powerButtonIcon || "assets/power.png"
                fillMode: Image.PreserveAspectFit
            }
            
            MouseArea {
                anchors.fill: parent
                onClicked: sddm.powerOff()
            }
        }
    }
    
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            dateText.text = Qt.formatDate(new Date(), config.dateFormat || "ddd, d MMM yyyy")
            timeText.text = Qt.formatTime(new Date(), config.timeFormat || "hh:mm")
        }
    }
    
    Component.onCompleted: {
        passwordText.forceActiveFocus()
    }
}
